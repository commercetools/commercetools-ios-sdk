# Commercetools iOS SDK

![SPHERE.IO icon](https://admin.sphere.io/assets/images/sphere_logo_rgb_long.png)

[![][travis img]][travis]
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

pod 'Commercetools', '~> 0.0.1'
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

## Authenticated and anonymous usage

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

[](definitions for the top badges)

[travis]:https://travis-ci.org/sphereio/commercetools-ios-sdk
[travis img]:https://travis-ci.org/sphereio/commercetools-ios-sdk.svg?branch=master

[license]:LICENSE
[license img]:https://img.shields.io/badge/License-Apache%202-blue.svg