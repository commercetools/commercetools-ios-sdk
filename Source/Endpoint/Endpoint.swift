//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

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

    static var path: String { get }

}

public extension Endpoint {

    /// The full path used to form requests for endpoints.
    static var fullPath: String? {
        if let config = Config.currentConfig, apiUrl = config.apiUrl, projectKey = config.projectKey {
            return "\(apiUrl)\(projectKey)/"
                    + (path.hasPrefix("/") ? path.substringFromIndex(path.startIndex.advancedBy(1)) : path)
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
    static func pathWithExpansion(path: String, expansion: [String]?) -> String {
        if let expansion = expansion where expansion.count > 0 {
            var pathWithExpansion = path.hasSuffix("/") ? path.substringToIndex(path.endIndex.advancedBy(-1)) : path
            pathWithExpansion += "?expand=" + expansion.joinWithSeparator("&expand=")
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
    static func headers(token: String) -> [String: String] {
        var headers = Manager.defaultHTTPHeaders
        headers["Authorization"] = "Bearer \(token)"
        return headers
    }

    /**
        This method provides default response handling from all endpoints.

        - parameter token:                    Auth token to be included in the headers.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func handleResponse(response: Response<AnyObject, NSError>, result: (Result<[String: AnyObject], NSError>) -> Void) {
        if let responseDict = response.result.value as? [String: AnyObject], response = response.response {
            if case 200 ... 299 = response.statusCode {
                result(Result.Success(responseDict))

            } else if let errorsResponse = responseDict["errors"] as? [[String: AnyObject]] {
                var errors = [NSError]()
                errorsResponse.forEach {
                    errors += [Error.error(code: Error.Code(code: $0["code"] as? String ?? ""),
                            failureReason: $0["message"] as? String,
                            description: $0["detailedErrorMessage"] as? String)]
                }
                result(Result.Failure(errors))

            } else {
                result(Result.Failure([Error.error(code: .GeneralCommercetoolsError, failureReason: responseDict["error"] as? String)]))
            }
        } else {
            result(Result.Failure([response.result.error ?? Error.error(code: .GeneralCommercetoolsError)]))
        }
    }
}