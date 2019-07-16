//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
#if os(iOS) || os(watchOS)
import UIKit
import WatchConnectivity
#endif

class TokenStore: NSObject {

    // MARK: - Properties

    #if !os(Linux)
    private let secMatchLimit: String! = kSecMatchLimit as String
    private let secReturnData: String! = kSecReturnData as String
    private let secValueData: String! = kSecValueData as String
    private let secAttrAccessible: String! = kSecAttrAccessible as String
    private let secClass: String! = kSecClass as String
    private let secAttrService: String! = kSecAttrService as String
    private let secAttrGeneric: String! = kSecAttrGeneric as String
    private let secAttrAccount: String! = kSecAttrAccount as String
    private let secAttrAccessGroup: String! = kSecAttrAccessGroup as String
    #endif

    /// The key used for storing access token.
    fileprivate var authAccessTokenKey: String {
        // Appending project key from the current configuration if it is set, so we have unique
        // per project token entries.
        return "com.commercetools.authAccessTokenKey" + (Config.currentConfig?.projectKey ?? "") + (Config.currentConfig?.clientId ?? "")
    }

    /// The key used for storing refresh token.
    fileprivate var authRefreshTokenKey: String {
        return "com.commercetools.authRefreshTokenKey" + (Config.currentConfig?.projectKey ?? "") + (Config.currentConfig?.clientId ?? "")
    }

    /// The key used for storing external token.
    fileprivate var authExternalTokenKey: String {
        return "com.commercetools.authExternalTokenKey" + (Config.currentConfig?.projectKey ?? "") + (Config.currentConfig?.clientId ?? "")
    }

    /// The key used for storing auth token valid date.
    fileprivate var authTokenValidKey: String {
        return "com.commercetools.authTokenValidKey" + (Config.currentConfig?.projectKey ?? "") + (Config.currentConfig?.clientId ?? "")
    }

    /// The key used for storing auth token state.
    fileprivate var authTokenStateKey: String {
        return "com.commercetools.authTokenStateKey" + (Config.currentConfig?.projectKey ?? "") + (Config.currentConfig?.clientId ?? "")
    }

    /// The key used for storing external token.
    fileprivate var externalUserIdKey: String {
        return "com.commercetools.externalUserIdKey" + (Config.currentConfig?.projectKey ?? "") + (Config.currentConfig?.clientId ?? "")
    }

    /// The value for kSecAttrService property which uniquely identifies keychain accessor.
    private let kKeychainServiceName = "com.commercetools.sdk"

    /// The auth token which should be included in all requests against Commercetools service.
    var accessToken: String? {
        didSet {
            #if !os(Linux)
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.accessToken as NSCoding?, forKey: self.authAccessTokenKey)
                #if os(iOS)
                self.transferTokens()
                #endif
            })
            #endif
        }
    }

    /// The refresh token used to obtain new auth token for password flow.
    var refreshToken: String? {
        didSet {
            #if !os(Linux)
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.refreshToken as NSCoding?, forKey: self.authRefreshTokenKey)
                #if os(iOS)
                self.transferTokens()
                #endif
            })
            #endif
        }
    }

    /// The refresh token used to obtain new auth token for password flow.
    var externalToken: String? {
        didSet {
            #if !os(Linux)
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.externalToken as NSCoding?, forKey: self.authExternalTokenKey)
                #if os(iOS)
                self.transferTokens()
                #endif
            })
            #endif
        }
    }

    /// The auth token valid before date.
    var tokenValidDate: Date? {
        didSet {
            #if !os(Linux)
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.tokenValidDate as NSCoding?, forKey: self.authTokenValidKey)
                #if os(iOS)
                self.transferTokens()
                #endif
            })
            #endif
        }
    }

    /// The auth token state.
    var tokenState: AuthManager.TokenState? {
        didSet {
            #if !os(Linux)
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.tokenState?.rawValue as NSCoding?, forKey: self.authTokenStateKey)
                #if os(iOS)
                self.transferTokens()
                #endif
            })
            #endif
        }
    }

    /// The external user ID, passed using X-External-User-ID header.
    var externalUserId: String? {
        didSet {
            #if !os(Linux)
            // Keychain write operation can be expensive, and we can do it asynchronously.
            serialQueue.async(execute: {
                self.setObject(self.externalUserId as NSCoding?, forKey: self.externalUserIdKey)
                #if os(iOS)
                self.transferTokens()
                #endif
            })
            #endif
        }
    }

    #if !os(Linux)
    /// The serial queue used for storing tokens to keychain.
    private let serialQueue = DispatchQueue(label: "com.commercetools.authQueue", attributes: [])

    #if os(iOS) || os(watchOS)
    /// The watch connectivity session used to share authorization tokens from the iOS SDK instance to the watchOS instance.
    fileprivate var wcSession: WCSession?
    fileprivate let kRequestWatchSession = "RequestWatchSession"
    #endif

    // MARK: - Lifecycle

    /**
        Initializes the `TokenStore` by loading previously stored tokens and valid period.
    */
    override init() {
        super.init()
        reloadTokens()
        #if os(iOS)
            NotificationCenter.default.addObserver(self, selector: #selector(transferTokens), name: UIApplication.didBecomeActiveNotification, object: nil)
        #endif
    }

    /**
        Loads previously stored tokens and valid period for the currently set Commercetools project.
    */
    func reloadTokens() {
        #if os(iOS) || os(watchOS)
            initAndConfigureWCSession()
        #endif

        accessToken = objectForKey(authAccessTokenKey) as? String
        refreshToken = objectForKey(authRefreshTokenKey) as? String
        externalToken = objectForKey(authExternalTokenKey) as? String
        tokenValidDate = objectForKey(authTokenValidKey) as? Date
        if let tokenStateValue = objectForKey(authTokenStateKey) as? Int {
            tokenState = AuthManager.TokenState(rawValue: tokenStateValue)
        }
        externalUserId = objectForKey(externalUserIdKey) as? String
    }

    #if os(iOS) || os(watchOS)
    fileprivate func initAndConfigureWCSession() {
        if let shareWatchSession = Config.currentConfig?.shareWatchSession, WCSession.isSupported() && shareWatchSession {
            wcSession = WCSession.default
            wcSession?.delegate = self
            wcSession?.activate()
        } else {
            wcSession?.delegate = nil
            wcSession = nil
        }
    }
    #endif

    #if os(iOS)

    // MARK: - iOS - watchOS tokens transfer

    @objc fileprivate func transferTokens() {
        if wcSession == nil {
            initAndConfigureWCSession()
        }
        guard let tokenState = tokenState else { return }
        if let session = wcSession, session.isPaired && session.isWatchAppInstalled && session.activationState == .activated {
            var tokenInfo: [String: Any] = [authTokenStateKey: tokenState.rawValue]
            if let accessToken = accessToken {
                tokenInfo[authAccessTokenKey] = accessToken
            }
            if let refreshToken = refreshToken {
                tokenInfo[authRefreshTokenKey] = refreshToken
            }
            if let externalToken = externalToken {
                tokenInfo[authExternalTokenKey] = externalToken
            }
            if let tokenValidDate = tokenValidDate {
                tokenInfo[authTokenValidKey] = tokenValidDate
            }
            if let externalUserId = externalUserId {
                tokenInfo[externalUserIdKey] = externalUserId
            }
            Log.debug("Transferring token dictionary to the watch with contents: \(tokenInfo)")
            do {
                try session.updateApplicationContext(tokenInfo)
            }
            catch let error {
                Log.error("Error while trying to send tokes to the watch: \(error)")
            }
        }
    }

    #endif

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
        keychainQuery[secMatchLimit] = kSecMatchLimitOne

        // Specify we want NSData/CFData returned
        keychainQuery[secReturnData] = kCFBooleanTrue

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

        keychainQuery[secValueData] = value as AnyObject?

        // Protect the keychain entry so it's only available after first device unlocked
        keychainQuery[secAttrAccessible] = kSecAttrAccessibleAfterFirstUnlock

        let status: OSStatus = SecItemAdd(keychainQuery as CFDictionary, nil)

        if status == errSecDuplicateItem {
            updateData(value, forKey: keyName)
        } else if status != errSecSuccess {
            Log.error("Error while creating '\(keyName)' keychain entry.")
        }
    }

    private func updateData(_ value: Data, forKey keyName: String) {
        let keychainQuery = keychainQueryForKey(keyName)

        let status: OSStatus = SecItemUpdate(keychainQuery as CFDictionary, [secValueData: value] as CFDictionary)

        if status != errSecSuccess {
            Log.error("Error while updating '\(keyName)' keychain entry.")
        }
    }

    private func keychainQueryForKey(_ key: String) -> [String: Any] {
        // Setup dictionary to access keychain and specify we are using a generic password (rather than a certificate, internet password, etc)
        var keychainQueryDictionary: [String: Any] = [secClass: kSecClassGenericPassword]

        // Uniquely identify this keychain accessor
        keychainQueryDictionary[secAttrService] = kKeychainServiceName

        // Uniquely identify the account who will be accessing the keychain
        let encodedIdentifier: Data? = key.data(using: String.Encoding.utf8)

        keychainQueryDictionary[secAttrGeneric] = encodedIdentifier
        keychainQueryDictionary[secAttrAccount] = encodedIdentifier

        // For apps and extensions using keychain sharing, set the access group name defined in the config plist.
        // The only exception is watchOS, where keychain sharing with the iOS app cannot be used.
        #if !os(watchOS)
        if let accessGroupName = Config.currentConfig?.keychainAccessGroupName {
            keychainQueryDictionary[secAttrAccessGroup] = accessGroupName
        }
        #endif

        return keychainQueryDictionary
    }
#endif
}

#if os(iOS) || os(watchOS)
extension TokenStore: WCSessionDelegate {
    #if os(watchOS)
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Log.debug("Receiving token dictionary from the phone with contents: \(applicationContext)")
        guard let tokenStateValue = applicationContext[authTokenStateKey] as? Int else { return }
        accessToken = applicationContext[authAccessTokenKey] as? String
        refreshToken = applicationContext[authRefreshTokenKey] as? String
        externalToken = applicationContext[authExternalTokenKey] as? String
        tokenValidDate = applicationContext[authTokenValidKey] as? Date
        tokenState = AuthManager.TokenState(rawValue: tokenStateValue)
        externalUserId = applicationContext[externalUserIdKey] as? String
        NotificationCenter.default.post(name: Notification.Name.WatchSynchronization.DidReceiveTokens, object: nil, userInfo: nil)
    }
    #endif

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            Log.error("Error while activating WCSession: \(error)")
        }
        #if os(iOS)
            transferTokens()
        #endif

        #if os(watchOS)
            if activationState == .activated && Config.currentConfig?.validate() != true {
                session.sendMessage([kRequestWatchSession: kRequestWatchSession], replyHandler: nil)
            }
        #endif
    }

    #if os(iOS)
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let requestWatchSession = message[kRequestWatchSession] as? String, requestWatchSession == kRequestWatchSession {
            transferTokens()
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        wcSession = nil
    }

    func sessionDidDeactivate(_ session: WCSession) {
        wcSession = nil
    }
    #endif
}
#endif
