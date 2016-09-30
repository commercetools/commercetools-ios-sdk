//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class UpdateEndpointTests: XCTestCase {

    private class TestCart: UpdateEndpoint, CreateEndpoint {
        public typealias ResponseType = Cart
        static let path = "me/carts"
    }

    private class TestProductProjections: QueryEndpoint {
        public typealias ResponseType = ProductProjection
        static let path = "product-projections"
    }

    override func setUp() {
        super.setUp()

        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testUpdateEndpoint() {

        let updateExpectation = expectation(description: "update expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestProductProjections.query(limit: 1, dictionaryResult: { result in
            if let response = result.response, let results = response["results"] as? [[String: AnyObject]],
            let productId = results.first?["id"] as? String, result.isSuccess {

                let addLineItemAction: [String: Any] = ["action": "addLineItem", "productId": productId, "variantId": 1]

                TestCart.create(["currency": "EUR"], dictionaryResult: { result in
                    if let response = result.response, let id = response["id"] as? String, let version = response["version"] as? UInt, result.isSuccess {
                        TestCart.update(id, version: version, actions: [addLineItemAction], dictionaryResult: { result in
                            if let response = result.response, let updatedId = response["id"] as? String,
                                    let newVersion = response["version"] as? UInt, result.isSuccess  && updatedId == id
                                    && newVersion > version {
                                updateExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testConcurrentModification() {

        let updateExpectation = expectation(description: "update expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestProductProjections.query(limit: 1, dictionaryResult: { result in
            if let response = result.response, let results = response["results"] as? [[String: AnyObject]],
                    let productId = results.first?["id"] as? String, result.isSuccess {

                let addLineItemAction: [String: Any] = ["action": "addLineItem", "productId": productId, "variantId": 1]

                TestCart.create(["currency": "EUR"], dictionaryResult: { result in
                    if let response = result.response, let id = response["id"] as? String, let version = response["version"] as? UInt, result.isSuccess {
                        TestCart.update(id, version: version + 1, actions: [addLineItemAction], dictionaryResult: { result in
                            
                            if let error = result.errors?.first as? CTError, result.statusCode == 409, case .concurrentModificationError(let reason, let currentVersion) = error,
                                    reason.message == "Object \(id) has a different version than expected. Expected: 2 - Actual: 1." && version == currentVersion {
                                updateExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateEndpointError() {

        let updateExpectation = expectation(description: "update expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.update("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", version: 1, actions: [], dictionaryResult: { result in
            if let error = result.errors?.first as? CTError, result.statusCode == 404, case .resourceNotFoundError(let reason) = error,
                    reason.message == "The Cart with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found." {
                updateExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

}
