//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ByKeyEndpointTests: XCTestCase {

    private class TestProductType: ByKeyEndpoint {
        static let path = "product-types"
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

    func testByKeyEndpoint() {

        let byKeyExpectation = expectationWithDescription("byKey expectation")

        TestProductType.byKey("main", result: { result in
            if let response = result.response, description = response["description"] as? String
                    where result.isSuccess && description == "all products of max" {
                byKeyExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testByKeyEndpointError() {

        let byKeyExpectation = expectationWithDescription("byKey expectation")

        TestProductType.byKey("second", result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                    where errorReason == "The Resource with key 'second' was not found." &&
                    error.code == Error.Code.ResourceNotFoundError.rawValue {
                byKeyExpectation.fulfill()
            }

        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

}
