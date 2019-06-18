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

    private class TestOrder: QueryEndpoint, DeleteEndpoint {
        public typealias ResponseType = Order
        public typealias RequestDraft = NoMapping
        static let path = "in-store/key=unionSquare/orders"
    }

    private class TestCart: QueryEndpoint, DeleteEndpoint {
        public typealias ResponseType = Cart
        public typealias RequestDraft = NoMapping
        static let path = "in-store/key=unionSquare/carts"
    }

    private var storeId = "aa3b9e48-638c-460f-85c2-9c1162b3c3da"//: String!

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

        let group = DispatchGroup()

        // For deleting a store we need higher privileges
        setupProjectManagementConfiguration()

        group.enter()
        // Remove orders created during tests
        TestOrder.query() { result in
            let orders = result.model!.results
            if !orders.isEmpty {
                for order in orders {
                    group.enter()
                    TestOrder.delete(order.id, version: order.version) { _ in
                        group.leave()
                    }
                }
            }
            group.leave()
        }
        group.enter()
        // Remove carts created during tests
        TestCart.query() { result in
            let carts = result.model!.results
            if !carts.isEmpty {
                for cart in carts {
                    group.enter()
                    TestCart.delete(cart.id, version: cart.version) { _ in
                        group.leave()
                    }
                }
            }
            group.leave()
        }
        group.wait()
        group.wait()

        group.enter()
        TestStore.delete(self.storeId, version: 1) { result in
            print(result)
            group.leave()
        }
        group.wait()

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
                storeExpectation.fulfill()
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

                        Cart.active(storeKey: self.storeKey) { result in
                            XCTAssert(result.isSuccess)

                            XCTAssertEqual(result.model!.store!.key, self.storeKey)
                            XCTAssertEqual(result.model!.id, cart.id)
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

    func testCreateAndRetrieveStoreOrder() {

        let storeExpectation = expectation(description: "cart store expectation")

        sampleLineItemDraft { lineItemDraft in
            let cartDraft = CartDraft(currency: "EUR", lineItems: [lineItemDraft], shippingAddress: Address(country: "DE"))

            Cart.create(cartDraft, storeKey: self.storeKey) { result in
                XCTAssert(result.isSuccess)

                let cart = result.model!
                XCTAssertEqual(cart.store!.key, self.storeKey)

                Order.create(OrderDraft(id: cart.id, version: cart.version), storeKey: self.storeKey) { result in
                    XCTAssert(result.isSuccess)

                    let order = result.model!
                    XCTAssertEqual(order.store!.key, self.storeKey)

                    Order.byId(order.id, storeKey: self.storeKey) { result in
                        XCTAssert(result.isSuccess)

                        XCTAssertEqual(result.model!.id, order.id)
                        storeExpectation.fulfill()
                    }
                }
            }
        }

        waitForExpectations(timeout: 100, handler: nil)
    }

    private func sampleLineItemDraft(_ completion: @escaping (LineItemDraft) -> Void) {
        ProductProjection.query(limit:1, result: { result in
            if let product = result.model?.results.first, result.isSuccess {
                let lineItemDraft = LineItemDraft(productVariantSelection: .productVariant(productId: product.id, variantId: product.masterVariant.id), quantity: 3)
                completion(lineItemDraft)
            }
        })
    }
}
