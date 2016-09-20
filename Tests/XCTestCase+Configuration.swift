//
//  Copyright © 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

extension XCTestCase {
    
    func setupTestConfiguration() {
        let testBundle = Bundle(for: AuthManagerTests.self)
        if let path = testBundle.path(forResource: "CommercetoolsTestConfig", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path) {
            Commercetools.config = Config(config: config)
            cleanPersistedTokens()
        }
    }

    func setupProjectManagementConfiguration() {
        let envVars = ProcessInfo.processInfo.environment
        // For creating password reset and account activation tokens, we need a configuration which
        // contains manage_customers scope.
        if let projectKey = envVars["PROJECT_KEY"], let scope = envVars["SCOPE"], let clientId = envVars["CLIENT_ID"],
        let clientSecret = envVars["CLIENT_SECRET"] {

            let config = ["projectKey": projectKey, "scope": scope, "clientId": clientId, "clientSecret": clientSecret] as NSDictionary
            Commercetools.config = Config(config: config)
        } else {
            Log.error("No configuration with extended scope found in environment variables. This configuration is" +
                      " needed to run the test successfully.")
        }
    }
    
    func cleanPersistedTokens() {
        let authManager = AuthManager.sharedInstance
        authManager.anonymousId = nil

        let tokenStore = authManager.tokenStore
        tokenStore.accessToken = nil
        tokenStore.refreshToken = nil
        tokenStore.tokenValidDate = nil
        tokenStore.tokenState = nil
    }

}