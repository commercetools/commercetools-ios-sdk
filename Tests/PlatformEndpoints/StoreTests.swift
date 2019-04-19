//
// Copyright (c) 2018 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class StoreTests: XCTestCase {

    private class TestStore: CreateEndpoint, DeleteEndpoint {
        public typealias ResponseType = Store
        public typealias RequestDraft = NoMapping
        static let path = "stores"
    }

    private var storeId: String!

    override func setUp() {
        super.setUp()

        let semaphore = DispatchSemaphore(value: 0)

        // For creating a store we need higher privileges
        setupProjectManagementConfiguration()

        TestStore.create(["key": "unionSquare", "name": ["en": "Union Square"]]) { result in
            guard let store = result.model, result.isSuccess else {
                semaphore.signal()
                return
            }
            self.storeId = store.id
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)

        // Test store retrieval with regular mobile client scope
        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()

        let semaphore = DispatchSemaphore(value: 0)

        // For deleting a store we need higher privileges
        setupProjectManagementConfiguration()

        TestStore.delete(storeId, version: 1) { _ in
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)

        super.tearDown()
    }

    func testRetrieveStoreById() {

        let storeExpectation = expectation(description: "retrieve store expectation")

        Store.byId(storeId) { result in
            XCTAssert(result.isSuccess)
            XCTAssertEqual(result.model!.key, "unionSquare")
            XCTAssertEqual(result.model!.name!["en"], "Union Square")
            storeExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testRetrieveStoreByKey() {

        let storeExpectation = expectation(description: "retrieve store expectation")

        Store.byKey("unionSquare") { result in
            XCTAssert(result.isSuccess)
            XCTAssertEqual(result.model!.key, "unionSquare")
            XCTAssertEqual(result.model!.name!["en"], "Union Square")
            storeExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCartStore() {

        let storeExpectation = expectation(description: "cart store expectation")

        Store.byKey("unionSquare") { result in
            let cartDraft = CartDraft(currency: "EUR", store: ResourceIdentifier(id: result.model!.id, typeId: .store))

            Cart.create(cartDraft) { result in
                XCTAssert(result.isSuccess)

                let cart = result.model!
                XCTAssertEqual(cart.store!.key, "unionSquare")

                Cart.delete(cart.id, version: cart.version) { result in
                    XCTAssert(result.isSuccess)
                    storeExpectation.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
