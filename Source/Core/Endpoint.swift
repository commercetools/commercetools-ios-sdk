//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

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
    
    associatedtype ResponseType: Mappable

    static var path: String { get }

}

public extension Endpoint {

    /// The full path used to form requests for endpoints.
    static var fullPath: String? {
        if let config = Config.currentConfig, let apiUrl = config.apiUrl, let projectKey = config.projectKey {
            return "\(apiUrl)\(projectKey)/"
                    + (path.hasPrefix("/") ? path.substring(from: path.characters.index(path.startIndex, offsetBy: 1)) : path)
                    + (path.hasSuffix("/") ? "" : "/")
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
        if let expansion = expansion, expansion.count > 0 {
            var pathWithExpansion = path.hasSuffix("/") ? path.substring(to: path.characters.index(path.endIndex, offsetBy: -1)) : path
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
        var headers = SessionManager.defaultHTTPHeaders
        headers["Authorization"] = "Bearer \(token)"
        return headers
    }

    /**
        This method provides default response handling from all endpoints, providing successful result in dictionary format.

        - parameter token:                    Auth token to be included in the headers.
        - parameter result:                   The code to be executed after processing the response, providing response
                                              in dictionary format in case of a successful result.
    */
    static func handleResponse<T>(_ response: DataResponse<Any>, result: (Result<T>) -> Void) {
        if let responseDict = response.result.value as? [String: Any], let response = response.response, case 200 ... 299 = response.statusCode {
            result(Result.success(responseDict))
        } else {
            checkResponseForErrors(response: response, result: result)
        }
    }
    
    static func checkResponseForErrors<T>(response: DataResponse<Any>, result: (Result<T>) -> Void) {
        if let responseDict = response.result.value as? [String: AnyObject], let response = response.response {
            if let errorsResponse = responseDict["errors"] as? [[String: AnyObject]] {
                var errors = [CTError]()
                errorsResponse.forEach {
                    errors += [CTError(code: $0["code"] as? String ?? "", failureMessage: $0["message"] as? String,
                                       failureDetails: $0["detailedErrorMessage"] as? String, currentVersion: $0["currentVersion"] as? UInt)]
                }
                result(Result.failure(response.statusCode, errors))
                
            } else {
                result(Result.failure(response.statusCode, [CTError.generalError(reason: CTError.FailureReason(message: responseDict["error"] as? String, details: nil))]))
            }
        } else {
            result(Result.failure(response.response?.statusCode, [response.result.error ?? CTError.generalError(reason: nil)]))
        }
    }

    /**
        Convenience method for performing requests with authorization token, providing general configuration error handling.

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
