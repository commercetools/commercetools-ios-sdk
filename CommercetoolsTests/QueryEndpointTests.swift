//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class QueryEndpointTests: XCTestCase {

    private class TestProductProjections: QueryEndpoint {
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

    func testQueryPredicate() {

        let queryExpectation = expectationWithDescription("query expectation")

        let predicate = "slug(en=\"michael-kors-bag-30T3GTVT7L-lightbrown\")"

        TestProductProjections.query(predicates: [predicate], result: { result in
            if let response = result.response, count = response["count"] as? Int,
                    results = response["results"] as? [[String: AnyObject]], id = results.first?["id"] as? String
                    where result.isSuccess && count == 1 && id == "a9fd9c74-d00a-4de7-8258-6a9920abc66b" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testQuerySortAndLimit() {

        let queryExpectation = expectationWithDescription("query expectation")

        TestProductProjections.query(sort: ["name.en asc"], limit: 8, result: { result in
            if let response = result.response, count = response["count"] as? Int,
                    results = response["results"] as? [[String: AnyObject]],
                    name = results.first?["name"] as? [String: String], enName = name["en"]
                    where result.isSuccess && count == 8 && enName == "Alberto Guardiani – Slip on “Cherie”" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testQueryOffset() {

        let queryExpectation = expectationWithDescription("query expectation")

        TestProductProjections.query(sort: ["name.en asc"], limit: 2, offset: 1, result: { result in
            if let response = result.response, count = response["count"] as? Int,
                    results = response["results"] as? [[String: AnyObject]],
                    name = results.first?["name"] as? [String: String], enName = name["en"]
                    where result.isSuccess && count == 2 && enName == "Bag DKNY beige" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testMultiSortQuery() {

        let queryExpectation = expectationWithDescription("query expectation")

        TestProductProjections.query(sort: ["name.en asc", "slug.en asc"], limit: 1, result: { result in
            if let response = result.response, count = response["count"] as? Int,
            results = response["results"] as? [[String: AnyObject]],
            name = results.first?["name"] as? [String: String], enName = name["en"]
            where result.isSuccess && count == 1 && enName == "Alberto Guardiani – Slip on “Cherie”" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testExpansionQueryEndpoint() {

        let queryExpectation = expectationWithDescription("query expectation")

        let predicate = "name(en=\"Bag “Jet Set Travel” Michael Kors light brown\")"

        TestProductProjections.query(predicates: [predicate], expansion: ["productType"], result: { result in
            if let response = result.response, count = response["count"] as? Int,
                    results = response["results"] as? [[String: AnyObject]],
                    productType = results.first?["productType"] as? [String: AnyObject],
                    productTypeObject = productType["obj"] as? [String: AnyObject]
                    where result.isSuccess && productTypeObject.count > 0 {
                queryExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

}
