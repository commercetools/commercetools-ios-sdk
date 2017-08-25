//
// Copyright (c) 2017 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ShoppingListTests: XCTestCase {

    override func setUp() {
        super.setUp()

        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testShoppingListCreation() {
        let listCreationExpectation = expectation(description: "list creation expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        sampleLineItemDraft { productId, variantId in
            let listDraft = ShoppingListDraft(name: ["en": "testName"], description: ["en": "testDesc"], lineItems: [ShoppingListDraft.LineItemDraft(productId: productId, variantId: variantId)], textLineItems: [TextLineItemDraft(name: ["en": "testName"])], deleteDaysAfterLastModification: 1)

            ShoppingList.create(listDraft, result: { result in
                if let shoppingList = result.model {
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(shoppingList.name, ["en": "testName"])
                    XCTAssertEqual(shoppingList.textLineItems.first!.name, ["en": "testName"])
                    XCTAssertEqual(shoppingList.lineItems.first!.productId, productId)
                    listCreationExpectation.fulfill()
                }
            })
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testShoppingListRetrievalById() {
        let listRetrievalExpectation = expectation(description: "list retrieval expectation")

        let listDraft = ShoppingListDraft(name: ["en": "testName"], deleteDaysAfterLastModification: 1)

        ShoppingList.create(listDraft, result: { result in
            if let createdList = result.model {
                ShoppingList.byId(createdList.id) { result in
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(result.model!.id, createdList.id)
                    listRetrievalExpectation.fulfill()
                }
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateEndpointWithModelAction() {
        let updateExpectation = expectation(description: "update expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginCustomer(username: username, password: password, completionHandler: { _ in})

        sampleLineItemDraft { productId, variantId in
            let listDraft = ShoppingListDraft(name: ["en": "testName"], description: ["en": "testDesc"], lineItems: [ShoppingListDraft.LineItemDraft(productId: productId, variantId: variantId)], deleteDaysAfterLastModification: 1)

            ShoppingList.create(listDraft, result: { result in
                if let shoppingList = result.model {
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(shoppingList.name, ["en": "testName"])
                    XCTAssertEqual(shoppingList.lineItems.first!.productId, productId)
                    let updateActions: [ShoppingListUpdateAction] = [.removeLineItem(lineItemId: shoppingList.lineItems.first!.id, quantity: nil), .changeName(name: ["en": "updatedName"])]
                    ShoppingList.update(shoppingList.id, actions: UpdateActions(version: shoppingList.version, actions: updateActions)) { result in
                        if let shoppingList = result.model {
                            XCTAssert(result.isSuccess)
                            XCTAssertEqual(shoppingList.name, ["en": "updatedName"])
                            XCTAssertEqual(shoppingList.textLineItems.count, 0)
                            updateExpectation.fulfill()
                        }
                    }
                }
            })
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testDeleteShoppingList() {
        let listRemovalExpectation = expectation(description: "list removal expectation")

        let listDraft = ShoppingListDraft(name: ["en": "testName"])

        ShoppingList.create(listDraft, result: { result in
            if let createdList = result.model {
                ShoppingList.delete(createdList.id, version: createdList.version) { result in
                    XCTAssert(result.isSuccess)
                    XCTAssertEqual(result.model!.id, createdList.id)
                    listRemovalExpectation.fulfill()
                }
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    private func sampleLineItemDraft(_ completion: @escaping (String, Int) -> Void) {
        ProductProjection.query(limit:1, result: { result in
            if let product = result.model?.results.first, result.isSuccess {
                completion(product.id, product.masterVariant.id)
            }
        })
    }
}
