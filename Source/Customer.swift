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

    public static let path = ""

    // MARK: - Customer endpoint functionality

    /**
        Retrieves customer profile for the currently logged in user.

        - parameter storeKey:                 For customers registered in a specific store, a store key must be specified.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func profile(expansion: [String]? = nil, storeKey: String? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .get, expansion: expansion, storeKeyPathParameter: storeKey, result: result)
    }

    /**
        Performs login operation in order to migrate carts and orders for anonymous user, when the login credentials
        have been supplied.

        - parameter username:               The user's username.
        - parameter password:               The user's password.
        - parameter activeCartSignInMode:   Optional sign in mode, specifying whether the cart line items should be merged.
        - parameter storeKey:               For customers registered in a specific store, a store key must be specified.
        - parameter completionHandler:      The code to be executed once the token fetching completes.
    */
    static func login(username: String, password: String, activeCartSignInMode: AnonymousCartSignInMode?,
                      storeKey: String?, result: @escaping (Result<CustomerSignInResult>) -> Void) {
        var userDetails = ["email": username, "password": password]
        if let activeCartSignInMode = activeCartSignInMode {
            userDetails["activeCartSignInMode"] = activeCartSignInMode.rawValue
        }
        customerProfileAction(method: .post, basePath: "login", storeKeyPathParameter: storeKey, json: userDetails, result: result)
    }

    /**
        Creates new customer with specified profile.

        - parameter profile:                  Dictionary representation of the draft customer profile to be created.
        - parameter storeKey:                 If a store key is specified, the customer will be signed up in that store.
        - parameter result:                   The code to be executed after processing the response.
    */
    static func signUp(_ profile: [String: Any], storeKey: String?, result: @escaping (Result<CustomerSignInResult>) -> Void) {
        customerProfileAction(method: .post, basePath: "signup", storeKeyPathParameter: storeKey, json: profile, result: result)
    }

    /**
        Updates current customer profile.

        - parameter actions:                  `UpdateActions<CustomerUpdateAction>`instance, containing correct version and update actions.
        - parameter storeKey:                 For customers registered in a specific store, a store key must be specified.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func update(actions: UpdateActions<CustomerUpdateAction>, storeKey: String? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .post, storeKeyPathParameter: storeKey, json: actions.toJSON, result: result)
    }

    /**
        Updates current customer profile.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter storeKey:                 For customers registered in a specific store, a store key must be specified.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func update(version: UInt, actions: [[String: Any]], storeKey: String? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .post, storeKeyPathParameter: storeKey, json: ["version": version, "actions": actions], result: result)
    }

    /**
        Deletes customer profile for the currently logged in user.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter storeKey:                 For customers registered in a specific store, a store key must be specified.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func delete(version: UInt, storeKey: String? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .delete, storeKeyPathParameter: storeKey, urlParameters: ["version": String(version)], result: result)
    }

    // MARK: - Password management

    /**
        Changes password for the currently logged in user.

        - parameter currentPassword:          The current password.
        - parameter newPassword:              The new password.
        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter storeKey:                 For customers registered in a specific store, a store key must be specified.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func changePassword(currentPassword: String, newPassword: String, version: UInt,
                               storeKey: String? = nil, result: @escaping (Result<ResponseType>) -> Void) {

        customerProfileAction(method: .post, basePath: "password", storeKeyPathParameter: storeKey, json: ["currentPassword": currentPassword,
                              "newPassword": newPassword, "version": version], result: { (changePasswordResult: Result<ResponseType>) in

            if let response = changePasswordResult.json, let email = response["email"] as? String, changePasswordResult.isSuccess {
                AuthManager.sharedInstance.loginCustomer(username: email, password: newPassword, storeKey: storeKey, completionHandler: { error in
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
        - parameter storeKey:                 For customers registered in a specific store, a store key must be specified.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func resetPassword(token: String, newPassword: String, storeKey: String? = nil, result: @escaping (Result<ResponseType>) -> Void) {

        customerProfileAction(method: .post, basePath: "password/reset", storeKeyPathParameter: storeKey, json: ["tokenValue": token,
                              "newPassword": newPassword], result: result)
    }

    /**
        Verifies email address for the user with matching token. Most common use case for this method is if your app
        handles custom URLs, so you can process user's tap on the account activation link (e.g in mail).

        - parameter token:                    The token obtained from the customers/email-token endpoint.
                                              Usually parsed from the account activation URL.
        - parameter storeKey:                 For customers registered in a specific store, a store key must be specified.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func verifyEmail(token: String, storeKey: String? = nil, result: @escaping (Result<ResponseType>) -> Void) {

        customerProfileAction(method: .post, basePath: "email/confirm", storeKeyPathParameter: storeKey, json: ["tokenValue": token], result: result)
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

    private static func customerProfileAction<T: Codable>(method: HTTPMethod, basePath: String? = nil, expansion: [String]? = nil,
                                              storeKeyPathParameter: String?, urlParameters: [String: String] = [:],
                                              json: [String: Any]? = nil, result: @escaping (Result<T>) -> Void) {

        requestWithTokenAndPath(result: result) { token, path in
            let storeKey = storeKeyPathParameter ?? Config.currentConfig?.storeKey
            let fullPath = pathWithExpansion(storeKey != nil ? "\(path)in-store/key=\(storeKey!)/me/\(basePath ?? "")" : "\(path)me/\(basePath ?? "")", expansion: expansion)
            let request = self.request(url: fullPath, method: method, urlParameters: urlParameters,
                                       json: json, headers: self.headers(token))

            perform(request: request) { (response: Result<T>) in
                result(response)
            }
        }
    }
}
