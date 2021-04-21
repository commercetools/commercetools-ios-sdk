//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class UpdateEndpointTests: XCTestCase {

    private class TestCart: UpdateEndpoint, CreateEndpoint {
        typealias ResponseType = Cart
        typealias RequestDraft = CartDraft
        typealias UpdateAction = CartUpdateAction
        static let path = "me/carts"
    }

    private class TestProductProjections: QueryEndpoint {
        typealias ResponseType = NoMapping
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

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        TestProductProjections.query(limit: 1, result: { result in
            if let response = result.json, let results = response["results"] as? [[String: AnyObject]],
            let productId = results.first?["id"] as? String, result.isSuccess {

                let addLineItemAction: [String: Any] = ["action": "addLineItem", "productId": productId, "variantId": 1]

                TestCart.create(["currency": "EUR"], result: { result in
                    if let response = result.json, let id = response["id"] as? String, let version = response["version"] as? UInt, result.isSuccess {
                        TestCart.update(id, version: version, actions: [addLineItemAction], result: { result in
                            if let response = result.json, let updatedId = response["id"] as? String,
                                    let newVersion = response["version"] as? UInt, result.isSuccess  && updatedId == id
                                    && newVersion > version {
                                XCTAssert(result.isSuccess)
                                XCTAssertEqual(updatedId, id)
                                XCTAssertGreaterThan(newVersion, version)
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

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        TestProductProjections.query(limit: 1, result: { result in
            if let response = result.json, let results = response["results"] as? [[String: AnyObject]],
                    let productId = results.first?["id"] as? String, result.isSuccess {

                let addLineItemAction: [String: Any] = ["action": "addLineItem", "productId": productId, "variantId": 1]

                TestCart.create(["currency": "EUR"], result: { result in
                    if let response = result.json, let id = response["id"] as? String, let version = response["version"] as? UInt, result.isSuccess {
                        TestCart.update(id, version: version + 1, actions: [addLineItemAction], result: { result in
                            
                            if let error = result.errors?.first as? CTError, case .concurrentModificationError(let reason, let currentVersion) = error {
                                XCTAssert(result.isFailure)
                                XCTAssertEqual(result.statusCode, 409)
                                XCTAssertEqual(reason.message, "Object \(id) has a different version than expected. Expected: 2 - Actual: 1.")
                                XCTAssertEqual(version, currentVersion)
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

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        TestCart.update("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", version: 1, actions: [], result: { result in
            if let error = result.errors?.first as? CTError, case .resourceNotFoundError(let reason) = error {
                XCTAssert(result.isFailure)
                XCTAssertEqual(result.statusCode, 404)
                XCTAssertEqual(reason.message, "The cart with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found.")
                updateExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }
}
