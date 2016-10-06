//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import Commercetools

class ProductProjectionTests: XCTestCase {

    private class TestTaxCategory: QueryEndpoint, Mappable {
        public typealias ResponseType = TestTaxCategory
        static let path = "tax-categories"
        required init?(map: Map) {}
        func mapping(map: Map) {}
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

        let searchExpectation = expectation(description: "search expectation")

        ProductProjection.search(sort: ["name.en asc"], limit: 10, lang: Locale(identifier: "en"),
                                 text: "Michael Kors", result: { result in
            if let response = result.json, let total = response["total"] as? Int,
                    let _ = response["results"] as? [[String: AnyObject]], result.isSuccess && total == 103 {
                searchExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testSearchFacets() {

        let searchExpectation = expectation(description: "search expectation")

        ProductProjection.search(staged: true, filterFacets: "variants.attributes.color.key:\"red\"",
                facets: ["variants.attributes.color.key", "variants.attributes.commonSize.key"], result: { result in
            if let response = result.json, let facets = response["facets"] as? [String: AnyObject],
                    let colorFacets = facets["variants.attributes.color.key"] as? [String: AnyObject],
                    let colorFacetsTotal = colorFacets["total"] as? UInt, let colorTerms = colorFacets["terms"] as? [[String: AnyObject]],
                    let blueTerm = colorTerms.first!["term"] as? String, let blueCount = colorTerms.first!["count"] as? UInt,

                    let sizeFacets = facets["variants.attributes.commonSize.key"] as? [String: AnyObject],
                    let sizeFacetsTotal = sizeFacets["total"] as? UInt, let sizeTerms = sizeFacets["terms"] as? [[String: AnyObject]],
                    let xxxlTerm = sizeTerms.first!["term"] as? String, let xxxlCount = sizeTerms.first!["count"] as? UInt

           , result.isSuccess && colorFacetsTotal == 8703 && blueTerm == "blue" && blueCount == 1865
                    && sizeFacetsTotal == 278 && xxxlTerm == "xxxl" && xxxlCount == 45 {

                searchExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testSearchFilter() {

        let searchExpectation = expectation(description: "search expectation")

        TestTaxCategory.query(limit: 1, result: { result in
            if let response = result.json, let results = response["results"] as? [[String: AnyObject]],
                    let taxCategoryId = results.first?["id"] as? String, result.isSuccess {

                ProductProjection.search(staged: true, limit: 1, filterQuery: "taxCategory.id:\"\(taxCategoryId)\"",
                        result: { result in

                    if let response = result.json, let total = response["total"] as? Int,
                            let _ = response["results"] as? [[String: AnyObject]], result.isSuccess && total == 999 {
                        searchExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testSearchWithExpansion() {

        let searchExpectation = expectation(description: "search expectation")

        ProductProjection.search(expansion: ["productType"], limit: 10, lang: Locale(identifier: "en"), text: "Michael Kors",
                result: { result in
                    if let response = result.json, let _ = response["count"] as? Int,
                            let results = response["results"] as? [[String: AnyObject]],
                            let productType = results.first?["productType"] as? [String: AnyObject],
                            let productTypeObject = productType["obj"] as? [String: AnyObject], result.isSuccess
                            && productTypeObject.count > 0 {
                        searchExpectation.fulfill()
                    }
                })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testSuggestions() {

        let suggestExpectation = expectation(description: "suggest expectation")

        ProductProjection.suggest(lang: Locale(identifier: "en"), searchKeywords: "michael", result: { result in
            if let response = result.json, let keywords = response["searchKeywords.en"] as? [[String: AnyObject]],
            let _ = keywords.first?["text"] as? String, result.isSuccess {
                suggestExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testById() {

        let byIdExpectation = expectation(description: "byId expectation")

        ProductProjection.query(limit: 1, result: { result in
            if let response = result.json, let count = response["count"] as? Int,
                    let results = response["results"] as? [[String: AnyObject]],
                    let id = results.first?["id"] as? String, result.isSuccess && count == 1 {

                ProductProjection.byId(id, result: { result in
                    if let response = result.json, let retrievedId = response["id"] as? String, result.isSuccess
                            && retrievedId == id {
                        byIdExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testByIdError() {

        let byIdExpectation = expectation(description: "byId expectation")

        ProductProjection.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
            if let error = result.errors?.first as? CTError, case .resourceNotFoundError(let reason) = error,
                    reason.message == "The Resource with ID 'cddddddd-ffff-4b44-b5b0-004e7d4bc2dd' was not found." {
                byIdExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testQueryPredicate() {

        let queryExpectation = expectation(description: "query expectation")

        let predicate = "slug(en=\"michael-kors-bag-30T3GTVT7L-lightbrown\")"

        ProductProjection.query(predicates: [predicate], result: { result in
            if let response = result.json, let count = response["count"] as? Int,
            let results = response["results"] as? [[String: AnyObject]],
            let slug = results.first?["slug"] as? [String: String],
            let enSlug = slug["en"], result.isSuccess && count == 1
                    && enSlug == "michael-kors-bag-30T3GTVT7L-lightbrown" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testQuerySortAndLimit() {

        let queryExpectation = expectation(description: "query expectation")

        ProductProjection.query(sort: ["name.en asc"], limit: 8, result: { result in
            if let response = result.json, let count = response["count"] as? Int,
            let results = response["results"] as? [[String: AnyObject]],
            let name = results.first?["name"] as? [String: String], let enName = name["en"],
                    result.isSuccess && count == 8 && enName == "Alberto Guardiani – Slip on “Cherie”" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testQueryOffset() {

        let queryExpectation = expectation(description: "query expectation")

        ProductProjection.query(sort: ["name.en asc"], limit: 2, offset: 1, result: { result in
            if let response = result.json, let count = response["count"] as? Int,
            let results = response["results"] as? [[String: AnyObject]],
            let name = results.first?["name"] as? [String: String], let enName = name["en"],
                    result.isSuccess && count == 2 && enName == "Bag DKNY beige" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMultiSortQuery() {

        let queryExpectation = expectation(description: "query expectation")

        ProductProjection.query(sort: ["name.en asc", "slug.en asc"], limit: 1, result: { result in
            if let response = result.json, let count = response["count"] as? Int,
            let results = response["results"] as? [[String: AnyObject]],
            let name = results.first?["name"] as? [String: String], let enName = name["en"],
                    result.isSuccess && count == 1 && enName == "Alberto Guardiani – Slip on “Cherie”" {
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testExpansionQueryEndpoint() {

        let queryExpectation = expectation(description: "query expectation")

        let predicate = "name(en=\"Bag “Jet Set Travel” Michael Kors light brown\")"

        ProductProjection.query(predicates: [predicate], expansion: ["productType"], result: { result in
            if let response = result.json, let _ = response["count"] as? Int,
                    let results = response["results"] as? [[String: AnyObject]],
                    let productType = results.first?["productType"] as? [String: AnyObject],
                    let productTypeObject = productType["obj"] as? [String: AnyObject], result.isSuccess
                    && productTypeObject.count > 0 {
                queryExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

}
