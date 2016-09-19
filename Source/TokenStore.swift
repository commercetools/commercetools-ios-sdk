//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

class TokenStore {

    // MARK: - Properties

    private let SecMatchLimit: String! = kSecMatchLimit as String
    private let SecReturnData: String! = kSecReturnData as String
    private let SecValueData: String! = kSecValueData as String
    private let SecAttrAccessible: String! = kSecAttrAccessible as String
    private let SecClass: String! = kSecClass as String
    private let SecAttrService: String! = kSecAttrService as String
    private let SecAttrGeneric: String! = kSecAttrGeneric as String
    private let SecAttrAccount: String! = kSecAttrAccount as String

    /// The key used for storing access token.
    private var authAccessTokenKey: String {
        // Appending project key from the current configuration if it is set, so we have unique
        // per project token entries.
        return "com.commercetools.authAccessTokenKey" + (Config.currentConfig?.projectKey ?? "")
    }

    /// The key used for storing refresh token.
    private var authRefreshTokenKey: String {
        return "com.commercetools.authRefreshTokenKey" + (Config.currentConfig?.projectKey ?? "")
    }

    /// The key used for storing auth token valid date.
    private var authTokenValidKey: String {
        return "com.commercetools.authTokenValidKey" + (Config.currentConfig?.projectKey ?? "")
    }

    /// The key used for storing auth token state.
    private var authTokenStateKey: String {
        return "com.commercetools.authTokenStateKey" + (Config.currentConfig?.projectKey ?? "")
    }

    /// The value for kSecAttrService property which uniquely identifies keychain accessor.
    private let kKeychainServiceName = "com.commercetools.sdk"

    /// The auth token which should be included in all requests against Commercetools service.
    var accessToken: String? {
        didSet {
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.accessToken as NSCoding?, forKey: self.authAccessTokenKey)
            })
        }
    }

    /// The refresh token used to obtain new auth token for password flow.
    var refreshToken: String? {
        didSet {
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.refreshToken as NSCoding?, forKey: self.authRefreshTokenKey)
            })
        }
    }

    /// The auth token valid before date.
    var tokenValidDate: Date? {
        didSet {
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.tokenValidDate as NSCoding?, forKey: self.authTokenValidKey)
            })
        }
    }

    /// The auth token state.
    var tokenState: AuthManager.TokenState? {
        didSet {
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.tokenState?.rawValue as NSCoding?, forKey: self.authTokenStateKey)
            })
        }
    }

    /// The serial queue used for storing tokens to keychain.
    private let serialQueue = DispatchQueue(label: "com.commercetools.authQueue", attributes: []);

    // MARK: - Lifecycle

    /**
        Initializes the `TokenStore` by loading previously stored tokens and valid period.
    */
    init() {
        reloadTokens()
    }

    /**
        Loads previously stored tokens and valid period for the currently set Commercetools project.
    */
    func reloadTokens() {
        accessToken = objectForKey(authAccessTokenKey) as? String
        refreshToken = objectForKey(authRefreshTokenKey) as? String
        tokenValidDate = objectForKey(authTokenValidKey) as? Date
        if let tokenStateValue = objectForKey(authTokenStateKey) as? Int {
            tokenState = AuthManager.TokenState(rawValue: tokenStateValue)
        }
    }

    // MARK: - Keychain access

    private func objectForKey(_ keyName: String) -> NSCoding? {
        guard let keychainData = dataForKey(keyName) else {
            return nil
        }

        return NSKeyedUnarchiver.unarchiveObject(with: keychainData) as? NSCoding
    }

    private func dataForKey(_ keyName: String) -> Data? {
        var keychainQuery = keychainQueryForKey(keyName)

        // Limit search results to one
        keychainQuery[SecMatchLimit] = kSecMatchLimitOne

        // Specify we want NSData/CFData returned
        keychainQuery[SecReturnData] = kCFBooleanTrue

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(keychainQuery as CFDictionary, UnsafeMutablePointer($0))
        }

        return status == noErr ? result as? Data : nil
    }

    private func setObject(_ value: NSCoding?, forKey keyName: String) {
        if let value = value {
            let data = NSKeyedArchiver.archivedData(withRootObject: value)
            setData(data, forKey: keyName)

        } else if let _ = objectForKey(keyName) {
            removeObjectForKey(keyName)
        }
    }

    private func removeObjectForKey(_ keyName: String) {
        let keychainQuery = keychainQueryForKey(keyName)

        let status: OSStatus =  SecItemDelete(keychainQuery as CFDictionary);
        if status != errSecSuccess {
            Log.error("Error while deleting '\(keyName)' keychain entry.")
        }
    }

    private func setData(_ value: Data, forKey keyName: String) {
        var keychainQuery = keychainQueryForKey(keyName)

        keychainQuery[SecValueData] = value as AnyObject?

        // Protect the keychain entry so it's only available after first device unlocked
        keychainQuery[SecAttrAccessible] = kSecAttrAccessibleAfterFirstUnlock

        let status: OSStatus = SecItemAdd(keychainQuery as CFDictionary, nil)

        if status == errSecDuplicateItem {
            updateData(value, forKey: keyName)
        } else if status != errSecSuccess {
            Log.error("Error while creating '\(keyName)' keychain entry.")
        }
    }

    private func updateData(_ value: Data, forKey keyName: String) {
        let keychainQuery = keychainQueryForKey(keyName)

        let status: OSStatus = SecItemUpdate(keychainQuery as CFDictionary, [SecValueData: value] as CFDictionary)

        if status != errSecSuccess {
            Log.error("Error while updating '\(keyName)' keychain entry.")
        }
    }

    private func keychainQueryForKey(_ key: String) -> [String: AnyObject] {
        // Setup dictionary to access keychain and specify we are using a generic password (rather than a certificate, internet password, etc)
        var keychainQueryDictionary: [String: AnyObject] = [SecClass: kSecClassGenericPassword]

        // Uniquely identify this keychain accessor
        keychainQueryDictionary[SecAttrService] = kKeychainServiceName as AnyObject?

        // Uniquely identify the account who will be accessing the keychain
        let encodedIdentifier: Data? = key.data(using: String.Encoding.utf8)

        keychainQueryDictionary[SecAttrGeneric] = encodedIdentifier as AnyObject?
        keychainQueryDictionary[SecAttrAccount] = encodedIdentifier as AnyObject?

        return keychainQueryDictionary
    }

}
