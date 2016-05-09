//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ByIdEndpointTests: XCTestCase {
    
    private class TestCart: ByIdEndpoint, CreateEndpoint {
        static let path = "me/carts"
    }

    private class TestProductProjections: ByIdEndpoint, QueryEndpoint {
        static let path = "product-projections"
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

    func testByIdEndpoint() {
        
        let byIdExpectation = expectationWithDescription("byId expectation")
        
        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"
        
        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})
        
        TestCart.create(["currency": "EUR"], result: { result in
            if let response = result.response, id = response["id"] as? String where result.isSuccess {
                TestCart.byId(id, result: { result in
                    if let response = result.response, cartState = response["cartState"] as? String,
                            version = response["version"] as? Int, obtainedId = response["id"] as? String
                            where result.isSuccess && cartState == "Active" && version == 1 && obtainedId == id {
                        byIdExpectation.fulfill()
                    }
                })
            }
        })
        
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testByIdEndpointError() {

        let byIdExpectation = expectationWithDescription("byId expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                where errorReason == "The Resource with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found." &&
                       error.code == Error.Code.ResourceNotFoundError.rawValue {
                byIdExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testExpansionByIdEndpoint() {

        let byIdExpectation = expectationWithDescription("byId expectation")

        TestProductProjections.query(limit: 1, result: { result in
            if let response = result.response, results = response["results"] as? [[String: AnyObject]],
                    id = results.first?["id"] as? String where result.isSuccess {
                TestProductProjections.byId(id, expansion: ["productType"], result: { result in
                    if let response = result.response, productType = response["productType"] as? [String: AnyObject],
                    productTypeObject = productType["obj"] as? [String: AnyObject]
                    where result.isSuccess && productTypeObject.count > 0 {
                        byIdExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }


    
}
