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
    open static func profile(_ result: @escaping (Result<[String: AnyObject]>) -> Void) {
        customerProfileAction(method: .get, result: result)
    }

    /**
        Creates new customer with specified profile.

        - parameter profile:                  Dictionary representation of the draft customer profile to be created.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func signup(_ profile: [String: AnyObject], result: @escaping (Result<[String: AnyObject]>) -> Void) {
        customerProfileAction(method: .post, basePath: "signup", parameters: profile, encoding: URLEncoding.httpBody, result: result)
    }

    /**
        Updates current customer profile.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func update(version: UInt, actions: [[String: AnyObject]], result: @escaping (Result<[String: AnyObject]>) -> Void) {
        customerProfileAction(method: .post, parameters: ["version": version as NSNumber, "actions": actions as AnyObject], encoding: URLEncoding.httpBody, result: result)
    }

    /**
        Deletes customer profile for the currently logged in user.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func delete(version: UInt, result: @escaping (Result<[String: AnyObject]>) -> Void) {
        customerProfileAction(method: .delete, parameters: ["version": version as NSNumber], result: result)
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
                               result: @escaping (Result<[String: AnyObject]>) -> Void) {

        customerProfileAction(method: .post, basePath: "password", parameters: ["currentPassword": currentPassword as NSString,
                              "newPassword": newPassword as NSString, "version": version as NSNumber], encoding: URLEncoding.httpBody, result: { changePasswordResult in

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
    open static func resetPassword(token: String, newPassword: String, result: @escaping (Result<[String: AnyObject]>) -> Void) {

        customerProfileAction(method: .post, basePath: "password/reset", parameters: ["tokenValue": token as NSString,
                              "newPassword": newPassword as NSString], encoding: URLEncoding.httpBody, result: result)
    }

    /**
        Verifies email address for the user with matching token. Most common use case for this method is if your app
        handles custom URLs, so you can process user's tap on the account activation link (e.g in mail).

        - parameter token:                    The token obtained from the customers/email-token endpoint.
                                              Usually parsed from the account activation URL.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func verifyEmail(token: String, result: @escaping (Result<[String: AnyObject]>) -> Void) {

        customerProfileAction(method: .post, basePath: "email/confirm", parameters: ["tokenValue": token as NSString],
                              encoding: URLEncoding.httpBody, result: result)
    }

    // MARK: - Helpers

    fileprivate static func customerProfileAction(method: HTTPMethod, basePath: String? = nil,
                                              parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = URLEncoding.default,
                                              result: @escaping (Result<[String: AnyObject]>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            Alamofire.request(path + (basePath ?? ""), method: method, parameters: parameters, encoding: encoding, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }

}
