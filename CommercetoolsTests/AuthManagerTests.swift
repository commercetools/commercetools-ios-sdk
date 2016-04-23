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
        let tokenStore = AuthManager.sharedInstance.tokenStore
        tokenStore.accessToken = nil
        tokenStore.refreshToken = nil
        tokenStore.tokenValidDate = nil
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
            if let token = token, oldToken = oldToken where !token.isEmpty && token != oldToken &&
                    error == nil && authManager.state == .CustomerToken {
                tokenExpectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testUserLogout() {
        setupTestConfiguration()

        let tokenExpectation = expectationWithDescription("token expectation")

        let username = "swift.sdk.test.user@commercetools.com"
        let password = "password"
        let authManager = AuthManager.sharedInstance

        authManager.loginUser(username, password: password, completionHandler: { error in
            if error == nil {
                // Get the access token after login
                authManager.token { oldToken, error in
                    if let oldToken = oldToken where authManager.state == .CustomerToken {
                        // Then logout user
                        authManager.logoutUser()
                        // Get the access token after logout
                        authManager.token { newToken, error in
                            if let newToken = newToken where newToken != oldToken && authManager.state == .PlainToken {
                                tokenExpectation.fulfill()
                            }
                        }
                    }
                }
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testIncorrectLogin() {
        setupTestConfiguration()

        let loginExpectation = expectationWithDescription("login expectation")
        let tokenExpectation = expectationWithDescription("token expectation")

        let username = "incorrect.sdk.test.user@commercetools.com"
        let password = "password"
        let authManager = AuthManager.sharedInstance

        var oldToken: String?
        authManager.token { token, error in oldToken = token }

        authManager.loginUser(username, password: password, completionHandler: { error in
            if let error = error, errorInfo = error.userInfo[NSLocalizedFailureReasonErrorKey] as? String
                where errorInfo == "invalid_customer_account_credentials" {
                loginExpectation.fulfill()
            }
        })

        authManager.token { token, error in
            if let token = token, oldToken = oldToken where !token.isEmpty && token != oldToken &&
                    error == nil && authManager.state == .PlainToken {
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
            if let token = token where !token.isEmpty && error == nil && authManager.state == .PlainToken {
                tokenExpectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testRefreshToken() {
        setupTestConfiguration()

        let tokenExpectation = expectationWithDescription("token expectation")

        let authManager = AuthManager.sharedInstance
        let tokenStore = authManager.tokenStore

        let username = "swift.sdk.test.user@commercetools.com"
        let password = "password"

        authManager.loginUser(username, password: password, completionHandler: { error in
            if error == nil {

                var oldToken: String?
                authManager.token { token, error in
                    oldToken = token
                    // Remove the access token valid date after login, in order to test the refresh token flow
                    tokenStore.tokenValidDate = nil
                    XCTAssert(!tokenStore.refreshToken!.isEmpty)
                    XCTAssert(oldToken != nil)
                }

                authManager.token { token, error in
                    if let token = token, oldToken = oldToken where error == nil && oldToken != token &&
                            authManager.state == .CustomerToken {
                        tokenExpectation.fulfill()
                    }
                }
            }
        })

        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
