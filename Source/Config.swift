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
    static var currentConfig: Config?

    /// The log level for the Commercetools library. Debug level is the default.
    public var logLevel = LogLevel.Debug

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

    /**
        The current app authorization server URL.

        Depending on the region the project is hosted on, `authUrl` can have one of the following values:
        Europe: `https://auth.sphere.io/`
        United States: `https://auth.commercetools.co/`
    */
    public private(set) var authUrl: String?

    /**
        The current app API server URL.

        Depending on the region the project is hosted on, `apiUrl` can have one of the following values:
        Europe: `https://api.sphere.io/`
        United States: `https://api.commercetools.co/`
    */
    public private(set) var apiUrl: String?

    // MARK: - Lifecycle

    /**
        Initializes the `Config` by reading configuration from `CommercetoolsConfig.plist` file in your app's bundle.

        - parameter loggingEnabled:           The setting which determines whether SDK will log any
                                              messages. `true` by default.
        - parameter logLevel:                 The SDK log level. `.Debug` by default.

        - returns: The new `Config` instance if all configuration parameters were valid, 'nil' otherwise.
    */
    public convenience init?(loggingEnabled: Bool = true, logLevel: LogLevel = .Debug) {
        guard let path = NSBundle.mainBundle().pathForResource("CommercetoolsConfig", ofType: "plist") else {
            Log.error("The CommercetoolsConfig.plist file is missing.")
            return nil
        }

        self.init(path: path, loggingEnabled: loggingEnabled, logLevel: logLevel)
    }

    /**
        Initializes the `Config` by reading configuration from `.plist` file specified in the path.

        - parameter path:                     The path of the specified `.plist` file.
        - parameter loggingEnabled:           The setting which determines whether SDK will log any
                                              messages. `true` by default.
        - parameter logLevel:                 The SDK log level. `.Debug` by default.

        - returns: The new `Config` instance if all configuration parameters were valid, 'nil' otherwise.
    */
    public init?(path: String, loggingEnabled: Bool = true, logLevel: LogLevel = .Debug) {
        guard let configDictionary = NSDictionary(contentsOfFile: path) else {
            Log.error("Specified config file at \(path) is missing.")
            return nil
        }

        self.loggingEnabled = loggingEnabled
        self.logLevel = logLevel
        projectKey = configDictionary["projectKey"] as? String
        clientId = configDictionary["clientId"] as? String
        clientSecret = configDictionary["clientSecret"] as? String
        authUrl = configDictionary["authUrl"] as? String
        apiUrl = configDictionary["apiUrl"] as? String
        scope = configDictionary["scope"] as? String

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

        if (scope ?? "").isEmpty {
            Log.error("Specified configuration does not contain client scope")
            valid = false
        }

        if (authUrl ?? "").isEmpty {
            Log.debug("No authUrl specified - using deafult: https://auth.sphere.io/")
            authUrl = "https://auth.sphere.io/"
        }

        if (apiUrl ?? "").isEmpty {
            Log.debug("No apiUrl specified - using deafult: https://api.sphere.io/")
            apiUrl = "https://api.sphere.io/"
        }

        if (!valid) {
            Log.error("Please go to admin.sphere.io, 'Developers' section, 'API clients' tab.")
        }

        return valid
    }



}