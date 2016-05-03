//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class CustomerTests: XCTestCase {

    override func setUp() {
        super.setUp()

        cleanPersistedTokens()
        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testRetrieveCustomerProfile() {

        let retrieveProfileExpectation = expectationWithDescription("retrieve profile expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        Customer.profile { result in
            if let response = result.response, firstName = response["firstName"] as? String,
                    lastName = response["lastName"] as? String where result.isSuccess {
                retrieveProfileExpectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testCustomerProfileError() {

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

        let createProfileExpectation = expectationWithDescription("create profile expectation")
        let deleteProfileExpectation = expectationWithDescription("delete profile expectation")

        let signupDraft = ["email": "new.swift.sdk.test.user@commercetools.com", "password": "password"]

        Customer.signup(signupDraft, result: { result in
            if let response = result.response, customer = response["customer"] as? [String: AnyObject],
                    email = customer["email"] as? String, version = customer["version"] as? UInt where result.isSuccess {
                createProfileExpectation.fulfill()

                AuthManager.sharedInstance.loginUser("new.swift.sdk.test.user@commercetools.com", password: "password", completionHandler: {_ in})
                Customer.delete(version: version, result: { result in
                    if let response = result.response, email = response["email"] as? String where result.isSuccess {
                        deleteProfileExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testCreateError() {

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
                            if let response = result.response, version = response["version"] as? UInt,
                                    firstName = response["firstName"] as? String where result.isSuccess
                                    && firstName == "Test" {
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

}
