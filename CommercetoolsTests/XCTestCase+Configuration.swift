//
//  Copyright © 2016 Commercetools. All rights reserved.
//

import XCTest
@testable import Commercetools

extension XCTestCase {
    
    func setupTestConfiguration() {
        let testBundle = NSBundle(forClass: AuthManagerTests.self)
        if let path = testBundle.pathForResource("CommercetoolsTestConfig", ofType: "plist"),
            config = NSDictionary(contentsOfFile: path) {
            Commercetools.config = Config(config: config)
        }
    }

    func setupProjectManagementConfiguration() {
        let envVars = NSProcessInfo.processInfo().environment
        // For creating password reset and account activation tokens, we need a configuration which
        // contains manage_customers scope.
        if let projectKey = envVars["PROJECT_KEY"], scope = envVars["SCOPE"], clientId = envVars["CLIENT_ID"],
        clientSecret = envVars["CLIENT_SECRET"] {

            let config = ["projectKey": projectKey, "scope": scope, "clientId": clientId, "clientSecret": clientSecret]
            Commercetools.config = Config(config: config)
        }
    }
    
    func cleanPersistedTokens() {
        let tokenStore = AuthManager.sharedInstance.tokenStore
        tokenStore.accessToken = nil
        tokenStore.refreshToken = nil
        tokenStore.tokenValidDate = nil
    }

}