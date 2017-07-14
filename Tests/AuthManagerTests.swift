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

    func testUserLogin() {
        setupTestConfiguration()

        let loginExpectation = expectation(description: "login expectation")
        let tokenExpectation = expectation(description: "token expectation")

        let username = "swift.sdk.test.user@commercetools.com"
        let password = "password"
        let authManager = AuthManager.sharedInstance

        var oldToken: String?
        authManager.token { token, error in oldToken = token }

        authManager.loginCustomer(username: username, password: password, completionHandler: { error in
            if error == nil {
                loginExpectation.fulfill()
            }
        })

        authManager.token { token, error in
            if let token = token, let oldToken = oldToken, !token.isEmpty && token != oldToken &&
                    error == nil && authManager.state == .customerToken {
                tokenExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testUserLogout() {
        setupTestConfiguration()

        let tokenExpectation = expectation(description: "token expectation")

        let username = "swift.sdk.test.user@commercetools.com"
        let password = "password"
        let authManager = AuthManager.sharedInstance

        authManager.loginCustomer(username: username, password: password, completionHandler: { error in
            if error == nil {
                // Get the access token after login
                authManager.token { oldToken, error in
                    if let oldToken = oldToken, authManager.state == .customerToken {
                        // Then logout user
                        authManager.logoutCustomer()
                        // Get the access token after logout
                        authManager.token { newToken, error in
                            if let newToken = newToken, newToken != oldToken && authManager.state == .anonymousToken {
                                tokenExpectation.fulfill()
                            }
                        }
                    }
                }
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testIncorrectLogin() {
        setupTestConfiguration()

        let loginExpectation = expectation(description: "login expectation")
        let tokenExpectation = expectation(description: "token expectation")

        let username = "incorrect.sdk.test.user@commercetools.com"
        let password = "password"
        let authManager = AuthManager.sharedInstance

        var oldToken: String?
        authManager.token { token, error in oldToken = token }

        authManager.loginCustomer(username: username, password: password, completionHandler: { error in
            if let error = error as? CTError, case .accessTokenRetrievalFailed(let reason) = error, reason.message == "invalid_customer_account_credentials" &&
                    reason.details == "Customer account with the given credentials not found." {
                loginExpectation.fulfill()
            }
        })

        authManager.token { token, error in
            if let token = token, let oldToken = oldToken, !token.isEmpty && token != oldToken &&
                    error == nil && authManager.state == .anonymousToken {
                tokenExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAnonymousToken() {
        setupTestConfiguration()

        let tokenExpectation = expectation(description: "token expectation")

        let authManager = AuthManager.sharedInstance
        authManager.obtainAnonymousToken(usingSession: false, completionHandler: { _ in
            authManager.token { token, error in
                if let token = token, !token.isEmpty && error == nil && authManager.state == .plainToken {
                    tokenExpectation.fulfill()
                }
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testRefreshToken() {
        setupTestConfiguration()

        let tokenExpectation = expectation(description: "token expectation")

        let authManager = AuthManager.sharedInstance
        let tokenStore = authManager.tokenStore

        let username = "swift.sdk.test.user@commercetools.com"
        let password = "password"

        authManager.loginCustomer(username: username, password: password, completionHandler: { error in
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
                    if let token = token, let oldToken = oldToken, error == nil && oldToken != token &&
                            authManager.state == .customerToken {
                        tokenExpectation.fulfill()
                    }
                }
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAssigningAnonymousId() {
        setupTestConfiguration()
        let anonymousIdExpectation = expectation(description: "anonymous id expectation")
        let anonymousId = UUID().uuidString
        let authManager = AuthManager.sharedInstance

        authManager.obtainAnonymousToken(usingSession: true, anonymousId: anonymousId, completionHandler: { error in
            if error == nil && authManager.state == .anonymousToken {
                Cart.create(["currency": "EUR"], result: { result in
                    if let response = result.json, let cartAnonymousId = response["anonymousId"] as? String,
                            result.isSuccess && cartAnonymousId == anonymousId {
                        anonymousIdExpectation.fulfill()
                    }
                })
            }

        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAnonymousSessionDuplicateId() {
        setupTestConfiguration()

        let anonymousSessionExpectation = expectation(description: "anonymous session expectation")
        let authManager = AuthManager.sharedInstance

        // Retrieve token with the anonymousId for the first time
        authManager.obtainAnonymousToken(usingSession: true, anonymousId: "test", completionHandler: { error in

            // Try creating anonymous session with the same anonymousId again
            authManager.obtainAnonymousToken(usingSession: true, anonymousId: "test", completionHandler: { error in
                if let error = error as? CTError, case .accessTokenRetrievalFailed(let reason) = error, reason.message == "invalid_request" &&
                        reason.details == "The anonymousId is already in use." {
                    anonymousSessionExpectation.fulfill()
                }
            })
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPlistUsingAnonymousSessionConfig() {
        setupTestConfiguration()

        let anonymousSessionExpectation = expectation(description: "anonymous session expectation")
        let authManager = AuthManager.sharedInstance

        // Configuration in plist has anonymousSession usage set to true, so we should get anonymous session token
        authManager.token { token, error in
            if let _ = token, error == nil && authManager.state == .anonymousToken {
                anonymousSessionExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testOverrideAnonymousSessionConfig() {
        setupTestConfiguration()

        let authManager = AuthManager.sharedInstance
        let anonymousSessionExpectation = expectation(description: "anonymous session expectation")

        authManager.obtainAnonymousToken(usingSession: false, completionHandler: { error in
            if error == nil && authManager.state == .plainToken {
                anonymousSessionExpectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMigrateAnonymousCartOnLogin() {
        setupTestConfiguration()

        let cartMigrationExpectation = expectation(description: "cart migration expectation")

        let authManager = AuthManager.sharedInstance

        let cartDraft = CartDraft(currency: "EUR")

        Cart.create(cartDraft, result: { result in
            if let oldCart = result.model, oldCart.cartState == .active && result.isSuccess {
                let username = "swift.sdk.test.user8@commercetools.com"
                let password = "password"

                Commercetools.loginCustomer(username: username, password: password,
                        activeCartSignInMode: .mergeWithExistingCustomerCart, result: { result in
                    if result.isSuccess {
                        authManager.token { token, error in
                            if authManager.state == .customerToken {
                                Cart.active(result: { result in
                                    if let migratedCart = result.model, migratedCart.id == oldCart.id && result.isSuccess {
                                        Cart.delete(migratedCart.id, version: migratedCart.version, result: { result in
                                            cartMigrationExpectation.fulfill()
                                        })
                                    }
                                })
                            }
                        }
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMigrateAnonymousCartOnSignUp() {
        setupTestConfiguration()

        let username = "new.swift.sdk.test.user@commercetools.com"

        let customerDraft = CustomerDraft(email: username, password: "password")

        let cartMigrationExpectation = expectation(description: "cart migration expectation")

        let authManager = AuthManager.sharedInstance

        let cartDraft = CartDraft(currency: "EUR")

        Cart.create(cartDraft, result: { result in
            if let oldCart = result.model, oldCart.cartState == .active && result.isSuccess {

                Commercetools.signUpCustomer(customerDraft, result: { result in
                    if let customerVersion = result.model?.customer.version, result.isSuccess {
                        if result.isSuccess {
                            authManager.token { token, error in
                                if authManager.state == .customerToken {
                                    Cart.active(result: { result in
                                        if let migratedCart = result.model, migratedCart.id == oldCart.id && result.isSuccess {
                                            Customer.delete(version: customerVersion, result: { result in
                                                if result.isSuccess {
                                                    cartMigrationExpectation.fulfill()
                                                }
                                            })
                                        }
                                    })
                                }
                            }
                        }
                    }
                })
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }
}
