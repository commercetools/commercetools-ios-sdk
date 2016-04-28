//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class UpdateEndpointTests: XCTestCase {

    private class TestCart: UpdateEndpoint, CreateEndpoint {
        static let path = "me/carts"
    }

    override func setUp() {
        super.setUp()

        cleanPersistedTokens()
        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testUpdateEndpoint() {

        let updateExpectation = expectationWithDescription("update expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        let addLineItemAction = ["action": "addLineItem", "productId": "a9fd9c74-d00a-4de7-8258-6a9920abc66b", "variantId": 1]

        TestCart.create(["currency": "EUR"], result: { result in
            if let response = result.response, id = response["id"] as? String, version = response["version"] as? UInt
                    where result.isSuccess {
                TestCart.update(id, version: version, actions: [addLineItemAction], result: { result in
                    if let response = result.response, updatedId = response["id"] as? String,
                            newVersion = response["version"] as? UInt where result.isSuccess  && updatedId == id
                            && newVersion > version {
                        updateExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testConcurrentModification() {

        let updateExpectation = expectationWithDescription("update expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        let addLineItemAction = ["action": "addLineItem", "productId": "a9fd9c74-d00a-4de7-8258-6a9920abc66b", "variantId": 1]

        TestCart.create(["currency": "EUR"], result: { result in
            if let response = result.response, id = response["id"] as? String, version = response["version"] as? UInt
            where result.isSuccess {
                TestCart.update(id, version: version + 1, actions: [addLineItemAction], result: { result in
                    if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                            where errorReason == "Object \(id) has a different version than expected. Expected: 2 - Actual: 1." &&
                            error.code == Error.Code.ConcurrentModificationError.rawValue {
                        updateExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testUpdateEndpointError() {

        let updateExpectation = expectationWithDescription("update expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.update("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", version: 1, actions: [], result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
            where errorReason == "The Cart with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found." &&
                    error.code == Error.Code.ResourceNotFoundError.rawValue {
                updateExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

}
