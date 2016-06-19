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

    /// The value for kSecAttrService property which uniquely identifies keychain accessor.
    private let kKeychainServiceName = "com.commercetools.sdk"

    /// The auth token which should be included in all requests against Commercetools service.
    var accessToken: String? {
        didSet {
            // Keychain write operation can be expensive, and we can do it asynchronously.
            dispatch_async(serialQueue, {
                self.setObject(self.accessToken, forKey: self.authAccessTokenKey)
            })
        }
    }

    /// The refresh token used to obtain new auth token for password flow.
    var refreshToken: String? {
        didSet {
            // Keychain write operation can be expensive, and we can do it asynchronously.
            dispatch_async(serialQueue, {
                self.setObject(self.refreshToken, forKey: self.authRefreshTokenKey)
            })
        }
    }

    /// The auth token valid before date.
    var tokenValidDate: NSDate? {
        didSet {
            // Keychain write operation can be expensive, and we can do it asynchronously.
            dispatch_async(serialQueue, {
                self.setObject(self.tokenValidDate, forKey: self.authTokenValidKey)
            })
        }
    }

    /// The serial queue used for storing tokens to keychain.
    private let serialQueue = dispatch_queue_create("com.commercetools.authQueue", DISPATCH_QUEUE_SERIAL);

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
        tokenValidDate = objectForKey(authTokenValidKey) as? NSDate
    }

    // MARK: - Keychain access

    private func objectForKey(keyName: String) -> NSCoding? {
        guard let keychainData = dataForKey(keyName) else {
            return nil
        }

        return NSKeyedUnarchiver.unarchiveObjectWithData(keychainData) as? NSCoding
    }

    private func dataForKey(keyName: String) -> NSData? {
        var keychainQuery = keychainQueryForKey(keyName)

        // Limit search results to one
        keychainQuery[SecMatchLimit] = kSecMatchLimitOne

        // Specify we want NSData/CFData returned
        keychainQuery[SecReturnData] = kCFBooleanTrue

        var result: AnyObject?
        let status = withUnsafeMutablePointer(&result) {
            SecItemCopyMatching(keychainQuery, UnsafeMutablePointer($0))
        }

        return status == noErr ? result as? NSData : nil
    }

    private func setObject(value: NSCoding?, forKey keyName: String) {
        if let value = value {
            let data = NSKeyedArchiver.archivedDataWithRootObject(value)
            setData(data, forKey: keyName)

        } else if let _ = objectForKey(keyName) {
            removeObjectForKey(keyName)
        }
    }

    private func removeObjectForKey(keyName: String) {
        let keychainQuery = keychainQueryForKey(keyName)

        let status: OSStatus =  SecItemDelete(keychainQuery);
        if status != errSecSuccess {
            Log.error("Error while deleting '\(keyName)' keychain entry.")
        }
    }

    private func setData(value: NSData, forKey keyName: String) {
        var keychainQuery = keychainQueryForKey(keyName)

        keychainQuery[SecValueData] = value

        // Protect the keychain entry so it's only available after first device unlocked
        keychainQuery[SecAttrAccessible] = kSecAttrAccessibleAfterFirstUnlock

        let status: OSStatus = SecItemAdd(keychainQuery, nil)

        if status == errSecDuplicateItem {
            updateData(value, forKey: keyName)
        } else if status != errSecSuccess {
            Log.error("Error while creating '\(keyName)' keychain entry.")
        }
    }

    private func updateData(value: NSData, forKey keyName: String) {
        let keychainQuery = keychainQueryForKey(keyName)

        let status: OSStatus = SecItemUpdate(keychainQuery, [SecValueData: value])

        if status != errSecSuccess {
            Log.error("Error while updating '\(keyName)' keychain entry.")
        }
    }

    private func keychainQueryForKey(key: String) -> [String: AnyObject] {
        // Setup dictionary to access keychain and specify we are using a generic password (rather than a certificate, internet password, etc)
        var keychainQueryDictionary: [String: AnyObject] = [SecClass: kSecClassGenericPassword]

        // Uniquely identify this keychain accessor
        keychainQueryDictionary[SecAttrService] = kKeychainServiceName

        // Uniquely identify the account who will be accessing the keychain
        let encodedIdentifier: NSData? = key.dataUsingEncoding(NSUTF8StringEncoding)

        keychainQueryDictionary[SecAttrGeneric] = encodedIdentifier
        keychainQueryDictionary[SecAttrAccount] = encodedIdentifier

        return keychainQueryDictionary
    }

}