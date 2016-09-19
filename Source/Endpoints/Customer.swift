//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    Provides complete set of interactions for retrieving current customer profile, signing up,
    updating and profile deletion.
*/
open class Customer: Endpoint {

    // MARK: - Properties

    open static let path = "me"

    // MARK: - Customer endpoint functionality

    /**
        Retrieves customer profile for the currently logged in user.

        - parameter result:                   The code to be executed after processing the response.
    */
    open static func profile(_ result: @escaping (Result<[String: Any]>) -> Void) {
        customerProfileAction(method: .get, result: result)
    }

    /**
        Creates new customer with specified profile.

        - parameter profile:                  Dictionary representation of the draft customer profile to be created.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func signup(_ profile: [String: Any], result: @escaping (Result<[String: Any]>) -> Void) {
        customerProfileAction(method: .post, basePath: "signup", parameters: profile, encoding: JSONEncoding.default, result: result)
    }

    /**
        Updates current customer profile.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func update(version: UInt, actions: [[String: Any]], result: @escaping (Result<[String: Any]>) -> Void) {
        customerProfileAction(method: .post, parameters: ["version": version, "actions": actions], encoding: JSONEncoding.default, result: result)
    }

    /**
        Deletes customer profile for the currently logged in user.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func delete(version: UInt, result: @escaping (Result<[String: Any]>) -> Void) {
        customerProfileAction(method: .delete, parameters: ["version": version], result: result)
    }

    // MARK: - Password management

    /**
        Changes password for the currently logged in user.

        - parameter currentPassword:          The current password.
        - parameter newPassword:              The new password.
        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func changePassword(currentPassword: String, newPassword: String, version: UInt,
                               result: @escaping (Result<[String: Any]>) -> Void) {

        customerProfileAction(method: .post, basePath: "password", parameters: ["currentPassword": currentPassword,
                              "newPassword": newPassword, "version": version], encoding: JSONEncoding.default, result: { changePasswordResult in

            if let response = changePasswordResult.response, let email = response["email"] as? String , changePasswordResult.isSuccess {
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
    open static func resetPassword(token: String, newPassword: String, result: @escaping (Result<[String: Any]>) -> Void) {

        customerProfileAction(method: .post, basePath: "password/reset", parameters: ["tokenValue": token,
                              "newPassword": newPassword], encoding: JSONEncoding.default, result: result)
    }

    /**
        Verifies email address for the user with matching token. Most common use case for this method is if your app
        handles custom URLs, so you can process user's tap on the account activation link (e.g in mail).

        - parameter token:                    The token obtained from the customers/email-token endpoint.
                                              Usually parsed from the account activation URL.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func verifyEmail(token: String, result: @escaping (Result<[String: Any]>) -> Void) {

        customerProfileAction(method: .post, basePath: "email/confirm", parameters: ["tokenValue": token],
                              encoding: JSONEncoding.default, result: result)
    }

    // MARK: - Helpers

    private static func customerProfileAction(method: HTTPMethod, basePath: String? = nil,
                                              parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default,
                                              result: @escaping (Result<[String: Any]>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            Alamofire.request(path + (basePath ?? ""), method: method, parameters: parameters, encoding: encoding, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }

}
