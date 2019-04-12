//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class GraphQLTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testRetrieveCustomerProfile() {
        setupTestConfiguration()

        let query =
            "query TestProducts {" +
            "  products(limit: 1) {" +
            "    results {" +
            "      masterData {" +
            "        current {" +
            "          name(locale: \"en\")" +
            "        }" +
            "      }" +
            "    }" +
            "  }" +
            "}"

        let queryExpectation = expectation(description: "query expectation")

        GraphQL.query(query) { result in
            if let products = (result.json?["data"] as? [String: Any])?["products"] as? [String: Any],
               let results = products["results"] as? [[String: Any]],
               let masterData = results.first?["masterData"] as? [String: Any],
               let current = masterData["current"] as? [String: String],
               let name = current["name"] {
                XCTAssert(result.isSuccess)
                XCTAssertGreaterThan(name.count, 0)
                XCTAssertEqual(results.count, 1)
                queryExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
