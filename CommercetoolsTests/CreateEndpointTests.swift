//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class CreateEndpointTests: XCTestCase {

    private class TestCart: CreateEndpoint {
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

    func testCreateEndpoint() {

        let createExpectation = expectationWithDescription("create expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.create(["currency": "EUR"], result: { response, errors in
            if let response = response, cartState = response["cartState"] as? String, version = response["version"] as? Int
                    where errors == nil && cartState == "Active" && version == 1 {
                createExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testCreateEndpointError() {

        let createExpectation = expectationWithDescription("create expectation")

        let username = "swift.sdk.test.user2@commercetools.com"
        let password = "password"

        AuthManager.sharedInstance.loginUser(username, password: password, completionHandler: {_ in})

        TestCart.create(["currency": "BAD"], result: { response, errors in
            if let error = errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String,
                    errorDesc = error.userInfo[NSLocalizedDescriptionKey] as? String
                    where errorReason == "Request body does not contain valid JSON." &&
                            errorDesc == "currency: ISO 4217 code JSON String expected" &&
                           error.code == Error.Code.InvalidJsonInputError.rawValue {
                createExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
