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
    
    func cleanPersistedTokens() {
        let tokenStore = AuthManager.sharedInstance.tokenStore
        tokenStore.accessToken = nil
        tokenStore.refreshToken = nil
        tokenStore.tokenValidDate = nil
    }
    
}