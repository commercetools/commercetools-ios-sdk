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

    // MARK: - Customer endpoint functionality

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

    // MARK: - Password management

    /**
        Changes password for the currently logged in user.

        - parameter currentPassword:          The current password.
        - parameter newPassword:              The new password.
        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter result:                   The code to be executed after processing the response.
    */
    static func changePassword(currentPassword currentPassword: String, newPassword: String, version: UInt,
                               result: (Result<[String: AnyObject], NSError>) -> Void) {

        customerProfileAction(method: .POST, basePath: "password", parameters: ["currentPassword": currentPassword,
                              "newPassword": newPassword, "version": version], encoding: .JSON, result: { changePasswordResult in

            if let response = changePasswordResult.response, email = response["email"] as? String where changePasswordResult.isSuccess {
                AuthManager.sharedInstance.loginUser(email, password: newPassword, completionHandler: { error in
                    if let error = error {
                        Log.error("Could not login automatically after password change "
                                + (error.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? ""))
                    }
                })
            }
            result(changePasswordResult)
        })
    }

    /**
        Resets password for the user with matching token. Most common use case for this method is if your app
        handles custom URLs, so you can process user's tap on the password reset link (e.g in mail).

        - parameter token:                    The token obtained from the customers/password-token endpoint.
                                              Usually parsed from the reset password URL.
        - parameter newPassword:              The new password.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func resetPassword(token token: String, newPassword: String, result: (Result<[String: AnyObject], NSError>) -> Void) {

        customerProfileAction(method: .POST, basePath: "password/reset", parameters: ["tokenValue": token,
                              "newPassword": newPassword], encoding: .JSON, result: result)
    }

    /**
        Verifies email address for the user with matching token. Most common use case for this method is if your app
        handles custom URLs, so you can process user's tap on the account activation link (e.g in mail).

        - parameter token:                    The token obtained from the customers/email-token endpoint.
                                              Usually parsed from the account activation URL.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func verifyEmail(token token: String, result: (Result<[String: AnyObject], NSError>) -> Void) {

        customerProfileAction(method: .POST, basePath: "email/confirm", parameters: ["tokenValue": token],
                              encoding: .JSON, result: result)
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