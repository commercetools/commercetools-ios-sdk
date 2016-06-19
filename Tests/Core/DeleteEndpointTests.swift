//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class DeleteEndpointTests: XCTestCase {

    private class TestCart: DeleteEndpoint, CreateEndpoint {
        static let path = "me/carts"
    }

    override func setUp() {
        super.setUp()

        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testDeleteEndpoint() {

        let deleteExpectation = expectationWithDescription("delete expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.create(["currency": "EUR"], result: { result in
            if let response = result.response, id = response["id"] as? String, version = response["version"] as? UInt
                    where result.isSuccess {
                TestCart.delete(id, version: version, result: { result in
                    if let response = result.response, deletedId = response["id"] as? String where result.isSuccess
                            && deletedId == id {
                        deleteExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testConcurrentModification() {

        let deleteExpectation = expectationWithDescription("delete expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.create(["currency": "EUR"], result: { result in
            if let response = result.response, id = response["id"] as? String, version = response["version"] as? UInt
            where result.isSuccess {
                TestCart.delete(id, version: version + 1, result: { result in
                    if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                            where errorReason == "Object \(id) has a different version than expected. Expected: 2 - Actual: 1." &&
                            error.code == Error.Code.ConcurrentModificationError.rawValue {
                        deleteExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testDeleteEndpointError() {

        let deleteExpectation = expectationWithDescription("delete expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.delete("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", version: 1, result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
            where errorReason == "The Cart with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found." &&
                    error.code == Error.Code.ResourceNotFoundError.rawValue {
                deleteExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

}
