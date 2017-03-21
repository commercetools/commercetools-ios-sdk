//
// Copyright (c) 2017 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class ProjectSettingsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        setupTestConfiguration()
    }
    
    override func tearDown() {
        cleanPersistedTokens()
        super.tearDown()
    }
    
    func testRetrieveProjectSettings() {
        let projectSettingsExpectation = expectation(description: "project settings expectation")
        
        Project.settings { result in
            XCTAssert(result.isSuccess)
            if let settings = result.model {
                XCTAssertEqual(settings.key, "swift-development-42")
                XCTAssertEqual(settings.name, "Swift Development")
                XCTAssertEqual(settings.currencies?.first, "EUR")
                projectSettingsExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }    
}