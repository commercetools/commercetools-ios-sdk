//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
import Alamofire
@testable import Commercetools

class CustomerTests: XCTestCase {

    private class TestCustomer: QueryEndpoint {
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

        let retrieveProfileExpectation = expectationWithDescription("retrieve profile expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        Customer.profile { result in
            if let response = result.response, _ = response["firstName"] as? String,
                    _ = response["lastName"] as? String where result.isSuccess {
                retrieveProfileExpectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testCustomerProfileError() {
        setupTestConfiguration()

        let retrieveProfileExpectation = expectationWithDescription("retrieve profile expectation")

        Customer.profile { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                    where errorReason == "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'." &&
                           error.code == Error.Code.InsufficientTokenGrantTypeError.rawValue {
                retrieveProfileExpectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testCreateAndDeleteProfile() {
        setupTestConfiguration()

        let username = "new.swift.sdk.test.user@commercetools.com"

        let createProfileExpectation = expectationWithDescription("create profile expectation")
        let deleteProfileExpectation = expectationWithDescription("delete profile expectation")

        let signupDraft = ["email": username, "password": "password"]

        Customer.signup(signupDraft, result: { result in
            if let response = result.response, customer = response["customer"] as? [String: AnyObject],
                    email = customer["email"] as? String, version = customer["version"] as? UInt where result.isSuccess
                    && email == username {
                createProfileExpectation.fulfill()

                AuthManager.sharedInstance.loginUser(username, password: "password", completionHandler: {_ in})
                Customer.delete(version: version, result: { result in
                    if let response = result.response, email = response["email"] as? String where result.isSuccess
                            && email == username {
                        deleteProfileExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testCreateError() {
        setupTestConfiguration()

        let createProfileExpectation = expectationWithDescription("create profile expectation")

        let signupDraft = ["email": "swift.sdk.test.user2@commercetools.com", "password": "password"]

        Customer.signup(signupDraft, result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                    where errorReason == "There is already an existing customer with the email '\"swift.sdk.test.user2@commercetools.com\"'." {
                createProfileExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testDeleteError() {
        setupTestConfiguration()

        let deleteProfileExpectation = expectationWithDescription("delete profile expectation")

        Customer.delete(version: 1, result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                    where errorReason == "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'."
                        && error.code == Error.Code.InsufficientTokenGrantTypeError.rawValue {
                deleteProfileExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testUpdateCustomer() {
        setupTestConfiguration()

        let updateProfileExpectation = expectationWithDescription("update profile expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        var setFirstNameAction: [String: AnyObject] = ["action": "setFirstName", "firstName": "newName"]

        Customer.profile { result in
            if let response = result.response, version = response["version"] as? UInt where result.isSuccess {
                Customer.update(version: version, actions: [setFirstNameAction], result: { result in
                    if let response = result.response, version = response["version"] as? UInt,
                            firstName = response["firstName"] as? String where result.isSuccess
                            && firstName == "newName" {

                        // Now revert back to the old name
                        setFirstNameAction["firstName"] = "Test"

                        Customer.update(version: version, actions: [setFirstNameAction], result: { result in
                            if let response = result.response, firstName = response["firstName"] as? String
                                    where result.isSuccess && firstName == "Test" {
                                updateProfileExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testUpdateError() {
        setupTestConfiguration()

        let updateProfileExpectation = expectationWithDescription("update profile expectation")

        let setFirstNameAction: [String: AnyObject] = ["action": "setFirstName", "firstName": "newName"]

        Customer.update(version: 1, actions: [setFirstNameAction], result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                    where errorReason == "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'."
                    && error.code == Error.Code.InsufficientTokenGrantTypeError.rawValue {
                updateProfileExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testChangePassword() {
        setupTestConfiguration()

        let changePasswordExpectation = expectationWithDescription("change password expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        Customer.profile { result in
            if let response = result.response, version = response["version"] as? UInt where result.isSuccess {

                Customer.changePassword(currentPassword: password, newPassword: "newPassword", version: version, result: { result in
                    if let response = result.response, version = response["version"] as? UInt where result.isSuccess {

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

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testResetPassword() {

        let resetPasswordExpectation = expectationWithDescription("reset password expectation")

        let username = "swift.sdk.test.user2@commercetools.com"

        // For generating password reset token we need higher priviledges
        setupProjectManagementConfiguration()

        // Obtain password reset token
        AuthManager.sharedInstance.token { token, error in
            guard let token = token, path = TestCustomer.fullPath else {
                return
            }

            Alamofire.request(.POST, "\(path)password-token", parameters: ["email": username], encoding: .JSON, headers: TestCustomer.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                TestCustomer.handleResponse(response, result: { result in
                    if let response = result.response, token = response["value"] as? String where result.isSuccess {

                        // Now confirm reset password token with regular mobile client scope
                        self.setupTestConfiguration()

                        Customer.resetPassword(token: token, newPassword: "password", result: { result in
                            if let response = result.response, email = response["email"] as? String where result.isSuccess
                                    && email == username {
                                resetPasswordExpectation.fulfill()
                            }
                        })
                    }
                })
            })
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testVerifyEmail() {

        let resetPasswordExpectation = expectationWithDescription("reset password expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        // For generating account activation token we need higher priviledges
        setupProjectManagementConfiguration()

        // Obtain password reset token
        AuthManager.sharedInstance.token { token, error in
            guard let token = token, path = TestCustomer.fullPath else {
                return
            }

            // First query for the UUID of the user we want to activate
            TestCustomer.query(predicates: ["email=\"\(username)\""], result: { result in
                if let response = result.response, results = response["results"] as? [[String: AnyObject]],
                        id = results.first?["id"] as? String where result.isSuccess {

                    // Now generate email activation token
                    Alamofire.request(.POST, "\(path)email-token", parameters: ["id": id, "ttlMinutes": 1], encoding: .JSON, headers: TestCustomer.headers(token))
                    .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                        TestCustomer.handleResponse(response, result: { result in
                            if let response = result.response, token = response["value"] as? String where result.isSuccess {

                                // Confirm email verification token with regular mobile client scope
                                self.setupTestConfiguration()
                                AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

                                Customer.verifyEmail(token: token, result: { result in
                                    if let response = result.response, email = response["email"] as? String where result.isSuccess
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

        waitForExpectationsWithTimeout(10, handler: nil)
    }

}
