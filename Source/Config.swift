//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides common Commercetools SDK configuration handling.
    The simplest way to use this class is to add an `CommercetoolsConfig.plist` file in your app's bundle and set
    the desired options. Alternatively, you can use designated initializer with custom `.plist` file path.
*/
public class Config {

    // MARK: - Properties

    /// The current configuration used by Commercetools SDK.
    static var currentConfig: Config? {
        didSet {
            // When the current configuration changes, we want to invoke reload tokens on the token store
            // for the specific project from the newly specified config.
            AuthManager.sharedInstance.updatedConfig()
        }
    }

    /// The log level for the Commercetools library. Debug level is the default.
    public var logLevel = LogLevel.debug

    /// Enables or disables logging. Logging is enabled by default.
    public var loggingEnabled = true

    /// The current app project key.
    public private(set) var projectKey: String?

    /// The current app client ID.
    public private(set) var clientId: String?

    /// The current app client secret.
    public private(set) var clientSecret: String?

    /// The current app client scope.
    public private(set) var scope: String?

    /// Configuration parameter determining whether the SDK should obtain anonymous session token or plain token.
    public private(set) var anonymousSession: Bool

    /// Configuration parameter determining whether the SDK should send the authorization tokens from the iOS keychain
    /// over to the watchOS extension keychain. You have to include the SDK in both targets for this feature to work.
    public private(set) var shareWatchSession: Bool

    /// Keychain access group name the SDK will use for apps and extensions with enabled keychain sharing.
    public private(set) var keychainAccessGroupName: String?

    /// Emergency contact info which is passed to the platform.
    public private(set) var emergencyContactInfo: String?

    /// If set, the `storeKey` is added to all store-specific requests (currently `Customer`, `Cart`, and `Order` endpoints are supported).
    public private(set) var storeKey: String?

    /**
        The current app authorization server URL.
    */
    public private(set) var authUrl: String?

    /**
        The current app API server URL.
    */
    public private(set) var apiUrl: String?

    /**
        The current machine learning API server URL.

        Depending on the region the project is hosted on, `machineLearningApiUrl` can have one of the following values:
        Europe: `https://ml-eu.europe-west1.gcp.commercetools.com/`
        United States: `https://ml-us.europe-west1.gcp.commercetools.com/`
    */
    public private(set) var machineLearningApiUrl: String?

    // MARK: - Lifecycle
#if !os(Linux)
    /**
        Initializes the `Config` by reading configuration from `CommercetoolsConfig.plist` file in your app's bundle.

        - parameter loggingEnabled:           The setting which determines whether SDK will log any
                                              messages. `true` by default.
        - parameter logLevel:                 The SDK log level. `.Debug` by default.

        - returns: The new `Config` instance if all configuration parameters were valid, 'nil' otherwise.
    */
    public convenience init?(loggingEnabled: Bool = true, logLevel: LogLevel = .debug) {
        
        self.init(path: "CommercetoolsConfig.plist", loggingEnabled: loggingEnabled, logLevel: logLevel)
    }

    /**
        Initializes the `Config` by reading configuration from `.plist` file specified in the path.

        - parameter path:                     The path of the specified `.plist` file.
        - parameter loggingEnabled:           The setting which determines whether SDK will log any
                                              messages. `true` by default.
        - parameter logLevel:                 The SDK log level. `.Debug` by default.

        - returns: The new `Config` instance if all configuration parameters were valid, 'nil' otherwise.
    */
    public convenience init?(path: String, loggingEnabled: Bool = true, logLevel: LogLevel = .debug) {
        var plistFileName = path
        if plistFileName.hasSuffix(".plist") {
            plistFileName.removeLast(6)
        }

        guard let path = Bundle.main.path(forResource: plistFileName, ofType: "plist"),
        let config = NSDictionary(contentsOfFile: path) else {
            Log.error("Specified config file at \(plistFileName).plist is missing.")
            return nil
        }

        self.init(config: config, loggingEnabled: loggingEnabled, logLevel: logLevel)
    }
#endif
    /**
        Initializes the `Config` from the configuration dictionary.

        - parameter config:                   The configuration dictionary.
        - parameter loggingEnabled:           The setting which determines whether SDK will log any
                                              messages. `true` by default.
        - parameter logLevel:                 The SDK log level. `.Debug` by default.

        - returns: The new `Config` instance if all configuration parameters were valid, 'nil' otherwise.
    */
    public init?(config: NSDictionary, loggingEnabled: Bool = true, logLevel: LogLevel = .debug) {
        self.loggingEnabled = loggingEnabled
        self.logLevel = logLevel
        projectKey = config["projectKey"] as? String
        clientId = config["clientId"] as? String
        clientSecret = config["clientSecret"] as? String
        scope = config["scope"] as? String
        authUrl = config["authUrl"] as? String
        apiUrl = config["apiUrl"] as? String
        machineLearningApiUrl = config["machineLearningApiUrl"] as? String
        anonymousSession = config["anonymousSession"] as? Bool ?? false
        shareWatchSession = config["shareWatchSession"] as? Bool ?? false
        keychainAccessGroupName = config["keychainAccessGroupName"] as? String
        emergencyContactInfo = config["emergencyContactInfo"] as? String
        storeKey = config["storeKey"] as? String

        if let apiUrl = apiUrl, !apiUrl.hasSuffix("/") {
            self.apiUrl = apiUrl + "/"
        }

        if let authUrl = authUrl, !authUrl.hasSuffix("/") {
            self.authUrl = authUrl + "/"
        }

        if let machineLearningApiUrl = machineLearningApiUrl, !machineLearningApiUrl.hasSuffix("/") {
            self.machineLearningApiUrl = machineLearningApiUrl + "/"
        }

        if !validate() {
            return nil
        }
    }

    // MARK: - Utilities

    /**
        Validates the configuration. In addition to performing validation, this method
        will log debug warnings and common configuration errors.

        - returns: `true` if the current configuration is valid, otherwise `false`.
    */
    public func validate() -> Bool {
        var valid = true

        if (projectKey ?? "").isEmpty {
            Log.error("Specified configuration does not contain projectKey")
            valid = false
        }

        if (clientId ?? "").isEmpty {
            Log.error("Specified configuration does not contain clientId")
            valid = false
        }

        if (clientSecret ?? "").isEmpty {
            Log.error("Specified configuration does not contain clientSecret")
            valid = false
        }

        if (authUrl ?? "").isEmpty {
            Log.error("No authUrl specified")
            valid = false
        }

        if (apiUrl ?? "").isEmpty {
            Log.debug("No apiUrl specified")
            valid = false
        }

        if (machineLearningApiUrl ?? "").isEmpty {
            Log.debug("No machineLearningApiUrl specified")
        }

        if let storeKey = storeKey {
            Log.debug("Store key: \"\(storeKey)\" has been set and will be used globally with all subsequent requests on supported endpoints.")
        }

        if !valid {
            Log.error("Please go to the Merchant Center, 'Settings', 'Developer settings' section, 'API clients' tab.")
        }

        return valid
    }



}
