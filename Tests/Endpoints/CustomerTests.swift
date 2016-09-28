//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
import Alamofire
@testable import Commercetools

class CustomerTests: XCTestCase {

    private class TestCustomer: QueryEndpoint {
        public typealias ResponseType = [String: Any]
        static let path = "customers"
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testRetrieveCustomerProfile() {
        setupTestConfiguration()

        let retrieveProfileExpectation = expectation(description: "retrieve profile expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        Customer.profile { result in
            if let response = result.response, let _ = response["firstName"] as? String,
                    let _ = response["lastName"] as? String, result.isSuccess {
                retrieveProfileExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCustomerProfileError() {
        setupTestConfiguration()

        let retrieveProfileExpectation = expectation(description: "retrieve profile expectation")

        Customer.profile { result in
            if let error = result.errors?.first as? CTError, case .insufficientTokenGrantTypeError(let reason) = error,
                    reason.message == "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'." {
                retrieveProfileExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCreateAndDeleteProfile() {
        setupTestConfiguration()

        let username = "new.swift.sdk.test.user@commercetools.com"

        let createProfileExpectation = expectation(description: "create profile expectation")
        let deleteProfileExpectation = expectation(description: "delete profile expectation")

        let signupDraft = ["email": username, "password": "password"]

        Customer.signup(signupDraft, result: { result in
            if let response = result.response, let customer = response["customer"] as? [String: Any],
                    let email = customer["email"] as? String, let version = customer["version"] as? UInt, result.isSuccess
                    && email == username {
                createProfileExpectation.fulfill()

                AuthManager.sharedInstance.loginUser(username, password: "password", completionHandler: {_ in})
                Customer.delete(version: version, result: { result in
                    if let response = result.response, let email = response["email"] as? String, result.isSuccess
                            && email == username {
                        deleteProfileExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCreateError() {
        setupTestConfiguration()

        let createProfileExpectation = expectation(description: "create profile expectation")

        let signupDraft = ["email": "swift.sdk.test.user2@commercetools.com", "password": "password"]

        Customer.signup(signupDraft, result: { result in
            if let error = result.errors?.first as? CTError, case .generalError(let reason) = error,
                    reason?.message == "There is already an existing customer with the email '\"swift.sdk.test.user2@commercetools.com\"'." {
                createProfileExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testDeleteError() {
        setupTestConfiguration()

        let deleteProfileExpectation = expectation(description: "delete profile expectation")

        Customer.delete(version: 1, result: { result in
            if let error = result.errors?.first as? CTError, case .insufficientTokenGrantTypeError(let reason) = error,
                    reason.message == "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'." {
                deleteProfileExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateCustomer() {
        setupTestConfiguration()

        let updateProfileExpectation = expectation(description: "update profile expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        var setFirstNameAction: [String: Any] = ["action": "setFirstName", "firstName": "newName"]

        Customer.profile { result in
            if let response = result.response, let version = response["version"] as? UInt, result.isSuccess {
                Customer.update(version: version, actions: [setFirstNameAction], result: { result in
                    if let response = result.response, let version = response["version"] as? UInt,
                            let firstName = response["firstName"] as? String, result.isSuccess
                            && firstName == "newName" {

                        // Now revert back to the old name
                        setFirstNameAction["firstName"] = "Test"

                        Customer.update(version: version, actions: [setFirstNameAction], result: { result in
                            if let response = result.response, let firstName = response["firstName"] as? String, result.isSuccess && firstName == "Test" {
                                updateProfileExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateError() {
        setupTestConfiguration()

        let updateProfileExpectation = expectation(description: "update profile expectation")

        let setFirstNameAction: [String: Any] = ["action": "setFirstName", "firstName": "newName"]

        Customer.update(version: 1, actions: [setFirstNameAction], result: { result in
            if let error = result.errors?.first as? CTError, case .insufficientTokenGrantTypeError(let reason) = error,
                    reason.message == "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'." {
                updateProfileExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testChangePassword() {
        setupTestConfiguration()

        let changePasswordExpectation = expectation(description: "change password expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        Customer.profile { result in
            if let response = result.response, let version = response["version"] as? UInt, result.isSuccess {

                Customer.changePassword(currentPassword: password, newPassword: "newPassword", version: version, result: { result in
                    if let response = result.response, let version = response["version"] as? UInt, result.isSuccess {

                        // Now revert the password change
                        Customer.changePassword(currentPassword: "newPassword", newPassword: password, version: version, result: { result in
                            if result.isSuccess {
                                changePasswordExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testResetPassword() {

        let resetPasswordExpectation = expectation(description: "reset password expectation")

        let username = "swift.sdk.test.user2@commercetools.com"

        // For generating password reset token we need higher priviledges
        setupProjectManagementConfiguration()

        // Obtain password reset token
        AuthManager.sharedInstance.token { token, error in
            guard let token = token, let path = TestCustomer.fullPath else { return }

            Alamofire.request("\(path)password-token", method: .post, parameters: ["email": username], encoding: JSONEncoding.default, headers: TestCustomer.headers(token))
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                TestCustomer.handleResponse(response, result: { result in
                    if let response = result.response, let token = response["value"] as? String, result.isSuccess {

                        // Now confirm reset password token with regular mobile client scope
                        self.setupTestConfiguration()

                        Customer.resetPassword(token: token, newPassword: "password", result: { result in
                            if let response = result.response, let email = response["email"] as? String, result.isSuccess
                                    && email == username {
                                resetPasswordExpectation.fulfill()
                            }
                        })
                    }
                })
            })
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testVerifyEmail() {

        let resetPasswordExpectation = expectation(description: "reset password expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        // For generating account activation token we need higher priviledges
        setupProjectManagementConfiguration()

        // Obtain password reset token
        AuthManager.sharedInstance.token { token, error in
            guard let token = token, let path = TestCustomer.fullPath else {
                return
            }

            // First query for the UUID of the user we want to activate
            TestCustomer.query(predicates: ["email=\"\(username)\""], result: { result in
                if let response = result.response, let results = response["results"] as? [[String: AnyObject]],
                        let id = results.first?["id"] as? String, result.isSuccess {

                    // Now generate email activation token
                    Alamofire.request("\(path)email-token", method: .post, parameters: ["id": id, "ttlMinutes": 1], encoding: JSONEncoding.default, headers: TestCustomer.headers(token))
                    .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                        TestCustomer.handleResponse(response, result: { result in
                            if let response = result.response, let token = response["value"] as? String, result.isSuccess {

                                // Confirm email verification token with regular mobile client scope
                                self.setupTestConfiguration()
                                AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

                                Customer.verifyEmail(token: token, result: { result in
                                    if let response = result.response, let email = response["email"] as? String, result.isSuccess
                                            && email == username {
                                        resetPasswordExpectation.fulfill()
                                    }
                                })
                            }
                        })
                    })
                }
            })
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

}
