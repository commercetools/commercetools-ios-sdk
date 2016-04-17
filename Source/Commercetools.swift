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
    set(newConfig) {
        Config.currentConfig = newConfig
    }
}
