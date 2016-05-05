//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class UpdateByKeyEndpointTests: XCTestCase {

    private class TestProductType: ByKeyEndpoint, UpdateByKeyEndpoint {
        static let path = "product-types"
    }

    override func setUp() {
        super.setUp()

        cleanPersistedTokens()
        setupProjectManagementConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testUpdateEndpoint() {

        let updateExpectation = expectationWithDescription("update expectation")

        TestProductType.byKey("main", result: { result in
            if let response = result.response, originalName = response["name"] as? String,
                    version = response["version"] as? UInt where result.isSuccess && originalName == "main" {

                var changeNameAction = ["action": "changeName", "name": "newName"]

                TestProductType.updateByKey("main", version: version, actions: [changeNameAction], result: { result in
                    if let response = result.response, newName = response["name"] as? String,
                            version = response["version"] as? UInt where result.isSuccess && newName == "newName" {

                        // Now revert back to the original name for the test data consistency reasons
                        changeNameAction["name"] = originalName

                        TestProductType.updateByKey("main", version: version, actions: [changeNameAction], result: { result in
                            if let response = result.response, name = response["name"] as? String
                                    where result.isSuccess && name == originalName {
                                updateExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testConcurrentModification() {

        let updateExpectation = expectationWithDescription("update expectation")

        TestProductType.byKey("main", result: { result in
            if let response = result.response, version = response["version"] as? UInt,
                    id = response["id"] as? String where result.isSuccess {

                let changeNameAction = ["action": "changeName", "name": "newName"]

                TestProductType.updateByKey("main", version: version + 1, actions: [changeNameAction], result: { result in
                    if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                            where errorReason.hasPrefix("Object \(id) has a different version than expected.") &&
                            error.code == Error.Code.ConcurrentModificationError.rawValue {
                        updateExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testUpdateEndpointError() {

        let updateExpectation = expectationWithDescription("update expectation")

        let changeNameAction = ["action": "changeName", "name": "newName"]

        TestProductType.updateByKey("incorrect_key", version: 1, actions: [changeNameAction], result: { result in
            if let error = result.errors?.first, errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                    where errorReason == "The product-type with key 'incorrect_key' was not found." &&
                    error.code == Error.Code.ResourceNotFoundError.rawValue {
                updateExpectation.fulfill()
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

}
