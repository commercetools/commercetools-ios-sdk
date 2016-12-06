//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class QueryEndpointTests: XCTestCase {

    private class TestProductProjections: QueryEndpoint {
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

    func testQueryPredicate() {

        let queryExpectation = expectation(description: "query expectation")

        let predicate = "slug(en=\"michael-kors-bag-30T3GTVT7L-lightbrown\")"

        TestProductProjections.query(predicates: [predicate], result: { result in
            if let response = result.json, let count = response["count"] as? Int,
                    let results = response["results"] as? [[String: AnyObject]],
                    let slug = results.first?["slug"] as? [String: String],
                    let enSlug = slug["en"] {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(count, 1)
                XCTAssertEqual(enSlug, "michael-kors-bag-30T3GTVT7L-lightbrown")
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testQuerySortAndLimit() {

        let queryExpectation = expectation(description: "query expectation")

        TestProductProjections.query(sort: ["name.en asc"], limit: 8, result: { result in
            if let response = result.json, let count = response["count"] as? Int,
               let results = response["results"] as? [[String: AnyObject]],
               let name = results.first?["name"] as? [String: String], let enName = name["en"] {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(count, 8)
                XCTAssertEqual(enName, "Alberto Guardiani – Slip on “Cherie”")
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testQueryOffset() {

        let queryExpectation = expectation(description: "query expectation")

        TestProductProjections.query(sort: ["name.en asc"], limit: 2, offset: 1, result: { result in
            if let response = result.json, let count = response["count"] as? Int,
               let results = response["results"] as? [[String: AnyObject]],
               let name = results.first?["name"] as? [String: String], let enName = name["en"] {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(count, 2)
                XCTAssertEqual(enName, "Bag DKNY beige")
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMultiSortQuery() {

        let queryExpectation = expectation(description: "query expectation")

        TestProductProjections.query(sort: ["name.en asc", "slug.en asc"], limit: 1, result: { result in
            if let response = result.json, let count = response["count"] as? Int,
               let results = response["results"] as? [[String: AnyObject]],
               let name = results.first?["name"] as? [String: String], let enName = name["en"] {
                XCTAssert(result.isSuccess)
                XCTAssertEqual(count, 1)
                XCTAssertEqual(enName, "Alberto Guardiani – Slip on “Cherie”")
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testExpansionQueryEndpoint() {

        let queryExpectation = expectation(description: "query expectation")

        let predicate = "name(en=\"Bag “Jet Set Travel” Michael Kors light brown\")"

        TestProductProjections.query(predicates: [predicate], expansion: ["productType"], result: { result in
            if let response = result.json, let _ = response["count"] as? Int,
               let results = response["results"] as? [[String: AnyObject]],
               let productType = results.first?["productType"] as? [String: AnyObject],
               let productTypeObject = productType["obj"] as? [String: AnyObject] {
                XCTAssert(result.isSuccess)
                XCTAssertGreaterThan(productTypeObject.count, 0)
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }
}
