//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

// MARK: - Configuration

/**
    Provides access to the current `Config` instance.
*/
public var config: Config? {
    get {
        return Config.currentConfig
    }
    set (newConfig) {
        Config.currentConfig = newConfig
        // After setting new configuration, we try to obtain the access token
        AuthManager.sharedInstance.token { token, error in
            if let error = error {
                Log.error("Could not obtain auth token "
                        + (error.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? ""))
            }
        }
    }
}