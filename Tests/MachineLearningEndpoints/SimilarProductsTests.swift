//
// Copyright (c) 2018 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class SimilarProductsTests: XCTestCase {

    override func setUp() {
        super.setUp()

        setupTestConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testInitiation() {
        let similarProductsExpectation = expectation(description: "similar products initiation expectation")

        let request = SimilarProductSearchRequest(limit: 10, similarityMeasures: SimilarityMeasures(name: 1))

        SimilarProducts.initiateSearch(request: request) { result in
            XCTAssert(result.isSuccess)
            XCTAssertNotNil(result.model)
            similarProductsExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testStatus() {
        weak var similarProductsExpectation = expectation(description: "similar products status expectation")
        var timer: Timer!

        let request = SimilarProductSearchRequest(limit: 3, similarityMeasures: SimilarityMeasures(name: 1))

        SimilarProducts.initiateSearch(request: request) { result in
            XCTAssert(result.isSuccess)
            XCTAssertNotNil(result.model)
            let taskId = result.model!.taskId
            DispatchQueue.main.async {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    SimilarProducts.status(for: taskId) { result in
                        XCTAssert(result.isSuccess)
                        XCTAssertNotNil(result.model)
                        if result.model!.state == .success {
                            XCTAssertEqual(result.model!.result!.results.count, 3)
                            similarProductsExpectation?.fulfill()
                        }
                    }
                }
            }
        }

        waitForExpectations(timeout: 100, handler: { _ in
            timer?.invalidate()
        })
    }

    func testProductSelection() {
        weak var similarProductsExpectation = expectation(description: "similar products selection expectation")
        var timer: Timer!

        ProductProjection.query(limit: 2) { result in
            XCTAssert(result.isSuccess)
            XCTAssertNotNil(result.model)
            let productIds = result.model!.results.map { $0.id }

            let request = SimilarProductSearchRequest(limit: 3, productSetSelectors: productIds.map { ProductSetSelector(productIds: [$0]) })

            SimilarProducts.initiateSearch(request: request) { result in
                XCTAssert(result.isSuccess)
                XCTAssertNotNil(result.model)
                let taskId = result.model!.taskId
                DispatchQueue.main.async {
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        SimilarProducts.status(for: taskId) { result in
                            XCTAssert(result.isSuccess)
                            XCTAssertNotNil(result.model)
                            if result.model!.state == .success {
                                XCTAssertEqual(result.model!.result!.results[0].products.filter({ productIds.contains($0.product.id) }).count, 2)
                                similarProductsExpectation?.fulfill()
                            }
                        }
                    }
                }
            }
        }

        waitForExpectations(timeout: 100, handler: { _ in
            timer?.invalidate()
        })
    }
}
