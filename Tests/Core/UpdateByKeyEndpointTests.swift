//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class UpdateByKeyEndpointTests: XCTestCase {

    private class TestProductType: ByKeyEndpoint, UpdateByKeyEndpoint {
        typealias ResponseType = NoMapping
        static let path = "product-types"
    }

    override func setUp() {
        super.setUp()

        setupProjectManagementConfiguration()
    }

    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }

    func testUpdateEndpoint() {

        let updateExpectation = expectation(description: "update expectation")

        TestProductType.byKey("main", result: { result in
            if let response = result.json, let originalName = response["name"] as? String,
                    let version = response["version"] as? UInt, result.isSuccess && originalName == "main" {

                var changeNameAction = ["action": "changeName", "name": "newName"]

                TestProductType.updateByKey("main", version: version, actions: [changeNameAction], result: { result in
                    if let response = result.json, let newName = response["name"] as? String,
                            let version = response["version"] as? UInt, result.isSuccess && newName == "newName" {

                        // Now revert back to the original name for the test data consistency reasons
                        changeNameAction["name"] = originalName

                        TestProductType.updateByKey("main", version: version, actions: [changeNameAction], result: { result in
                            if let response = result.json, let name = response["name"] as? String, result.isSuccess && name == originalName {
                                updateExpectation.fulfill()
                            }
                        })
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testConcurrentModification() {

        let updateExpectation = expectation(description: "update expectation")

        TestProductType.byKey("main", result: { result in
            if let response = result.json, let version = response["version"] as? UInt,
                    let id = response["id"] as? String, result.isSuccess {

                let changeNameAction = ["action": "changeName", "name": "newName"]

                TestProductType.updateByKey("main", version: version + 1, actions: [changeNameAction], result: { result in
                    if let error = result.errors?.first as? CTError, result.statusCode == 409, case .concurrentModificationError(let reason, let currentVersion) = error,
                            reason.message!.hasPrefix("Object \(id) has a different version than expected.") && version == currentVersion {
                        updateExpectation.fulfill()
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUpdateEndpointError() {

        let updateExpectation = expectation(description: "update expectation")

        let changeNameAction = ["action": "changeName", "name": "newName"]

        TestProductType.updateByKey("incorrect_key", version: 1, actions: [changeNameAction], result: { result in            
            if let error = result.errors?.first as? CTError, result.statusCode == 404, case .resourceNotFoundError(let reason) = error,
                    reason.message == "The product-type with key 'incorrect_key' was not found." {
                updateExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

}
