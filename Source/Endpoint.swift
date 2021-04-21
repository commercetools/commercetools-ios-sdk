//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Base type which all endpoints must conform to.

    Types adopting the `Endpoint` protocol can be used to retrieve the full path, from the relative, based on
    the current Commercetools configuration, using `fullPath: String?` calculated property.

    They can also take the advantage of retrieving the default headers for an auth token,
    using `static func headers(token: String) -> [String: String]`.

    Many endpoints adopting this protocol can support property expansion, and use
    `static func pathWithExpansion(path: String, expansion: [String]) -> String` in order to easily
    form the full path, regardless of the request method.

    Finally, default `Endpoint` extension provides easy Commercetools response handling, using
    `static func handleResponse`.
*/
public protocol Endpoint {
    
    associatedtype ResponseType: Codable

    static var path: String { get }

}

/**
    Type used for endpoints which do not have any model specified yet.
*/
public struct NoMapping: Codable {}

public extension Endpoint {

    /// The full path used to form requests for endpoints.
    static func fullPath(relativePath: String = Self.path) -> String? {
        if let config = Config.currentConfig, let apiUrl = config.apiUrl, let projectKey = config.projectKey {
            guard !relativePath.isEmpty else { return "\(apiUrl)\(projectKey)/" }
            var normalizedPath = relativePath
            if normalizedPath.hasPrefix("/") {
                normalizedPath.removeFirst()
            }
            return "\(apiUrl)\(projectKey)/\(normalizedPath)" + (path.hasSuffix("/") ? "" : "/")
        }
        return nil
    }

    /**
        Appends expansion parameters at the end of the provided path.

        - parameter path:                     The base path without expansion parameters.
        - parameter expansion:                An array of expansion property names.

        - returns: The full path with expansion parameters included.
    */
    static func pathWithExpansion(_ path: String, expansion: [String]?) -> String {
        if let expansion = expansion?.map({ $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "" }), expansion.count > 0 {
            var pathWithExpansion = path
            if pathWithExpansion.hasSuffix("/") {
                pathWithExpansion.removeLast()
            }
            pathWithExpansion += "?expand=" + expansion.joined(separator: "&expand=")
            return pathWithExpansion

        } else {
            return path
        }
    }

    /**
        Provides default headers to be used for all endpoint requests.

        - parameter token:                    Auth token to be included in the headers.

        - returns: Headers containing auth token, along with default values for
                   the "Accept-Encoding", "Accept-Language" and "User-Agent" headers.
    */
    static func headers(_ token: String) -> [String: String] {
        var headers = defaultHeaders
        headers["Authorization"] = "Bearer \(token)"
        return headers
    }

    /**
        This method provides default response handling from all endpoints, providing successful result in dictionary format.

        - parameter response:                 Received `Data`.
        - parameter response:                 Received `URLResponse`.
        - parameter response:                 Received `Error`.
        - parameter result:                   The code to be executed after processing the response, providing response
                                              in dictionary format in case of a successful result.
    */
    static func handleResponse<T>(data: Data?, response: URLResponse?, error: Error?, result: (Result<T>) -> Void) {
        if let data = data, let statusCode = (response as? HTTPURLResponse)?.statusCode, case 200 ... 299 = statusCode {
            result(Result.success(data))
        } else {
            checkResponseForErrors(data: data, response: response, error: error, result: result)
        }
    }
    
    static func checkResponseForErrors<T>(data: Data?, response: URLResponse?, error: Error?, result: (Result<T>) -> Void) {
        if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
           let responseDict = jsonObject as? [String: Any], let statusCode = (response as? HTTPURLResponse)?.statusCode {
            if let errorsResponse = responseDict["errors"] as? [[String: AnyObject]] {
                var errors = [CTError]()
                errorsResponse.forEach {
                    errors += [CTError(code: $0["code"] as? String ?? "", failureMessage: $0["message"] as? String,
                            failureDetails: $0["detailedErrorMessage"] as? String, currentVersion: $0["currentVersion"] as? UInt)]
                }
                result(Result.failure(statusCode, errors))

            } else {
                result(Result.failure(statusCode, [CTError.generalError(reason: CTError.FailureReason(message: responseDict["error"] as? String, details: nil))]))
            }
        } else {
            result(Result.failure((response as? HTTPURLResponse)?.statusCode, [error ?? CTError.generalError(reason: nil)]))
        }
    }

    /**
        Convenience method for performing requests with authorization token, providing general configuration error handling.

        - parameter result:                   The code to be executed in case an error occurs.
        - parameter requestHandler:           The code to be executed if no error occurs, providing token and path.
    */
    static func requestWithTokenAndPath<T>(relativePath: String = Self.path, result: @escaping (Result<T>) -> Void, requestHandler: @escaping (String, String) -> Void) {
        guard let config = Config.currentConfig, let path = fullPath(relativePath: relativePath), config.validate() else {
            Log.error("Cannot execute command - check if the configuration is valid.")
            result(Result.failure(nil, [CTError.generalError(reason: nil)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.failure(nil, [error ?? CTError.generalError(reason: nil)]))
                return
            }
            requestHandler(token, path)
        }
    }

    static func request(url: String, method: HTTPMethod = .get, urlParameters: [String: String] = [:], json: [String: Any]? = nil, formParameters: [String: String]? = nil, headers: [String: String] = [:]) -> URLRequest {
        guard json == nil || formParameters == nil else {
            fatalError("Cannot use both json and formParameters in the same URLRequest")
        }
        var queryItems = [URLQueryItem]()
        urlParameters.forEach {
            queryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        var jsonData: Data?
        if let json = json, let data = try? JSONSerialization.data(withJSONObject: json, options: []) {
            jsonData = data
        }

        return request(url: url, method: method, queryItems: queryItems, json: jsonData, formParameters: formParameters?.map({ FormParameter(key: $0, value: $1) }), headers: headers)
    }

    static func request(url: String, method: HTTPMethod = .get, queryItems: [URLQueryItem], json: Data? = nil, formParameters: [FormParameter]? = nil, headers: [String: String] = [:]) -> URLRequest {
        guard json == nil || formParameters == nil else {
            fatalError("Cannot use both json and formParameters in the same URLRequest")
        }
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = queryItems + (urlComponents.queryItems ?? [])

        let urlString = urlComponents.string!.replacingOccurrences(of: "+", with: "%2B")
        var urlRequest = URLRequest(url: URL(string: urlString)!)
        urlRequest.httpMethod = method.rawValue
        headers.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        if method == .post || method == .put || method == .patch || method == .delete {
            urlRequest.setValue(json != nil ? "application/json" : "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

        if let json = json {
            urlRequest.httpBody = json
        } else if let formParameters = formParameters, !formParameters.isEmpty {
            let body = formParameters.map({ "\($0.key.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) ?? "")=\($0.value.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) ?? "")" }).joined(separator: "&")
            urlRequest.httpBody = body.data(using: .utf8)
        }

        return urlRequest
    }

    static func perform<T>(request: URLRequest, result: @escaping (Result<T>) -> Void) {
        urlSession.dataTask(with: request, completionHandler: { data, response, error in
            self.handleResponse(data: data, response: response, error: error) { (res: Result<T>) in
                if res.errors?.contains(where: { ($0 as? CTError) == CTError.invalidToken }) == true {
                    AuthManager.sharedInstance.recoverFromInvalidTokenError { newToken, error in
                        if let newToken = newToken {
                            var updatedRequest = request
                            self.headers(newToken).forEach {
                                updatedRequest.setValue($0.value, forHTTPHeaderField: $0.key)
                            }
                            DispatchQueue.global().async {
                                self.perform(request: updatedRequest, result: result)
                            }
                        } else {
                            result(res)
                        }
                    }

                } else {
                    result(res)
                }
            }
        }).resume()
    }
}

public protocol MLEndpoint: Endpoint {}

public extension MLEndpoint {
    /// The full path used to form requests for ML endpoints.
    static var fullPath: String? {
        guard let config = Config.currentConfig, let apiUrl = config.machineLearningApiUrl, let projectKey = config.projectKey else {
            Log.error("Cannot use ML endpoints without valid configuration including machineLearningApiUrl.")
            return nil
        }
        var normalizedPath = path
        if normalizedPath.hasPrefix("/") {
            normalizedPath.removeFirst()
        }
        return "\(apiUrl)\(projectKey)/\(normalizedPath)"
    }

    /**
        Convenience method for performing ML requests with authorization token, providing general configuration error handling.

        - parameter result:                   The code to be executed in case an error occurs.
        - parameter requestHandler:           The code to be executed if no error occurs, providing token and path.
    */
    static func requestWithTokenAndPath<T>(_ result: @escaping (Result<T>) -> Void, _ requestHandler: @escaping (String, String) -> Void) {
        guard let config = Config.currentConfig, let path = fullPath, config.validate() else {
            Log.error("Cannot execute command - check if the configuration is valid.")
            result(Result.failure(nil, [CTError.generalError(reason: nil)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.failure(nil, [error ?? CTError.generalError(reason: nil)]))
                return
            }
            requestHandler(token, path)
        }
    }
}

var urlSession: URLSession = {
    var configuration = URLSessionConfiguration.default
    configuration.httpMaximumConnectionsPerHost = 8
    return URLSession(configuration: configuration)
}()

/// HTTP method definitions.
///
/// See https://tools.ietf.org/html/rfc7231#section-4.3
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

var defaultHeaders: [String: String] = {
    // Accept-Encoding HTTP Header; see https://tools.ietf.org/html/rfc7230#section-4.2.3
    let acceptEncoding: String = "gzip;q=1.0, compress;q=0.5"
    // Accept-Language HTTP Header; see https://tools.ietf.org/html/rfc7231#section-5.3.5
    let acceptLanguage = Locale.preferredLanguages.prefix(6).enumerated().map { enumeratedLanguage in
        let (index, languageCode) = enumeratedLanguage
        let quality = 1.0 - (Double(index) * 0.1)
        return "\(languageCode);q=\(quality)"
    }.joined(separator: ", ")
    return [
        "Accept-Encoding": acceptEncoding,
        "Accept-Language": acceptLanguage,
        "User-Agent": userAgent
    ]
}()

/// The full user agent header sent with requests to the platform.
var userAgent: String = {
    let commercetoolsSDK: String = {
        #if !os(Linux)
        let commercetoolsSDKVersion = Bundle(for: Config.self).infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "commercetools-ios-sdk/\(commercetoolsSDKVersion)"
        #else
        return "commercetools-swift-sdk"
        #endif
    }()
    let osNameVersion: String = {
        let version = ProcessInfo.processInfo.operatingSystemVersion

        let osName: String = {
            #if os(iOS)
                return "iOS"
            #elseif os(watchOS)
                return "watchOS"
            #elseif os(tvOS)
                return "tvOS"
            #elseif os(macOS)
                return "macOS"
            #elseif os(Linux)
                return "Linux"
            #else
                return "Unknown"
            #endif
        }()

        return "\(osName)/\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
    }()

    #if !os(Linux)
    if let info = Bundle.main.infoDictionary {
        let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
        let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"

        if let config = Config.currentConfig, let emergencyContactInfo = config.emergencyContactInfo, config.validate() {
            return "\(commercetoolsSDK) \(osNameVersion) \(executable)/\(appVersion) (+\(emergencyContactInfo))"
        }

        return "\(commercetoolsSDK) \(osNameVersion) \(executable)/\(appVersion)"
    }
    #endif

    return "\(commercetoolsSDK) \(osNameVersion)"
}()

public struct FormParameter {
    public let key: String
    public let value: String
}
