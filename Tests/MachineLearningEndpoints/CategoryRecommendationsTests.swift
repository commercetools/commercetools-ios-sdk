//
// Copyright (c) 2018 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class CategoryRecommendationsTests: XCTestCase {

    override func setUp() {
        super.setUp()

        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testCategoryRecommendationsForProject() {
        let categoryRecommendationsExpectation = expectation(description: "category recommendations expectation")

        sampleProduct { product in
            CategoryRecommendations.query(productId: product.id) { result in
                XCTAssert(result.isSuccess)
                XCTAssertNotNil(result.model)
                categoryRecommendationsExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testRecommendationsInConfidenceRange() {
        let categoryRecommendationsExpectation = expectation(description: "category recommendations expectation")

        sampleProduct { product in
            CategoryRecommendations.query(productId: product.id, confidenceMin: 0.3, confidenceMax: 0.8, limit: 20) { result in
                XCTAssert(result.isSuccess)
                XCTAssertNotNil(result.model)
                let results = result.model!.results
                XCTAssertEqual(results.filter({ $0.confidence < 0.3 || $0.confidence > 0.8 }).count, 0)
                categoryRecommendationsExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 30, handler: nil)
    }

    private func sampleProduct(_ completion: @escaping (ProductProjection) -> Void) {
        ProductProjection.query(limit: 1, result: { result in
            if let product = result.model?.results.first, result.isSuccess {
                completion(product)
            }
        })
    }
}