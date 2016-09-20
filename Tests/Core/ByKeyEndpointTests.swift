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

        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testByKeyEndpoint() {

        let byKeyExpectation = expectation(description: "byKey expectation")

        TestProductType.byKey("main", result: { result in
            if let response = result.response, let description = response["description"] as? String,
                    result.isSuccess && description == "all products of max" {
                byKeyExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testByKeyEndpointError() {

        let byKeyExpectation = expectation(description: "byKey expectation")

        TestProductType.byKey("second", result: { result in
            if let error = result.errors?.first as? NSError, let errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String,
                    errorReason == "The Resource with key 'second' was not found." &&
                    error.code == CTError.Code.resourceNotFoundError.rawValue && result.statusCode == 404 {
                byKeyExpectation.fulfill()
            }

        })

        waitForExpectations(timeout: 10, handler: nil)
    }

}
