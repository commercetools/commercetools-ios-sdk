//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    Provides complete set of interactions for retrieving current customer profile, signing up,
    updating and profile deletion.
*/
public class Customer: Endpoint {

    // MARK: - Properties

    public static let path = "me"

    // MARK: - Customer endpoint functionalities

    /**
        Retrieves customer profile for the currently logged in user.

        - parameter result:                   The code to be executed after processing the response.
    */
    static func profile(result: (Result<[String: AnyObject], NSError>) -> Void) {
        customerProfileAction(method: .GET, result: result)
    }

    /**
        Creates new customer with specified profile.

        - parameter profile:                  Dictionary representation of the draft customer profile to be created.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func signup(profile: [String: AnyObject], result: (Result<[String: AnyObject], NSError>) -> Void) {
        customerProfileAction(method: .POST, basePath: "signup", parameters: profile, encoding: .JSON, result: result)
    }

    /**
        Updates current customer profile.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func update(version version: UInt, actions: [[String: AnyObject]], result: (Result<[String: AnyObject], NSError>) -> Void) {
        customerProfileAction(method: .POST, parameters: ["version": version, "actions": actions], encoding: .JSON, result: result)
    }

    /**
        Deletes customer profile for the currently logged in user.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter result:                   The code to be executed after processing the response.
    */
    static func delete(version version: UInt, result: (Result<[String: AnyObject], NSError>) -> Void) {
        customerProfileAction(method: .DELETE, parameters: ["version": version], result: result)
    }

    private static func customerProfileAction(method method: Alamofire.Method, basePath: String? = nil,
                                              parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .URL,
                                              result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot perform customer profile actions - check if the configuration is valid.")
            result(Result.Failure([Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            Alamofire.request(method, path + (basePath ?? ""), parameters: parameters, encoding: encoding, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }

}