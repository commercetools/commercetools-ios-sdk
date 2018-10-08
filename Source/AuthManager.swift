//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Dispatch

/**
    Responsible for obtaining, refreshing and persisting OAuth token, both for client credentials and password flows.
*/
open class AuthManager {

    /**
        Enum used to specify current token state.

        - CustomerToken:    Auth manager is handling tokens for a logged in customer.
        - AnonymousToken:   Auth manager is handling tokens for an anonymous customer.
        - PlainToken:       Auth manager is handling a token without an associated customer.
        - NoToken:          Auth manager does not have a token (i.e. because Commercetools configuration is not valid)
    */
    public enum TokenState: Int {
        case customerToken   = 0
        case anonymousToken  = 1
        case plainToken      = 2
        case noToken         = 3
    }

    // MARK: - Properties

    /// A shared instance of `AuthManager`, which should be used by other SDK objects.
    open static let sharedInstance = AuthManager()

    /// A property used for setting the `anonymous_id` while obtaining anonymous session access and refresh tokens.
    var anonymousId: String?

    /// The current state auth manager is handling.
    open private(set) var state: TokenState {
        get {
            return tokenStore.tokenState ?? .noToken
        }
        set {
            tokenStore.tokenState = newValue
        }
    }

    /// The token store used for loading and storing access and refresh tokens.
    let tokenStore = TokenStore()

    /// The auth token which should be included in all requests against Commercetools service.
    private var accessToken: String? {
        get {
            return tokenStore.accessToken
        }
        set {
            tokenStore.accessToken = newValue
        }
    }

    /// The refresh token used to obtain new auth token for password flow.
    private var refreshToken: String? {
        get {
            return tokenStore.refreshToken
        }
        set {
            tokenStore.refreshToken = newValue
        }
    }

    /// The auth token valid before date.
    private var tokenValidDate: Date? {
        get {
            return tokenStore.tokenValidDate
        }
        set {
            tokenStore.tokenValidDate = newValue
        }
    }

    /// The URL used for requesting token for client credentials and refresh token flow.
    private var clientCredentialsUrl: String? {
        if let config = Config.currentConfig, let baseAuthUrl = config.authUrl, config.validate() {
            return baseAuthUrl + "oauth/token"
        }
        return nil
    }

    /// The URL used for requesting an access and refresh token for an anonymous session
    private var anonymousSessionTokenUrl: String? {
        if let config = Config.currentConfig, let baseAuthUrl = config.authUrl, let projectKey = config.projectKey, config.validate() {
            return "\(baseAuthUrl)oauth/\(projectKey)/anonymous/token"
        }
        return nil
    }

    /// The URL used for requesting token for password flow.
    private var loginUrl: String? {
        if let config = Config.currentConfig, let baseAuthUrl = config.authUrl, let projectKey = config.projectKey, config.validate() {
            return "\(baseAuthUrl)oauth/\(projectKey)/customers/token"
        }
        return nil
    }

    /// Bool property indicating whether the manager should obtain anonymous session token or plain token.
    private var usingAnonymousSession = false

    /// The HTTP headers containing basic HTTP auth needed to obtain the tokens.
    private var authHeaders: [String: String]? {
        if let config = Config.currentConfig, let clientId = config.clientId, let clientSecret = config.clientSecret,
        let authData = "\(clientId):\(clientSecret)".data(using: String.Encoding.utf8), config.validate() {

            var headers = defaultHeaders
            headers["Authorization"] = "Basic \(authData.base64EncodedString())"
            return headers
        }
        return nil
    }

    /// The serial queue used for processing token requests.
    private let serialQueue = DispatchQueue(label: "com.commercetools.authQueue")

    // MARK: - Lifecycle

    /**
        Private initializer prevents `AuthManager` usage without using `sharedInstance`.
    */
    private init() {}

    // MARK: - Accessing token

    /**
        This method should be used for user login. After successful login the new auth token is used for all
        further requests with Commercetools services.
        In case this method is called before previously logging user out, it will automatically logout (i.e remove
        previously stored tokens).

        - parameter username:           The user's username.
        - parameter password:           The user's password.
        - parameter completionHandler:  The code to be executed once the token fetching completes.
    */
    func loginCustomer(username: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        // Process all token requests using private serial queue to avoid issues with race conditions
        // when multiple credentials / login requests can lead auth manager in an unpredictable state
        serialQueue.async(execute: {
            let semaphore = DispatchSemaphore(value: 0)
            if self.state != .plainToken {
                self.logoutCustomer()
            }
            self.processLogin(username: username, password: password, completionHandler: { token, error in
                completionHandler(error)
                semaphore.signal()
            })
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        })
    }

    /**
        This method will clear all tokens both from memory and persistent storage.
        Most common use case for this method is user logout.
    */
    func logoutCustomer() {
        clearAllTokens()

        Log.debug("Getting new anonymous access token after user logout")
        token { _, error in
            if let error = error as? CTError {
                Log.error("Could not obtain auth token "
                        + (error.errorDescription ?? ""))
            }
        }
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
    open func obtainAnonymousToken(usingSession: Bool, anonymousId: String? = nil, completionHandler: @escaping (Error?) -> Void) {
        // Process session changes using private serial queue to avoid issues with race conditions
        // when switching between anonymous and plain modes.
        serialQueue.async(execute: {
            self.anonymousId = anonymousId
            self.usingAnonymousSession = usingSession
            self.clearAllTokens()
            self.token { _, error in
                completionHandler(error)
            }
        })
    }

    /**
        This method provides auth token to be used in all requests to Commercetools services.
        In case the token has already been obtained, and it's still valid, completion handler
        gets called without network request.
        If the token has expired, the new one will be obtained and passed via completion handler.

        - parameter completionHandler:  The code to be executed once the token fetching completes.
    */
    func token(_ completionHandler: @escaping (String?, Error?) -> Void) {
        // Process all token requests using private serial queue to avoid issues with race conditions
        // when multiple credentials / login requests can lead auth manager in an unpredictable state
        serialQueue.async(execute: {
            let semaphore = DispatchSemaphore(value: 0)
            self.processTokenRequest { token, error in
                completionHandler(token, error)
                semaphore.signal()
            }
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        })
    }

    /**
        When the current configuration changes, we want to invoke reload tokens on the token store
        for the specific project from the newly specified config. Also, in case the new configuration contains
        different anonymous token preferences, they will be applied after this method call.
    */
    func updatedConfig() {
        #if !os(Linux)
        tokenStore.reloadTokens()
        #endif

        if let config = Config.currentConfig, config.validate() {
            usingAnonymousSession = config.anonymousSession
        }

        if (state == .anonymousToken && !usingAnonymousSession) ||
                (state == .plainToken && usingAnonymousSession) {
            logoutCustomer()
        }
    }

    /**
        Tries to recover from `invalidToken` error by removing existing `accessToken` from `TokenStore`.

        - parameter completionHandler:  The code to be executed once the token fetching completes.
    */
    func recoverFromInvalidTokenError(_ completionHandler: @escaping (String?, Error?) -> Void) {
        serialQueue.async(execute: {
            guard self.accessToken != nil else {
                self.clearAllTokens()
                return
            }

            self.accessToken = nil
            self.tokenValidDate = nil
            self.state = .noToken
            Log.debug("Removing access token, trying to recover from .invalidToken error")
            self.token(completionHandler)
        })
    }

    // MARK: - Retrieving tokens from the auth API

    private func processTokenRequest(_ completionHandler: @escaping (String?, Error?) -> Void) {
        if let config = Config.currentConfig, config.validate() {
            if let accessToken = accessToken, let tokenValidDate = tokenValidDate, tokenValidDate.compare(Date()) == .orderedDescending {
                if refreshToken == nil {
                    self.state = .plainToken
                }
                completionHandler(accessToken, nil)

            } else {
                accessToken = nil
                tokenValidDate = nil

                if refreshToken != nil {
                    refreshToken(completionHandler)
                } else {
                    obtainAnonymousToken(completionHandler)
                }
            }
        } else {
            Log.error("Cannot obtain access token without valid configuration present.")
            completionHandler(nil, CTError.configurationValidationFailed)
        }
    }

    private func processLogin(username: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        if let loginUrl = loginUrl, let authHeaders = authHeaders {
            var parameters = ["grant_type": "password", "username": username, "password": password]
            if let scope = Config.currentConfig?.scope {
                parameters["scope"] = scope
            }

            let request = Customer.request(url: loginUrl, method: .post, formParameters: parameters, headers: authHeaders)
            urlSession.dataTask(with: request, completionHandler: { data, response, error in
                self.state = .customerToken
                self.handleAuthResponse(data: data, response: response, error: error, completionHandler: completionHandler)
            }).resume()
        }
    }

    private func obtainAnonymousToken(_ completionHandler: @escaping (String?, Error?) -> Void) {
        usingAnonymousSession ? obtainAnonymousSessionToken(completionHandler) : obtainPlainAnonymousToken(completionHandler)
    }

    private func obtainAnonymousSessionToken(_ completionHandler: @escaping (String?, Error?) -> Void) {
        if let authUrl = anonymousSessionTokenUrl, let authHeaders = authHeaders {
            var parameters = ["grant_type": "client_credentials"]
            if let scope = Config.currentConfig?.scope {
                parameters["scope"] = scope
            }
            if let anonymousId = anonymousId {
                parameters["anonymous_id"] = anonymousId
            }
            let request = Customer.request(url: authUrl, method: .post, formParameters: parameters, headers: authHeaders)
            urlSession.dataTask(with: request, completionHandler: { data, response, error in
                self.state = .anonymousToken
                self.handleAuthResponse(data: data, response: response, error: error, completionHandler: completionHandler)
            }).resume()
        }
    }

    private func obtainPlainAnonymousToken(_ completionHandler: @escaping (String?, Error?) -> Void) {
        if let authUrl = clientCredentialsUrl, let authHeaders = authHeaders {
            var parameters = ["grant_type": "client_credentials"]
            if let scope = Config.currentConfig?.scope {
                parameters["scope"] = scope
            }
            let request = Customer.request(url: authUrl, method: .post, formParameters: parameters, headers: authHeaders)
            urlSession.dataTask(with: request, completionHandler: { data, response, error in
                self.state = .plainToken
                self.handleAuthResponse(data: data, response: response, error: error, completionHandler: completionHandler)
            }).resume()
        }
    }

    private func refreshToken(_ completionHandler: @escaping (String?, Error?) -> Void) {
        if let authUrl = clientCredentialsUrl, let authHeaders = authHeaders, let refreshToken = refreshToken {
            let request = Customer.request(url: authUrl, method: .post, formParameters: ["grant_type": "refresh_token", "refresh_token": refreshToken], headers: authHeaders)
            urlSession.dataTask(with: request, completionHandler: { data, response, error in
                self.handleAuthResponse(data: data, response: response, error: error, completionHandler: completionHandler)
            }).resume()
        }
    }

    private func clearAllTokens() {
        accessToken = nil
        refreshToken = nil
        tokenValidDate = nil
        state = .noToken
    }

    private func handleAuthResponse(data: Data?, response: URLResponse?, error: Error?, completionHandler: (String?, Error?) -> Void) {
        if let data = data, let responseJson = try? JSONSerialization.jsonObject(with: data, options: []),
           let responseDict = responseJson as? [String: Any], let accessToken = responseDict["access_token"] as? String,
           let expiresIn = responseDict["expires_in"] as? Int {

            self.anonymousId = nil
            self.accessToken = accessToken
            // Subtracting 10 minutes from the valid period to compensate for the latency
            self.tokenValidDate = Date().addingTimeInterval(Double(expiresIn - 600))
            self.refreshToken = responseDict["refresh_token"] as? String ?? self.refreshToken
            completionHandler(accessToken, nil)

        } else if let data = data, let responseJson = try? JSONSerialization.jsonObject(with: data, options: []),
                  let responseDict = responseJson as? [String: Any], let failureReason = responseDict["error"] as? String,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 299 {
            // In case we got an error while using refresh token, we want to clear token storage - there's no way
            // to recover from this
            clearAllTokens()
            completionHandler(nil, CTError.accessTokenRetrievalFailed(reason: CTError.FailureReason(message: failureReason, details: responseDict["error_description"] as? String)))

        } else {
            // Any other error from NSURLErrorDomain (e.g internet offline) - we won't clear token storage
            state = .noToken
            completionHandler(nil, error)
        }
    }
}
