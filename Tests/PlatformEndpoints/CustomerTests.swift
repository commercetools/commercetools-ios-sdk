//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class CustomerTests: XCTestCase {

    private class TestCustomer: QueryEndpoint {
        public typealias ResponseType = Customer
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

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        Customer.profile { result in
            if let response = result.json {
                XCTAssert(result.isSuccess)
                XCTAssertNotNil(response["firstName"] as? String)
                XCTAssertNotNil(response["lastName"] as? String)
                retrieveProfileExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCustomerProfileError() {
        setupTestConfiguration()

        let retrieveProfileExpectation = expectation(description: "retrieve profile expectation")

        Customer.profile { result in
            if let error = result.errors?.first as? CTError, case .insufficientTokenGrantTypeError(let reason) = error {
                XCTAssert(result.isFailure)
                XCTAssertEqual(reason.message, "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'.")
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

        let signUpDraft = ["email": username, "password": "password"]

        Customer.signUp(signUpDraft, storeKey: nil, result: { result in
            if let response = result.json, let customer = response["customer"] as? [String: Any],
               let email = customer["email"] as? String, let version = customer["version"] as? UInt {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(email, username)
                createProfileExpectation.fulfill()

                AuthManager.sharedInstance.loginCustomer(username: username, password: "password", completionHandler: { _ in})
                Customer.delete(version: version, result: { result in
                    if let response = result.json, let email = response["email"] as? String {
                        XCTAssert(result.isSuccess)
                        XCTAssertEqual(email, username)
                        deleteProfileExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCreateAndDeleteProfileWithModel() {
        setupTestConfiguration()

        let username = "new.swift.sdk.test.user@commercetools.com"

        let createProfileExpectation = expectation(description: "create profile expectation")
        let deleteProfileExpectation = expectation(description: "delete profile expectation")

        let customerDraft = CustomerDraft(email: username, password: "password")

        Commercetools.signUpCustomer(customerDraft, result: { result in
            if let customer = result.model?.customer, customer.email == username, result.isSuccess {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(customer.email, username)
                createProfileExpectation.fulfill()

                AuthManager.sharedInstance.loginCustomer(username: username, password: "password") { _ in
                    Customer.delete(version: customer.version, result: { result in
                        if let deletedCustomer = result.model {
                            XCTAssert(result.isSuccess)
                            XCTAssertEqual(deletedCustomer.email, username)
                            deleteProfileExpectation.fulfill()
                        }
                    })
                }
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateProfileWithModel() {
        setupTestConfiguration()

        let updateProfileExpectation = expectation(description: "update profile expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        Customer.profile { result in
            if let profile = result.model, result.isSuccess {
                let updateActions = UpdateActions<CustomerUpdateAction>(version: profile.version, actions: [.setFirstName(firstName: "newName"), .setSalutation(salutation: "salutation")])
                Customer.update(actions: updateActions, result: { result in
                    if let profile = result.model {
                        XCTAssert(result.isSuccess)
                        XCTAssertEqual(profile.firstName, "newName")
                        XCTAssertEqual(profile.salutation, "salutation")

                        // Now revert back to the old values
                        let updateActions = UpdateActions<CustomerUpdateAction>(version: profile.version, actions: [.setFirstName(firstName: "Test"), .setSalutation(salutation: "")])

                        Customer.update(actions: updateActions, result: { result in
                            if let profile = result.model {
                                XCTAssert(result.isSuccess)
                                XCTAssertEqual(profile.firstName, "Test")
                                XCTAssertEqual(profile.salutation, "")
                                updateProfileExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCreateError() {
        setupTestConfiguration()

        let createProfileExpectation = expectation(description: "create profile expectation")

        let signUpDraft = ["email": "swift.sdk.test.user2@commercetools.com", "password": "password"]

        Customer.signUp(signUpDraft, storeKey: nil, result: { result in
            if let error = result.errors?.first as? CTError, case .generalError(let reason) = error {
                XCTAssert(result.isFailure)
                XCTAssertEqual(reason?.message, "There is already an existing customer with the provided email.")
                createProfileExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testDeleteError() {
        setupTestConfiguration()

        let deleteProfileExpectation = expectation(description: "delete profile expectation")

        Customer.delete(version: 1, result: { result in
            if let error = result.errors?.first as? CTError, case .insufficientTokenGrantTypeError(let reason) = error {
                XCTAssert(result.isFailure)
                XCTAssertEqual(reason.message, "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'.")
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

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        var setFirstNameAction: [String: Any] = ["action": "setFirstName", "firstName": "newName"]

        Customer.profile { result in
            if let response = result.json, let version = response["version"] as? UInt, result.isSuccess {
                Customer.update(version: version, actions: [setFirstNameAction], result: { result in
                    if let response = result.json, let version = response["version"] as? UInt,
                            let firstName = response["firstName"] as? String {
                        XCTAssert(result.isSuccess)
                        XCTAssertEqual(firstName, "newName")

                        // Now revert back to the old name
                        setFirstNameAction["firstName"] = "Test"

                        Customer.update(version: version, actions: [setFirstNameAction], result: { result in
                            if let response = result.json, let firstName = response["firstName"] as? String {
                                XCTAssert(result.isSuccess)
                                XCTAssertEqual(firstName, "Test")
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
            if let error = result.errors?.first as? CTError, case .insufficientTokenGrantTypeError(let reason) = error {
                XCTAssert(result.isFailure)
                XCTAssertEqual(reason.message, "This endpoint requires an access token issued with the 'Resource Owner Password Credentials Grant'.")
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

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        Customer.profile { result in
            if let response = result.json, let version = response["version"] as? UInt, result.isSuccess {

                Customer.changePassword(currentPassword: password, newPassword: "newPassword", version: version, result: { result in
                    if let response = result.json, let version = response["version"] as? UInt, result.isSuccess {

                        // Now revert the password change
                        Customer.changePassword(currentPassword: "newPassword", newPassword: password, version: version, result: { result in
                            XCTAssert(result.isSuccess)
                            changePasswordExpectation.fulfill()
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

        // For generating password reset token we need higher privileges
        setupProjectManagementConfiguration()

        // Obtain password reset token
        AuthManager.sharedInstance.token { token, error in
            guard let token = token, let path = TestCustomer.fullPath() else { return }

            let customerResult: ((Commercetools.Result<NoMapping>) -> Void) = { result in
                if let response = result.json, let token = response["value"] as? String, result.isSuccess {

                    // Now confirm reset password token with regular mobile client scope
                    self.setupTestConfiguration()

                    Customer.resetPassword(token: token, newPassword: "password", result: { result in
                        if let response = result.json, let email = response["email"] as? String {
                            XCTAssert(result.isSuccess)
                            XCTAssertEqual(email, username)
                            resetPasswordExpectation.fulfill()
                        }
                    })
                }
            }

            let request = TestCustomer.request(url: "\(path)password-token", method: .post, json: ["email": username], headers: TestCustomer.headers(token))

            TestCustomer.perform(request: request) { (response: Result<NoMapping>) in
                customerResult(response)
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testVerifyEmail() {

        let verifyEmailExpectation = expectation(description: "verify email expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        // For generating account activation token we need higher privileges
        setupProjectManagementConfiguration()

        // Obtain password reset token
        AuthManager.sharedInstance.token { token, error in
            guard let token = token, let path = TestCustomer.fullPath() else {
                return
            }

            // First query for the UUID of the user we want to activate
            TestCustomer.query(predicates: ["email=\"\(username)\""], result: { result in
                if let response = result.json, let results = response["results"] as? [[String: AnyObject]],
                        let id = results.first?["id"] as? String, result.isSuccess {

                    let customerResult: ((Commercetools.Result<NoMapping>) -> Void) = { result in
                        if let response = result.json, let token = response["value"] as? String, result.isSuccess {

                            // Confirm email verification token with regular mobile client scope
                            self.setupTestConfiguration()
                            AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

                            Customer.verifyEmail(token: token, result: { result in
                                if let response = result.json, let email = response["email"] as? String {
                                    XCTAssert(result.isSuccess)
                                    XCTAssertEqual(email, username)
                                    verifyEmailExpectation.fulfill()
                                }
                            })
                        }
                    }

                    // Now generate email activation token
                    let request = TestCustomer.request(url: "\(path)email-token", method: .post, json: ["id": id, "ttlMinutes": 1], headers: TestCustomer.headers(token))

                    TestCustomer.perform(request: request) { (response: Result<NoMapping>) in
                        customerResult(response)
                    }
                }
            })
        }

        waitForExpectations(timeout: 20, handler: nil)
    }

    func testRetrieveCustomerProfileInStore() {
        setupTestConfiguration()

        let retrieveProfileExpectation = expectation(description: "retrieve profile expectation")

        let username = "swift.sdk.test.in.store.user@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, storeKey: "in-store-customer-test", completionHandler: { _ in})

        Customer.profile { result in
            if let response = result.json {
                XCTAssert(result.isSuccess)
                XCTAssertNotNil(response["firstName"] as? String)
                XCTAssertNotNil(response["lastName"] as? String)
                retrieveProfileExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCreateAndDeleteProfileInStore() {
        setupTestConfiguration()

        let username = "new.swift.sdk.test.user.in.store@commercetools.com"

        let createProfileExpectation = expectation(description: "create profile expectation")
        let deleteProfileExpectation = expectation(description: "delete profile expectation")

        let customerDraft = CustomerDraft(email: username, password: "password")

        Commercetools.signUpCustomer(customerDraft, storeKey: "in-store-customer-test", result: { result in
            if let customer = result.model?.customer, customer.email == username, result.isSuccess {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(customer.email, username)
                createProfileExpectation.fulfill()

                AuthManager.sharedInstance.loginCustomer(username: username, password: "password", storeKey: "in-store-customer-test") { _ in
                    Customer.delete(version: customer.version, storeKey: "in-store-customer-test", result: { result in
                        if let deletedCustomer = result.model {
                            XCTAssert(result.isSuccess)
                            XCTAssertEqual(deletedCustomer.email, username)
                            deleteProfileExpectation.fulfill()
                        }
                    })
                }
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateProfileInStore() {
        setupTestConfiguration()

        let updateProfileExpectation = expectation(description: "update profile expectation")

        let username = "swift.sdk.test.in.store.user@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, storeKey: "in-store-customer-test", completionHandler: { _ in})

        Customer.profile(storeKey: "in-store-customer-test") { result in
            if let profile = result.model, result.isSuccess {
                let updateActions = UpdateActions<CustomerUpdateAction>(version: profile.version, actions: [.setFirstName(firstName: "newName"), .setSalutation(salutation: "salutation")])
                Customer.update(actions: updateActions, storeKey: "in-store-customer-test", result: { result in
                    if let profile = result.model {
                        XCTAssert(result.isSuccess)
                        XCTAssertEqual(profile.firstName, "newName")
                        XCTAssertEqual(profile.salutation, "salutation")

                        // Now revert back to the old values
                        let updateActions = UpdateActions<CustomerUpdateAction>(version: profile.version, actions: [.setFirstName(firstName: "Test"), .setSalutation(salutation: "")])

                        Customer.update(actions: updateActions, storeKey: "in-store-customer-test", result: { result in
                            if let profile = result.model {
                                XCTAssert(result.isSuccess)
                                XCTAssertEqual(profile.firstName, "Test")
                                XCTAssertEqual(profile.salutation, "")
                                updateProfileExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testChangePasswordInStore() {
        setupTestConfiguration()

        let changePasswordExpectation = expectation(description: "change password expectation")

        let username = "swift.sdk.test.in.store.user@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, storeKey: "in-store-customer-test", completionHandler: { _ in})

        Customer.profile(storeKey: "in-store-customer-test") { result in
            if let response = result.json, let version = response["version"] as? UInt, result.isSuccess {

                Customer.changePassword(currentPassword: password, newPassword: "newPassword", version: version, storeKey: "in-store-customer-test", result: { result in
                    if let response = result.json, let version = response["version"] as? UInt, result.isSuccess {

                        // Now revert the password change
                        Customer.changePassword(currentPassword: "newPassword", newPassword: password, version: version, storeKey: "in-store-customer-test", result: { result in
                            XCTAssert(result.isSuccess)
                            changePasswordExpectation.fulfill()
                        })
                    }
                })
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testResetPasswordInStore() {

        let resetPasswordExpectation = expectation(description: "reset password expectation")

        let username = "swift.sdk.test.in.store.user@commercetools.com"

        // For generating password reset token we need higher privileges
        setupProjectManagementConfiguration()

        // Obtain password reset token
        AuthManager.sharedInstance.token { token, error in
            guard let token = token, let path = TestCustomer.fullPath() else { return }

            let customerResult: ((Commercetools.Result<NoMapping>) -> Void) = { result in
                if let response = result.json, let token = response["value"] as? String, result.isSuccess {

                    // Now confirm reset password token with regular mobile client scope
                    self.setupTestConfiguration()

                    Customer.resetPassword(token: token, newPassword: "password", storeKey: "in-store-customer-test", result: { result in
                        if let response = result.json, let email = response["email"] as? String {
                            XCTAssert(result.isSuccess)
                            XCTAssertEqual(email, username)
                            resetPasswordExpectation.fulfill()
                        }
                    })
                }
            }

            let request = TestCustomer.request(url: "\(path)password-token", method: .post, json: ["email": username], headers: TestCustomer.headers(token))

            TestCustomer.perform(request: request) { (response: Result<NoMapping>) in
                customerResult(response)
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testVerifyEmailInStore() {

        let verifyEmailExpectation = expectation(description: "verify email expectation")

        let username = "swift.sdk.test.in.store.user@commercetools.com"
        let password = "password"

        // For generating account activation token we need higher privileges
        setupProjectManagementConfiguration()

        // Obtain password reset token
        AuthManager.sharedInstance.token { token, error in
            guard let token = token, let path = TestCustomer.fullPath() else {
                return
            }

            // First query for the UUID of the user we want to activate
            TestCustomer.query(predicates: ["email=\"\(username)\""], result: { result in
                if let response = result.json, let results = response["results"] as? [[String: AnyObject]],
                   let id = results.first?["id"] as? String, result.isSuccess {

                    let customerResult: ((Commercetools.Result<NoMapping>) -> Void) = { result in
                        if let response = result.json, let token = response["value"] as? String, result.isSuccess {

                            // Confirm email verification token with regular mobile client scope
                            self.setupTestConfiguration()
                            AuthManager.sharedInstance.loginCustomer(username: username, password: password, storeKey: "in-store-customer-test", completionHandler: { _ in})

                            Customer.verifyEmail(token: token, storeKey: "in-store-customer-test", result: { result in
                                if let response = result.json, let email = response["email"] as? String {
                                    XCTAssert(result.isSuccess)
                                    XCTAssertEqual(email, username)
                                    verifyEmailExpectation.fulfill()
                                }
                            })
                        }
                    }

                    // Now generate email activation token
                    let request = TestCustomer.request(url: "\(path)email-token", method: .post, json: ["id": id, "ttlMinutes": 1], headers: TestCustomer.headers(token))

                    TestCustomer.perform(request: request) { (response: Result<NoMapping>) in
                        customerResult(response)
                    }
                }
            })
        }

        waitForExpectations(timeout: 20, handler: nil)
    }
}
