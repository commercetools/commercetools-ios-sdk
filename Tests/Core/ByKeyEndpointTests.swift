//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ByKeyEndpointTests: XCTestCase {

    private class TestProductType: ByKeyEndpoint {
        typealias ResponseType = NoMapping
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
            if let response = result.json, let description = response["description"] as? String {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(description, "Sunrise Product Data Set Structure")
                byKeyExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testByKeyEndpointError() {

        let byKeyExpectation = expectation(description: "byKey expectation")

        TestProductType.byKey("second", result: { result in
            if let error = result.errors?.first as? CTError, case .resourceNotFoundError(let reason) = error {
                XCTAssert(result.isFailure)
                XCTAssertEqual(result.statusCode, 404)
                XCTAssertEqual(reason.message, "The Resource with key 'second' was not found.")
                byKeyExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

}
