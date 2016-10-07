//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ByIdEndpointTests: XCTestCase {
    
    private class TestCart: ByIdEndpoint, CreateEndpoint {
        typealias ResponseType = Cart
        typealias RequestDraft = NoMapping
        static let path = "me/carts"
    }

    private class TestProductProjections: ByIdEndpoint, QueryEndpoint {
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

    func testByIdEndpoint() {
        
        let byIdExpectation = expectation(description: "byId expectation")
        
        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"
        
        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})
        
        TestCart.create(["currency": "EUR"], result: { result in
            if let response = result.json, let id = response["id"] as? String, result.isSuccess {
                TestCart.byId(id, result: { result in
                    if let response = result.json, let cartState = response["cartState"] as? String,
                            let version = response["version"] as? Int, let obtainedId = response["id"] as? String, result.isSuccess && cartState == "Active" && version == 1 && obtainedId == id {
                        byIdExpectation.fulfill()
                    }
                })
            }
        })
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testByIdEndpointError() {

        let byIdExpectation = expectation(description: "byId expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
            if let error = result.errors?.first as? CTError, result.statusCode == 404, case .resourceNotFoundError(let reason) = error,
                    reason.message == "The Resource with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found." {
                byIdExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testExpansionByIdEndpoint() {

        let byIdExpectation = expectation(description: "byId expectation")

        TestProductProjections.query(limit: 1, result: { result in
            if let response = result.json, let results = response["results"] as? [[String: AnyObject]],
                    let id = results.first?["id"] as? String, result.isSuccess {
                TestProductProjections.byId(id, expansion: ["productType"], result: { result in
                    if let response = result.json, let productType = response["productType"] as? [String: AnyObject],
                    let productTypeObject = productType["obj"] as? [String: AnyObject], result.isSuccess && productTypeObject.count > 0 {
                        byIdExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }


    
}
