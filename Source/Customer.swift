//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides complete set of interactions for retrieving current customer profile, signing up,
    updating and profile deletion.
*/
public class Customer: Endpoint, Codable {
    
    public typealias ResponseType = Customer

    public static let path = "me"

    // MARK: - Customer endpoint functionality

    /**
        Retrieves customer profile for the currently logged in user.

        - parameter result:                   The code to be executed after processing the response.
    */
    public static func profile(expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .get, expansion: expansion, result: result)
    }

    /**
        Performs login operation in order to migrate carts and orders for anonymous user, when the login credentials
        have been supplied.

        - parameter username:               The user's username.
        - parameter password:               The user's password.
        - parameter activeCartSignInMode:   Optional sign in mode, specifying whether the cart line items should be merged.
        - parameter completionHandler:      The code to be executed once the token fetching completes.
    */
    static func login(username: String, password: String, activeCartSignInMode: AnonymousCartSignInMode?,
                      result: @escaping (Result<CustomerSignInResult>) -> Void) {
        var userDetails = ["email": username, "password": password]
        if let activeCartSignInMode = activeCartSignInMode {
            userDetails["activeCartSignInMode"] = activeCartSignInMode.rawValue
        }
        requestWithTokenAndPath(result: result) { token, path in
            let request = self.request(url: "\(path)login", method: .post, json: userDetails, headers: self.headers(token))

            perform(request: request) { (response: Result<CustomerSignInResult>) in
                result(response)
            }
        }
    }

    /**
        Creates new customer with specified profile.

        - parameter profile:                  Dictionary representation of the draft customer profile to be created.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func signUp(_ profile: Data, result: @escaping (Result<CustomerSignInResult>) -> Void) {
        requestWithTokenAndPath(result: result) { token, path in
            let request = self.request(url: "\(path)signup", method: .post, queryItems: [], json: profile, headers: self.headers(token))

            perform(request: request) { (response: Result<CustomerSignInResult>) in
                result(response)
            }
        }
    }

    /**
        Updates current customer profile.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter actions:                  `UpdateActions<CustomerUpdateAction>`instance, containing correct version and update actions.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func update(actions: UpdateActions<CustomerUpdateAction>, result: @escaping (Result<ResponseType>) -> Void) {        
        customerProfileAction(method: .post, json: actions.toJSON, result: result)
    }

    /**
        Updates current customer profile.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func update(version: UInt, actions: [[String: Any]], result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .post, json: ["version": version, "actions": actions], result: result)
    }

    /**
        Deletes customer profile for the currently logged in user.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func delete(version: UInt, result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .delete, urlParameters: ["version": String(version)], result: result)
    }

    // MARK: - Password management

    /**
        Changes password for the currently logged in user.

        - parameter currentPassword:          The current password.
        - parameter newPassword:              The new password.
        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func changePassword(currentPassword: String, newPassword: String, version: UInt,
                               result: @escaping (Result<ResponseType>) -> Void) {

        customerProfileAction(method: .post, basePath: "password", json: ["currentPassword": currentPassword,
                              "newPassword": newPassword, "version": version], result: { changePasswordResult in

            if let response = changePasswordResult.json, let email = response["email"] as? String, changePasswordResult.isSuccess {
                AuthManager.sharedInstance.loginCustomer(username: email, password: newPassword, completionHandler: { error in
                    if let error = error as? CTError {
                        Log.error("Could not login automatically after password change "
                                + (error.errorDescription ?? ""))
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
    public static func resetPassword(token: String, newPassword: String, result: @escaping (Result<ResponseType>) -> Void) {

        customerProfileAction(method: .post, basePath: "password/reset", json: ["tokenValue": token,
                              "newPassword": newPassword], result: result)
    }

    /**
        Verifies email address for the user with matching token. Most common use case for this method is if your app
        handles custom URLs, so you can process user's tap on the account activation link (e.g in mail).

        - parameter token:                    The token obtained from the customers/email-token endpoint.
                                              Usually parsed from the account activation URL.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func verifyEmail(token: String, result: @escaping (Result<ResponseType>) -> Void) {

        customerProfileAction(method: .post, basePath: "email/confirm", json: ["tokenValue": token], result: result)
    }

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let key: String?
    public let customerNumber: String?
    public let createdAt: Date
    public let createdBy: CreatedBy?
    public let lastModifiedAt: Date
    public let lastModifiedBy: LastModifiedBy?
    public let email: String
    public let password: String
    public let firstName: String?
    public let lastName: String?
    public let middleName: String?
    public let title: String?
    public let salutation: String?
    public let dateOfBirth: Date?
    public let companyName: String?
    public let vatId: String?
    public let addresses: [Address]
    public let defaultShippingAddressId: String?
    public let shippingAddressIds: [String]?
    public let defaultBillingAddressId: String?
    public let billingAddressIds: [String]?
    public let isEmailVerified: Bool
    public let externalId: String?
    public let customerGroup: Reference<CustomerGroup>?
    public let custom: JsonValue?
    public let locale: String?
    
    // MARK: - Helpers

    private static func customerProfileAction(method: HTTPMethod, basePath: String? = nil, expansion: [String]? = nil,
                                              urlParameters: [String: String] = [:], json: [String: Any]? = nil,
                                              result: @escaping (Result<ResponseType>) -> Void) {

        requestWithTokenAndPath(result: result) { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)
            let request = self.request(url: fullPath + (basePath ?? ""), method: method, urlParameters: urlParameters,
                                       json: json, headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        }
    }
}
