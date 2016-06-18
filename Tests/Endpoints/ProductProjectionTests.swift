//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ProductProjectionTests: XCTestCase {

    private class TestTaxCategory: QueryEndpoint {
        static let path = "tax-categories"
    }

    override func setUp() {
        super.setUp()

        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testSearch() {

        let searchExpectation = expectationWithDescription("search expectation")

        ProductProjection.search(sort: ["name.en asc"], limit: 10, lang: NSLocale(localeIdentifier: "en"),
                                 text: "Michael Kors", result: { result in
            if let response = result.response, total = response["total"] as? Int,
                    _ = response["results"] as? [[String: AnyObject]] where result.isSuccess && total == 103 {
                searchExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testSearchFacets() {

        let searchExpectation = expectationWithDescription("search expectation")

        ProductProjection.search(staged: true, filterFacets: "variants.attributes.color.key:\"red\"",
                facets: ["variants.attributes.color.key", "variants.attributes.commonSize.key"], result: { result in
            if let response = result.response, facets = response["facets"] as? [String: AnyObject],
                    colorFacets = facets["variants.attributes.color.key"] as? [String: AnyObject],
                    colorFacetsTotal = colorFacets["total"] as? UInt, colorTerms = colorFacets["terms"] as? [[String: AnyObject]],
                    blueTerm = colorTerms.first!["term"] as? String, blueCount = colorTerms.first!["count"] as? UInt,

                    sizeFacets = facets["variants.attributes.commonSize.key"] as? [String: AnyObject],
                    sizeFacetsTotal = sizeFacets["total"] as? UInt, sizeTerms = sizeFacets["terms"] as? [[String: AnyObject]],
                    xxxlTerm = sizeTerms.first!["term"] as? String, xxxlCount = sizeTerms.first!["count"] as? UInt

            where result.isSuccess && colorFacetsTotal == 8703 && blueTerm == "blue" && blueCount == 1865
                    && sizeFacetsTotal == 278 && xxxlTerm == "xxxl" && xxxlCount == 45 {

                searchExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testSearchFilter() {

        let searchExpectation = expectationWithDescription("search expectation")

        TestTaxCategory.query(limit: 1, result: { result in
            if let response = result.response, results = response["results"] as? [[String: AnyObject]],
                    taxCategoryId = results.first?["id"] as? String where result.isSuccess {

                ProductProjection.search(staged: true, limit: 1, filterQuery: "taxCategory.id:\"\(taxCategoryId)\"",
                        result: { result in

                    if let response = result.response, total = response["total"] as? Int, _ = response["results"] as? [[String: AnyObject]]
                            where result.isSuccess && total == 999 {
                        searchExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testSearchWithExpansion() {

        let searchExpectation = expectationWithDescription("search expectation")

        ProductProjection.search(limit: 10, expansion: ["productType"],  lang: NSLocale(localeIdentifier: "en"), text: "Michael Kors",
                result: { result in
                    if let response = result.response, _ = response["count"] as? Int,
                            results = response["results"] as? [[String: AnyObject]],
                            productType = results.first?["productType"] as? [String: AnyObject],
                            productTypeObject = productType["obj"] as? [String: AnyObject] where result.isSuccess
                            && productTypeObject.count > 0 {
                        searchExpectation.fulfill()
                    }
                })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testSuggestions() {

        let suggestExpectation = expectationWithDescription("suggest expectation")

        ProductProjection.suggest(lang: NSLocale(localeIdentifier: "en"), searchKeywords: "michael", result: { result in
            if let response = result.response, keywords = response["searchKeywords.en"] as? [[String: AnyObject]],
            _ = keywords.first?["text"] as? String where result.isSuccess {
                suggestExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testById() {

        let byIdExpectation = expectationWithDescription("byId expectation")

        ProductProjection.query(limit: 1, result: { result in
            if let response = result.response, count = response["count"] as? Int,
                    results = response["results"] as? [[String: AnyObject]],
                    id = results.first?["id"] as? String where result.isSuccess && count == 1 {

                ProductProjection.byId(id, result: { result in
                    if let response = result.response, retrievedId = response["id"] as? String where result.isSuccess
                            && retrievedId == id {
                        byIdExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testByIdError() {

        let byIdExpectation = expectationWithDescription("byId expectation")

        ProductProjection.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                    where errorReason == "The Resource with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found." &&
                           error.code == Error.Code.ResourceNotFoundError.rawValue {
                byIdExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testQueryPredicate() {

        let queryExpectation = expectationWithDescription("query expectation")

        let predicate = "slug(en=\"michael-kors-bag-30T3GTVT7L-lightbrown\")"

        ProductProjection.query(predicates: [predicate], result: { result in
            if let response = result.response, count = response["count"] as? Int,
            results = response["results"] as? [[String: AnyObject]],
            slug = results.first?["slug"] as? [String: String],
            enSlug = slug["en"] where result.isSuccess && count == 1
                    && enSlug == "michael-kors-bag-30T3GTVT7L-lightbrown" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testQuerySortAndLimit() {

        let queryExpectation = expectationWithDescription("query expectation")

        ProductProjection.query(sort: ["name.en asc"], limit: 8, result: { result in
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

        ProductProjection.query(sort: ["name.en asc"], limit: 2, offset: 1, result: { result in
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

        ProductProjection.query(sort: ["name.en asc", "slug.en asc"], limit: 1, result: { result in
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

        ProductProjection.query(predicates: [predicate], expansion: ["productType"], result: { result in
            if let response = result.response, _ = response["count"] as? Int,
                    results = response["results"] as? [[String: AnyObject]],
                    productType = results.first?["productType"] as? [String: AnyObject],
                    productTypeObject = productType["obj"] as? [String: AnyObject] where result.isSuccess
                    && productTypeObject.count > 0 {
                queryExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

}