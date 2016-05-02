# Commercetools iOS SDK

![SPHERE.IO icon](https://admin.sphere.io/assets/images/sphere_logo_rgb_long.png)

[![][travis img]][travis]
[![][cocoapods img]][cocoapods]
[![][license img]][license]

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build CommercetoolsSDK.

To integrate CommercetoolsSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'Commercetools', '~> 0.0'
```

Then, run the following command:

```bash
$ pod install
```

## Getting Started

The Commercetools SDK uses a `.plist` configuration file named `CommercetoolsConfig.plist` to gather all information needed to communicate with the commercetools platform.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>projectKey</key>
	<string>Your Project Key</string>
	<key>clientId</key>
	<string>Your Client ID</string>
	<key>clientSecret</key>
	<string>Your Client Secret</string>
	<key>scope</key>
	<string>Your Client Scope</string>
	<key>authUrl</key>
	<string>https://auth.sphere.io/</string>
	<key>apiUrl</key>
	<string>https://api.sphere.io</string>
</dict>
</plist> 
```

Alternatively, you can specify a path to different `.plist` file containing these properties.

Before using any methods from the Commercetools SDK, please make sure you have previously set the desired configuration.
```swift
import Commercetools

// Default configuration initializer reads from CommercetoolsConfig.plist file from your app bundle
if let configuration = Config() {
    
    // You can also specify custom logging level
    // configuration.logLevel = .Error
    
    // Or completely disable all log messages from Commercetools SDK
    // configuration.loggingEnabled = false
    
    // Finally, you need set your configuration before using the SDK
    Commercetools.config = configuration
    
} else {
    // There are some errors in your .plist file, check log messages for more information
}
```

## Authenticated and Anonymous Usage

Endpoints from the Commercetools services can be consumed by both anonymous and authenticated users. After you specify the configuration, all further interactions with the Commercetools platform will be performed with anonymous user token.

If at some point you wish to login the user, that can be achieved using `AuthManager` `loginUser` method:

```swift
let authManager = AuthManager.sharedInstance

let username = "swift.sdk.test.user@commercetools.com"
let password = "password"

authManager.loginUser(username, password: password, completionHandler: { error in
    if let error = error {
        // Handle error, and possibly get some more information from error.userInfo[NSLocalizedFailureReasonErrorKey]
    }
})
```

Similarly, after logging out, all further interactions continue to use new anonymous user token.

```swift
AuthManager.sharedInstance.logoutUser()
```

Access and refresh tokens are being preserved across app launches by the `AuthManager`. In order to inspect whether it's currently handling authenticated or anonymous user, `state` property should be used:

```swift
if authManager.state == .PlainToken {
    // Present login form or other logic
}
```

## Consuming Commercetools Endpoints

Consuming and managing resources provided through available endpoints is very easy for any of the available endpoint classes.

Depending on the capabilities of the resource, you can retrieve by specific UUID, use more detailed query options, and also perform create or update operations.

All of these functionalities are provided by static methods for any specific supported endpoint. For an example, you can creating shopping cart using provided `Cart` class:
```swift
let createDraft = ["currency": "EUR"]

Cart.create(createDraft, result: { result in
	if let response = result.response where result.isSuccess {
		// Do any work with response dictionary containing created `Cart` resource, i.e:
		if let cartState = response["cartState"] as? String where cartState == "Active" {
			// Our cart is active!
		}
	}
})
```

In case you need resources from an endpoint which hasn't been implemented in our SDK yet, you can easily create class representing that endpoint, and conform to appropriate protocols which take care of abstract endpoint implementations for many common use cases.

The following list represents currently supported abstract endpoints. For each protocol, there is a default extension provided, which will almost always cover your needs:

* Create endpoint - `create(object: [String: AnyObject], expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)`
* Update endpoint - `update(id: String, version: UInt, actions: [[String: AnyObject]], expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)`
* Update by key endpoint - `updateByKey(key: String, version: UInt, actions: [[String: AnyObject]], expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)`
* Query endpoint - `query(predicates predicates: [String]?, sort: [String]?, expansion: [String]?, limit: UInt?, offset: UInt?, result: (Result<[String: AnyObject], NSError>) -> Void)`
* Retrieve resource by ID endpoint - `byId(id: String, expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)`
* Retrieve resource by key endpoint - `byKey(key: String, expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)`
* Delete endpoint - `delete(id: String, version: UInt, expansion: [String]?, result: (Result<[String: AnyObject], NSError>) -> Void)`

## Handling Results

In order to check whether any action with Commercetools services was successfully executed, you should use `isSuccess` or `isFailure` property of the result in question. For all successful operations, `response` property contains values returned from the server.

For all failed operations, `errors` property should be used from the result in question to present or handle specific issues. `NSError` instances with domain equal to `com.commercetools.error` usually contain descriptive information about the error, returned by the API. Those can be found by `NSLocalizedFailureReasonErrorKey` for general issue cause, and by `NSLocalizedDescriptionKey` for more detailed description, where applicable.

[](definitions for the top badges)

[travis]:https://travis-ci.org/sphereio/commercetools-ios-sdk
[travis img]:https://travis-ci.org/sphereio/commercetools-ios-sdk.svg?branch=master

[cocoapods]:https://cocoapods.org/pods/Commercetools
[cocoapods img]:https://img.shields.io/cocoapods/v/Commercetools.svg

[license]:LICENSE
[license img]:https://img.shields.io/badge/License-Apache%202-blue.svg