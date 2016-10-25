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
            if let error = error as? CTError {
                Log.error("Could not obtain auth token "
                        + (error.errorDescription ?? ""))
            }
        }
    }
}

// MARK: - Authorization management

/// The current state handled by authentication manager.
public var authState: AuthManager.TokenState {
    return AuthManager.sharedInstance.state
}

/**
    This method should be used for user login. After successful login the new auth token is used for all
    further requests with Commercetools services.
    In case this method is called before previously logging user out, it will automatically logout (i.e remove
    previously stored tokens).

    - parameter username:           The user's username.
    - parameter password:           The user's password.
    - parameter completionHandler:  The code to be executed once the token fetching completes.
*/
public func login(username: String, password: String, completionHandler: @escaping (Error?) -> Void) {
    AuthManager.sharedInstance.login(username: username, password: password, completionHandler: completionHandler)
}

/**
    This method will clear all tokens both from memory and persistent storage.
    Most common use case for this method is user logout.
*/
public func logoutUser() {
    AuthManager.sharedInstance.logoutUser()
}

/**
    This method should be used to override `anonymousSession` Bool parameter from the configuration and get new tokens.
    Once this method is invoked, any previously logged in user will be logged out. In case there was an anonymous
    session active, the refresh token will be removed, and the session will not be recoverable any more.
    Most common use case for this method is user logout.

    - parameter usingSession:       Bool parameter indicating whether anonymous session should be used.
    - parameter anonymousId:        Optional argument to assign custom value for `anonymous_id`.
    - parameter completionHandler:  The code to be executed once the token fetching completes.
*/
public func obtainAnonymousToken(usingSession: Bool, anonymousId: String? = nil, completionHandler: @escaping (Error?) -> Void) {
    AuthManager.sharedInstance.obtainAnonymousToken(usingSession: usingSession, anonymousId: anonymousId, completionHandler: completionHandler)
}
