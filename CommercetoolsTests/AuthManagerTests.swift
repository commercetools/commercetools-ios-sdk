//
//  Copyright © 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

class AuthManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        cleanPersistedTokens()
    }
    
    override func tearDown() {
        cleanPersistedTokens()
        
        super.tearDown()
    }

    private func cleanPersistedTokens() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.removeObjectForKey("com.commercetools.authAccessTokenKey")
        userDefaults.removeObjectForKey("com.commercetools.authRefreshTokenKey")
        userDefaults.removeObjectForKey("com.commercetools.authTokenValidKey")
    }
    
    private func setupTestConfiguration() {
        let testBundle = NSBundle(forClass: AuthManagerTests.self)
        if let path = testBundle.pathForResource("CommercetoolsTestConfig", ofType: "plist"),
            config = NSDictionary(contentsOfFile: path) {
            Commercetools.config = Config(config: config)
        }
    }
    
    func testUserLogin() {
        setupTestConfiguration()

        let loginExpectation = expectationWithDescription("login expectation")
        let tokenExpectation = expectationWithDescription("token expectation")

        let username = "swift.sdk.test.user@commercetools.com"
        let password = "password"
        let authManager = AuthManager.sharedInstance

        var oldToken: String?
        authManager.token { token, error in oldToken = token }

        authManager.loginUser(username, password: password, completionHandler: { error in
            if error == nil {
                loginExpectation.fulfill()
            }
        })

        authManager.token { token, error in
            if let token = token, oldToken = oldToken where !token.isEmpty && token != oldToken && error == nil {
                tokenExpectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testAnonymousToken() {
        setupTestConfiguration()

        let tokenExpectation = expectationWithDescription("token expectation")

        let authManager = AuthManager.sharedInstance

        authManager.token { token, error in
            if let token = token where !token.isEmpty && error == nil {
                tokenExpectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
