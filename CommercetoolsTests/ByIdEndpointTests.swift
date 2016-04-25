//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ByIdEndpointTests: XCTestCase {
    
    private class TestCart: ByIdEndpoint, CreateEndpoint {
        static let path = "me/carts"
    }

    private class TestProductProjections: ByIdEndpoint {
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
    
    private func setupTestConfiguration() {
        let testBundle = NSBundle(forClass: AuthManagerTests.self)
        if let path = testBundle.pathForResource("CommercetoolsTestConfig", ofType: "plist"),
            config = NSDictionary(contentsOfFile: path) {
            Commercetools.config = Config(config: config)
        }
    }
    
    private func cleanPersistedTokens() {
        let tokenStore = AuthManager.sharedInstance.tokenStore
        tokenStore.accessToken = nil
        tokenStore.refreshToken = nil
        tokenStore.tokenValidDate = nil
    }
    
    func testByIdEndpoint() {
        
        let byIdExpectation = expectationWithDescription("byId expectation")
        
        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"
        
        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})
        
        TestCart.create(["currency": "EUR"], result: { response, errors in
            if let response = response, id = response["id"] as? String where errors == nil {
                TestCart.byId(id, result: { response, errors in
                    if let response = response, type = response["type"] as? String,
                            version = response["version"] as? Int, obtainedId = response["id"] as? String
                            where errors == nil && type == "Cart" && version == 1 && obtainedId == id {
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

        TestCart.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { response, errors in
            if let error = errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                where errorReason == "The Resource with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found." &&
                       error.code == Error.Code.ResourceNotFoundError.rawValue {
                byIdExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testExpansionByIdEndpoint() {

        let byIdExpectation = expectationWithDescription("byId expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestProductProjections.byId("a9fd9c74-d00a-4de7-8258-6a9920abc66b", expansion: ["productType"], result: { response, errors in
            if let response = response, productType = response["productType"] as? [String: AnyObject],
                    productTypeObject = productType["obj"] as? [String: AnyObject]
                    where errors == nil && productTypeObject.count > 0 {
                byIdExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }


    
}
