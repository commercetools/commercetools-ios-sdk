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

    private let storeKey = "unionSquare"

    override func setUp() {
        super.setUp()

        let semaphore = DispatchSemaphore(value: 0)

        // For creating a store we need higher privileges
        setupProjectManagementConfiguration()

        TestStore.create(["key": storeKey, "name": ["en": "Union Square"]]) { result in
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
            XCTAssertEqual(result.model!.key, self.storeKey)
            XCTAssertEqual(result.model!.name!["en"], "Union Square")
            storeExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testRetrieveStoreByKey() {

        let storeExpectation = expectation(description: "retrieve store expectation")

        Store.byKey(storeKey) { result in
            XCTAssert(result.isSuccess)
            XCTAssertEqual(result.model!.key, self.storeKey)
            XCTAssertEqual(result.model!.name!["en"], "Union Square")
            storeExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCartStore() {

        let storeExpectation = expectation(description: "cart store expectation")

        Store.byKey(storeKey) { result in
            let cartDraft = CartDraft(currency: "EUR", store: ResourceIdentifier(id: result.model!.id, typeId: .store))

            Cart.create(cartDraft) { result in
                XCTAssert(result.isSuccess)

                let cart = result.model!
                XCTAssertEqual(cart.store!.key, self.storeKey)

                Cart.delete(cart.id, version: cart.version) { result in
                    XCTAssert(result.isSuccess)
                    storeExpectation.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testStoreCartCreateAndRetrieve() {

        let storeExpectation = expectation(description: "cart store expectation")

        Store.byKey(storeKey) { result in
            let cartDraft = CartDraft(currency: "EUR")

            Cart.create(cartDraft, storeKey: self.storeKey) { result in
                XCTAssert(result.isSuccess)

                let cart = result.model!
                XCTAssertEqual(cart.store!.key, self.storeKey)

                Cart.byId(cart.id, storeKey: self.storeKey) { result in
                    XCTAssert(result.isSuccess)

                    XCTAssertEqual(result.model!.store!.key, self.storeKey)

                    Cart.query(storeKey: self.storeKey, limit: 1) { result in
                        XCTAssert(result.isSuccess)

                        XCTAssertEqual(result.model!.results.first!.store!.key, self.storeKey)

                        Cart.delete(cart.id, storeKey: self.storeKey, version: cart.version) { result in
                            XCTAssert(result.isSuccess)
                            storeExpectation.fulfill()
                        }
                    }
                }
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateStoreCart() {

        let storeExpectation = expectation(description: "cart store expectation")

        Store.byKey(storeKey) { result in
            let cartDraft = CartDraft(currency: "EUR")

            Cart.create(cartDraft, storeKey: self.storeKey) { result in
                XCTAssert(result.isSuccess)

                let cart = result.model!
                XCTAssertEqual(cart.store!.key, self.storeKey)

                let updateActions = UpdateActions<CartUpdateAction>(version: cart.version, actions: [.setShippingAddress(address: Address(country: "DE"))])

                Cart.update(cart.id, storeKey: self.storeKey, actions: updateActions) { result in
                    XCTAssert(result.isSuccess)

                    let cart = result.model!
                    XCTAssertEqual(cart.store!.key, self.storeKey)
                    XCTAssertEqual(cart.shippingAddress!.country, "DE")

                    Cart.delete(cart.id, storeKey: self.storeKey, version: cart.version) { result in
                        XCTAssert(result.isSuccess)
                        storeExpectation.fulfill()
                    }
                }
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateNonStoreCart() {

        let storeExpectation = expectation(description: "cart store expectation")

        let cartDraft = CartDraft(currency: "EUR")

        Cart.create(cartDraft) { result in
            XCTAssert(result.isSuccess)

            let cart = result.model!
            XCTAssertNil(cart.store)

            let updateActions = UpdateActions<CartUpdateAction>(version: cart.version, actions: [.setShippingAddress(address: Address(country: "DE"))])

            Cart.update(cart.id, storeKey: self.storeKey, actions: updateActions) { result in
                XCTAssert(result.isFailure)

                if let error = result.errors?.first as? CTError, case .resourceNotFoundError(_) = error {
                    XCTAssert(result.isFailure)
                    XCTAssertEqual(result.statusCode, 404)
                    storeExpectation.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 100, handler: nil)
    }
}
