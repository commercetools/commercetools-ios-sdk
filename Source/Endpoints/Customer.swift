//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Alamofire
import ObjectMapper

/**
    Provides complete set of interactions for retrieving current customer profile, signing up,
    updating and profile deletion.
*/
open class Customer: Endpoint, Mappable {
    
    public typealias ResponseType = Customer

    open static let path = "me"

    // MARK: - Customer endpoint functionality

    /**
        Retrieves customer profile for the currently logged in user.

        - parameter result:                   The code to be executed after processing the response.
    */
    open static func profile(_ result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .get, result: result)
    }

    /**
        Creates new customer with specified profile.

        - parameter profile:                  Draft of the customer profile to be created.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func signup(_ profile: CustomerDraft, result: @escaping (Result<CustomerSignInResult>) -> Void) {
        signup(Mapper<CustomerDraft>().toJSON(profile), result: result)
    }

    /**
        Creates new customer with specified profile.

        - parameter profile:                  Dictionary representation of the draft customer profile to be created.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func signup(_ profile: [String: Any], result: @escaping (Result<CustomerSignInResult>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            Alamofire.request("\(path)signup", method: .post, parameters: profile, encoding: JSONEncoding.default, headers: self.headers(token))
                    .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                        handleResponse(response, result: result)
                    })
        })
    }

    /**
        Updates current customer profile.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter actions:                  An array of actions to be executed, in dictionary representation.
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func update(version: UInt, actions: [[String: Any]], result: @escaping (Result<ResponseType>) -> Void) {
        customerProfileAction(method: .post, parameters: ["version": version, "actions": actions], encoding: JSONEncoding.default, result: result)
    }

    /**
        Deletes customer profile for the currently logged in user.

        - parameter version:                  Customer profile version (for optimistic concurrency control).
        - parameter result:                   The code to be executed after processing the response.
    */
    open static func delete(version: UInt, result: @escaping (Result<ResponseType>) -> Void) {
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
                               result: @escaping (Result<ResponseType>) -> Void) {

        customerProfileAction(method: .post, basePath: "password", parameters: ["currentPassword": currentPassword,
                              "newPassword": newPassword, "version": version], encoding: JSONEncoding.default, result: { changePasswordResult in

            if let response = changePasswordResult.json, let email = response["email"] as? String, changePasswordResult.isSuccess {
                AuthManager.sharedInstance.loginUser(email, password: newPassword, completionHandler: { error in
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
    open static func resetPassword(token: String, newPassword: String, result: @escaping (Result<ResponseType>) -> Void) {

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
    open static func verifyEmail(token: String, result: @escaping (Result<ResponseType>) -> Void) {

        customerProfileAction(method: .post, basePath: "email/confirm", parameters: ["tokenValue": token],
                              encoding: JSONEncoding.default, result: result)
    }

    // MARK: - Properties

    var id: String?
    var version: UInt?
    var customerNumber: String?
    var createdAt: Date?
    var lastModifiedAt: Date?
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var title: String?
    var dateOfBirth: Date?
    var companyName: String?
    var vatId: String?
    var addresses: [Address]?
    var defaultShippingAddressId: String?
    var defaultBillingAddressId: String?
    var isEmailVerified: Bool?
    var externalId: String?
    var customerGroup: Reference<CustomerGroup>?
    var custom: [String: Any]?
    var locale: String?

    public required init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        id                        <- map["id"]
        version                   <- map["version"]
        customerNumber            <- map["customerNumber"]
        createdAt                 <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt            <- (map["lastModifiedAt"], ISO8601DateTransform())
        email                     <- map["email"]
        password                  <- map["password"]
        firstName                 <- map["firstName"]
        lastName                  <- map["lastName"]
        middleName                <- map["middleName"]
        title                     <- map["title"]
        dateOfBirth               <- (map["dateOfBirth"], ISO8601DateTransform())
        companyName               <- map["companyName"]
        vatId                     <- map["vatId"]
        addresses                 <- map["addresses"]
        defaultShippingAddressId  <- map["defaultShippingAddressId"]
        defaultBillingAddressId   <- map["defaultBillingAddressId"]
        isEmailVerified           <- map["isEmailVerified"]
        externalId                <- map["externalId"]
        customerGroup             <- map["customerGroup"]
        custom                    <- map["custom"]
        locale                    <- map["locale"]
    }
    
    // MARK: - Helpers

    private static func customerProfileAction(method: HTTPMethod, basePath: String? = nil,
                                              parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default,
                                              result: @escaping (Result<ResponseType>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            Alamofire.request(path + (basePath ?? ""), method: method, parameters: parameters, encoding: encoding, headers: self.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                handleResponse(response, result: result)
            })
        })
    }
}
