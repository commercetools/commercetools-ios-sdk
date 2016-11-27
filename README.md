# Commercetools iOS SDK

![SPHERE.IO icon](https://admin.sphere.io/assets/images/sphere_logo_rgb_long.png)

[![][travis img]][travis]
[![][cocoapods img]][cocoapods]
[![][platforms img]][platforms]
[![][license img]][license]

## Installation

### Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.1+
- Swift 3.0+

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build CommercetoolsSDK 0.3+.

To integrate CommercetoolsSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'Commercetools', '~> 0.5'
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
	<key>anonymousSession</key>
    <true/>
    <key>keychainAccessGroupName</key>
    <string>AB123CDEF.yourKeychainGroup</string>
    <key>emergencyContactInfo</key>
    <string>you@yourdomain.com</string>
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
    // configuration.logLevel = .error
    
    // Or completely disable all log messages from Commercetools SDK
    // configuration.loggingEnabled = false
    
    // Finally, you need set your configuration before using the SDK
    Commercetools.config = configuration
    
} else {
    // There are some errors in your .plist file, check log messages for more information
}
```

## Authenticated and Anonymous Usage

Endpoints from the Commercetools services can be consumed without Checkout (`PlainToken`), with Guest Checkout (`AnonymousToken`) or with a logged in customer (`CustomerToken`). According to the configuration, all interactions with the Commercetools platform will be performed with a `PlainToken` or a `AnonymousToken` per default.

If at some point you wish to login the user, that can be achieved using `loginUser` method:

```swift
let username = "swift.sdk.test.user@commercetools.com"
let password = "password"

Commercetools.loginCustomer(username, password: password, completionHandler: { result in
    if let error = result.errors?.first as? CTError, case .accessTokenRetrievalFailed(let reason) = error {
        // Handle error, and possibly get some more information from reason.message
    }
})
```

Similarly, after logging out, all further interactions continue to use new anonymous user token.

```swift
Commercetools.logoutCustomer()
```

Access and refresh tokens are being preserved across app launches. In order to inspect whether it's currently handling authenticated or anonymous user, `authState` property should be used:

```swift
if Commercetools.authState == .plainToken {
    // Present login form or other logic
}
```
In order for your app to support anonymous session, you should set the `anonymousSession` bool property in your configuration `.plist` file to `true`. Additionally, it is possible to override this setting, and also provide optional custom `anonymous_id` (for metrics and tracking purposes) by invoking:
```swift
Commercetools.obtainAnonymousToken(usingSession: true, anonymousId: "some-custom-id", completionHandler: { error in
    if error == nil {
        // It is possible for token retrieval to fail, e.g custom token ID has already been taken,
        // in which case reason.message from the returned CTError instance is set to the anonymousId is already in use.
    }
})
```
When an anonymous sessions ends with a sign up or a login, carts and orders are migrated to the customer, and `CustomerSignInResult` is returned, providing access to both customer profile, and the currently active cart. For the login operation, you can define how to migrate line items from the currently active cart, by explicitly specifying one of two `AnonymousCartSignInMode` values: `.mergeWithExistingCustomerCart` or `.useAsNewActiveCustomerCart`.

If your app has extensions, and you want to use Commercetools SDK in those extensions, we recommend enabling keychain sharing. By allowing keychain sharing, and setting the appropriate access group name in the configuration `.plist`, the SDK will save all tokens in the shared keychain. Be sure to include _App ID Prefix / Team ID_ in the access group name.
As a result, you can use all endpoints with the same authorization state and tokens in both your app and any extension. The same goes for multiple apps from your development team using keychain sharing. 

## Consuming Commercetools Endpoints

Consuming and managing resources provided through available endpoints is very easy for any of the available endpoint classes.

Depending on the capabilities of the resource, you can retrieve by specific UUID, use more detailed query options, and also perform create or update operations.

All of these functionalities are provided by static methods for any specific supported endpoint. For an example, you can creating shopping cart using provided `Cart` class:
```swift
var cartDraft = CartDraft()
cartDraft.currency = "EUR"

Cart.create(cartDraft, result: { result in
	if let cart = result.model, result.isSuccess {
		// Do any work with created `Cart` instance, i.e:
		if cart.cartState == .active {
			// Our cart is active!
		}
	}
})
```

In case you need resources from an endpoint which hasn't been implemented in our SDK yet, you can easily create class representing that endpoint, and conform to appropriate protocols which take care of abstract endpoint implementations for many common use cases.

The following list represents currently supported abstract endpoints. For each protocol, there is a default extension provided, which will almost always cover your needs:

* Create endpoint - `create(object: [String: AnyObject], expansion: [String]?, result: (Result<ResponseType>) -> Void)`
* Update endpoint - `update(id: String, version: UInt, actions: [[String: AnyObject]], expansion: [String]?, result: (Result<ResponseType>) -> Void)`
* Update by key endpoint - `updateByKey(key: String, version: UInt, actions: [[String: AnyObject]], expansion: [String]?, result: (Result<ResponseType>) -> Void)`
* Query endpoint - `query(predicates predicates: [String]?, sort: [String]?, expansion: [String]?, limit: UInt?, offset: UInt?, result: (Result<QueryResponse<ResponseType>>) -> Void)`
* Retrieve resource by ID endpoint - `byId(id: String, expansion: [String]?, result: (Result<ResponseType>) -> Void)`
* Retrieve resource by key endpoint - `byKey(key: String, expansion: [String]?, result: (Result<ResponseType>) -> Void)`
* Delete endpoint - `delete(id: String, version: UInt, expansion: [String]?, result: (Result<ResponseType>) -> Void)`

### Currently Supported Endpoints

#### Cart

Cart endpoint supports all common operations:
- Retrieve active cart (user must be logged in)
```swift
Cart.active(result: { result in
    if let cart = result.model, result.isSuccess {
        // Cart successfully retrieved, response contains currently active cart
    } else {
        // Your user might not have an active cart at the moment
    }
})
```
- Query for carts (user must be logged in)
```swift
Cart.query(limit: 2, offset: 1, result: { result in
    if let response = result.model, let count = response.count,
            let results = response.results, result.isSuccess {
        // response contains an array of cart instances
    }
})
```
- Create new cart (user must be logged in)
```swift
var cartDraft = CartDraft()
cartDraft.currency = "EUR"

Cart.create(cartDraft, result: { result in
    if let cart = result.model, let cartState = cart.cartState, result.isSuccess {
        // Cart successfully created, and cart contains 
    }
})
```
- Update existing cart (user must be logged in)
```swift
var options = AddLineItemOptions()
options.productId = productId
options.variantId = 1 // Set the appropriate current version

let updateActions = UpdateActions<CartUpdateAction>(version: version, actions: [.addLineItem(options: options)])
Cart.update(cartId, actions: updateActions, result: { result in
    if let cart = result.model, result.isSuccess {
        // Cart successfully updated, response contains updated cart
    }
})
```
- Delete existing cart (user must be logged in)
```swift
let version = 1 // Set the appropriate current version

Cart.delete(cartId, version: version, result: { result in
    if let cart = result.model, result.isSuccess {
        // Cart successfully deleted
    }
})
```
- Retrieve cart by UUID (user must be logged in)
```swift
Cart.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
    if let cart = result.model, cart.cartState == .active && result.isSuccess {
        // response contains cart dictionary
    }
})
```

#### Category

Using regular mobile scope, it is possible to retrieve by UUID and query for categories.
- Query for categories
```swift
Category.query(limit: 10, offset: 1, result: { result in
    if let response = result.model, let count = response.count,
            let categories = response.results, result.isSuccess {
        // categories contains an array of category objects
    }
})
```
- Retrieve category by UUID
```swift
Category.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
    if let category = result.model, result.isSuccess {
        // response contains category objects
    }
})
```

#### Customer

Customer endpoint offers you several possible actions to use from your iOS app:
- Retrieve user profile (user must be logged in)
```swift
Customer.profile { result in
    if let profile = result.model, let firstName = profile.firstName,
            let lastName = profile.lastName, result.isSuccess {
        // E.g present user profile details
    }
}
```
- Sign up for a new account (anonymous user is being handled by `AuthManager`)
```swift
var customerDraft = CustomerDraft()
customerDraft.email = "new.swift.sdk.test.user@commercetools.com"
customerDraft.password = "password"

Customer.signup(customerDraft, result: { result in
    if let customer = result.model?.customer, let version = customer.version, result.isSuccess {
        // User has been successfully signed up.
        // Now, you'd probably want to present the login form, or simply
        // use AuthManager to login user automatically
    }
})
```
- Update customer account (user must be logged in)
```swift
var options = SetFirstNameOptions()
options.firstName = "newName"

let updateActions = UpdateActions<CustomerUpdateAction>(version: version, actions: [.setFirstName(options: options)])
Customer.update(actions: updateActions, result: { result in
    if let customer = result.model, let version = customer.version, result.isSuccess {
    	// User profile successfully updated
    }
})
```
- Delete customer account (user must be logged in)
```swift
Customer.delete(version: version, result: { result in
    if let customer = result.model, result.isSuccess {
        // Customer was successfully deleted
    }
})
```
- Change password (user must be logged in)
```swift
let  version = 1 // Set the appropriate current version

Customer.changePassword(currentPassword: "password", newPassword: "newPassword", version: version, result: { result in
    if let customer = result.model, result.isSuccess {
    	// Password has been changed, and now AuthManager has automatically obtained new access token
    }
})
```
- Reset password with token (anonymous user is being handled by `AuthManager`)
```swift
let token = "" // Usually this token is retrieved from the password reset link, in case your app does support universal links

Customer.resetPassword(token: token, newPassword: "password", result: { result in
    if let customer = result.model, let email = customer.email, result.isSuccess {
        // Password has been successfully reset, now would be a good time to present the login screen
    }
})
```
- Verify email with token (user must be logged in)
```swift
let token = "" // Usually this token is retrieved from the activation link, in case your app does support universal links

Customer.verifyEmail(token: token, result: { result in
    if let customer = result.model, let email = customer.email, result.isSuccess {
        // Email has been successfully verified, probably show UIAlertController with this info
    }
})
```

#### Order

Order endpoint provides the ability to create an order from an existing `Cart`, but also retrieve orders by UUID, and perform queries for orders.

#### Product Projection

Most common way for your iOS app to retrieve the product data is by consuming the product projection endpoint. The following actions are currently supported:
- Search for product projections
```swift
ProductProjection.search(sort: ["name.en asc"], limit: 10, lang: NSLocale(localeIdentifier: "en"), text: "Michael Kors", result: { result in
    if let response = result.model, let total = response.total,
    		let results = response.results, result.isSuccess {
        // results contains an array of product projection objects
    }
})
```
- Product projection keyword suggestions
```swift
ProductProjection.suggest(lang: NSLocale(localeIdentifier: "en"), searchKeywords: "michael", result: { result in
    if let response = result.json, let keywords = response["searchKeywords.en"] as? [[String: AnyObject]],
    		let firstKeyword = keywords.first?["text"] as? String, result.isSuccess {
        // keywords contains an array of suggestions in dictionary representation
    }
})
```
- Query for product projections
```swift
let predicate = "slug(en=\"michael-kors-bag-30T3GTVT7L-lightbrown\")"

ProductProjection.query(predicates: [predicate], sort: ["name.en asc"], limit: 10, offset: 10, result: { result in
    if let response = result.model, let count = response.count,
			let results = response.results, result.isSuccess {
        // results contains an array of product projection objects
    }
})
```
- Retrieve product projection by UUID
```swift
ProductProjection.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
    if let product = result.model, result.isSuccess {
        // response contains product projection object
    }
})
```

#### Product Type

Using regular mobile scope, it is possible to retrieve by UUID, key and query for product types.
- Query for product types
```swift
ProductType.query(limit: 10, offset: 1, result: { result in
    if let response = result.model, let count = response.count,
            let productTypes = response.results, result.isSuccess {
        // productTypes contains an array of product type objects
    }
})
```
- Retrieve product type by UUID
```swift
ProductType.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
    if let productType = result.model, result.isSuccess {
        // response contains product type object
    }
})
```
- Retrieve product type by key
```swift
ProductType.byKey("main", result: { result in
    if let productType = result.model, result.isSuccess {
        // response contains product type object
    }
})
```

## Handling Results

In order to check whether any action with Commercetools services was successfully executed, you should use `isSuccess` or `isFailure` property of the result in question. For all successful operations, there're two properties, which can be used to consume actual responses. Recommended one for all endpoints which have incorporated models is `model`. This property has been used in all of the examples above. Alternatively, in case you are writing a custom endpoint, and do not wish to add model properties and mappings, `json` property will give you access to `[String: Any]` (dictionary representation of the JSON received from the Commercetools platform).

For all failed operations, `errors` property should be used from the result in question to present or handle specific issues. `CTError` instances are enumerations, with seven main cases, where each of those cases contains `FailureReason`, and some additional associated values, depending on the specific case.

## Tests Setup

If there is a need to implement a custom endpoint which communicates with Commercetools services, it is recommended that such endpoint is also tested. Our `XCTestCase` extension provides good examples on how to setup test configuration. For some tests regular mobile client scope is sufficient (in most cases `view_products manage_my_profile manage_my_orders`). If your tests require setup or configuration with higher level privileges (scope), you can setup them as well. SDK tests consume this configuration from the environment variables for safety reasons.

Setting up helper endpoints in test classes is also very easy. You can declare a private class conforming to specific endpoint protocols:
```swift
private class Foobar: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint {
    static let path = "foobar"
}
```

[](definitions for the top badges)

[travis]:https://travis-ci.org/commercetools/commercetools-ios-sdk
[travis img]:https://travis-ci.org/commercetools/commercetools-ios-sdk.svg?branch=master

[cocoapods]:http://cocoadocs.org/docsets/Commercetools
[cocoapods img]:https://img.shields.io/cocoapods/v/Commercetools.svg

[platforms]:http://cocoadocs.org/docsets/Commercetools
[platforms img]:https://img.shields.io/cocoapods/p/Commercetools.svg?style=flat

[license]:LICENSE
[license img]:https://img.shields.io/badge/License-Apache%202-blue.svg