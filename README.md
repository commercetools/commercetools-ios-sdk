# Commercetools Swift SDK

<img src="https://user-images.githubusercontent.com/14024032/60341258-32f83f80-99ae-11e9-86c0-1eb52f201a0d.png" height="80" />

<p>
<a href="https://travis-ci.org/commercetools/commercetools-ios-sdk" target="_blank">
<img src="https://travis-ci.org/commercetools/commercetools-ios-sdk.svg?branch=master">
</a>
<a href="http://cocoadocs.org/docsets/Commercetools" target="_blank">
<img src="https://img.shields.io/cocoapods/v/Commercetools.svg">
</a>
<a href="https://developer.apple.com/swift/" target="_blank">
<img src="https://img.shields.io/badge/Swift-5-orange.svg?style=flat" alt="Swift 5">
</a>
<a href="https://developer.apple.com/swift/" target="_blank">
<img src="https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-4E4E4E.svg?colorA=EF5138" alt="Platforms iOS | macOS | watchOS | tvOS | Linux">
</a>
<a href="https://github.com/apple/swift-package-manager" target="_blank">
<img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat&colorB=64A5DE" alt="SPM compatible">
</a>
<a href="LICENSE" target="_blank">
<img src="https://img.shields.io/badge/License-Apache%202-blue.svg">
</a>
</p>

## Installation

### Requirements

- iOS 10.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 9.0+
- Swift 5.0+

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.2.1+ is required to build CommercetoolsSDK 0.7+.

To integrate CommercetoolsSDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

pod 'Commercetools', '~> 0.11'
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
	<key>machineLearningApiUrl</key>
    <string>https://ml-eu.europe-west1.gcp.commercetools.com</string>
	<key>anonymousSession</key>
    <true/>
    <key>keychainAccessGroupName</key>
    <string>AB123CDEF.yourKeychainGroup</string>
    <key>shareWatchSession</key>
    <true/>
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

## In-Store Customers

When using stores, a customer can either register globally, or have a registration specific to a store. In the latter case, to login customer in a store, a `storeKey` parameter needs to be set:

```swift
let username = "swift.sdk.test.in.store.user@commercetools.com"
let password = "password"

Commercetools.loginCustomer(username, password: password, storeKey: "store-key", completionHandler: { result in
    if let error = result.errors?.first as? CTError {
        // Handle error, and possibly get some more information from reason.message
    }
})
```

## External OAuth tokens

Commercetools platform and the SDK provides the ability to use external OAuth tokens. In order to set a token from your app, use `Commercetools.externalToken` property. Once set, this token will be used for all platform requests from the SDK. In order to stop using external token, simply set this value to `nil`.

When using an external token, it is important to handle expired and invalid token scenarios manually. Completion handler will provide a `CTError` with additional information, and the client should decide whether a token needs to be refreshed, or a recovery is not possible (e.g deleted account).

To get more information on setting up and using external OAuth with commercetools platform, please refer to [this page](https://docs.commercetools.com/http-api-authorization#requesting-an-access-token-using-an-external-oauth-server-beta).

## Using the SDK in App Extensions

If your app has extensions, and you want to use Commercetools SDK in those extensions, we recommend enabling keychain sharing. By allowing keychain sharing, and setting the appropriate access group name in the configuration `.plist`, the SDK will save all tokens in the shared keychain. Be sure to include _App ID Prefix / Team ID_ in the access group name.
As a result, you can use all endpoints with the same authorization state and tokens in both your app and any extension. The same goes for multiple apps from your development team using keychain sharing.

## Using the SDK on watchOS

Since the keychain on Apple Watch contains a distinct set of entries from the keychain on the paired iPhone, sharing the same customer session between iOS and watchOS is not possible by setting the `keychainAccessGroupName` in the configuration `.plist`. Instead, the Commercetools SDK uses WatchConnectivity to transfer access tokens from an iPhone to an Apple Watch, where they are also stored securely in the watchOS keychain. The only step you have to take to opt in, is to set the `shareWatchSession` configuration property to `true`.

A common way for users to log in on Apple Watch is via the iPhone app. The watchOS SDK will post a notification when the access tokens have been received from the iOS app, so you can check the new `authState` and perform UI changes accordingly.
```swift
NotificationCenter.default.addObserver(self, selector: #selector(checkAuthState), name: Notification.Name.WatchSynchronization.DidReceiveTokens, object: nil)

func checkAuthState() {
    if Commercetools.authState == .customerToken {
        // The customer is logged in, present the appropriate screen
    } else {
        // The customer is not logged in, present the login message if needed 
    }
}
```

## Consuming Commercetools Endpoints

Consuming and managing resources provided through available endpoints is very easy for any of the available endpoint classes.

Depending on the capabilities of the resource, you can retrieve by specific UUID, use more detailed query options, and also perform create or update operations.

All of these functionalities are provided by static methods for any specific supported endpoint. For an example, you can create shopping cart using provided `Cart` class:
```swift
var cartDraft = CartDraft(currency: "EUR")

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

#### Project settings

In order to get the countries, languages, and currencies supported for the current Commercetools project, you should use the project settings endpoint:
```swift
Project.settings { result in
    if let settings = result.model {
        // use settings.currencies, settings.countries, settings.languages, etc
    }
}
```

#### Cart

Cart endpoint supports all common operations:
- Retrieve active cart
```swift
Cart.active(result: { result in
    if let cart = result.model, result.isSuccess {
        // Cart successfully retrieved, response contains currently active cart
    } else {
        // Your user might not have an active cart at the moment
    }
})
```
- Query for carts
```swift
Cart.query(limit: 2, offset: 1, result: { result in
    if let response = result.model, let count = response.count,
            let results = response.results, result.isSuccess {
        // response contains an array of cart instances
    }
})
```
- Create new cart
```swift
var cartDraft = CartDraft()
cartDraft.currency = "EUR"

Cart.create(cartDraft, result: { result in
    if let cart = result.model, let cartState = cart.cartState, result.isSuccess {
        // Cart successfully created, and cart contains 
    }
})
```
- Update existing cart
```swift
let draft = LineItemDraft(productVariantSelection: .productVariant(productId: productId, variantId: variantId))

let updateActions = UpdateActions<CartUpdateAction>(version: version, actions: [.addLineItem(lineItemDraft: draft)])
Cart.update(cartId, actions: updateActions, result: { result in
    if let cart = result.model, result.isSuccess {
        // Cart successfully updated, response contains updated cart
    }
})
```
- Delete existing cart
```swift
let version = 1 // Set the appropriate current version

Cart.delete(cartId, version: version, result: { result in
    if let cart = result.model, result.isSuccess {
        // Cart successfully deleted
    }
})
```
- Retrieve cart by UUID
```swift
Cart.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
    if let cart = result.model, cart.cartState == .active && result.isSuccess {
        // response contains cart dictionary
    }
})
```

There is also a subset of Cart methods for in-store actions. The parameters are the same as the methods above, with an additional parameter specifying the store key (`storeKey: String`).

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
// Optionally set `storeKey` for customers registered in a specific store.
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

// Optionally set `storeKey` to sign up the customer in that store.
Commercetools.signUpCustomer(customerDraft, result: { result in
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
// Optionally set `storeKey` for customers registered in a specific store.
Customer.update(actions: updateActions, result: { result in
    if let customer = result.model, let version = customer.version, result.isSuccess {
    	// User profile successfully updated
    }
})
```
- Delete customer account (user must be logged in)
```swift
// Optionally set `storeKey` for customers registered in a specific store.
Customer.delete(version: version, result: { result in
    if let customer = result.model, result.isSuccess {
        // Customer was successfully deleted
    }
})
```
- Change password (user must be logged in)
```swift
let  version = 1 // Set the appropriate current version

// Optionally set `storeKey` for customers registered in a specific store.
Customer.changePassword(currentPassword: "password", newPassword: "newPassword", version: version, result: { result in
    if let customer = result.model, result.isSuccess {
    	// Password has been changed, and now AuthManager has automatically obtained new access token
    }
})
```
- Reset password with token (anonymous user is being handled by `AuthManager`)
```swift
let token = "" // Usually this token is retrieved from the password reset link, in case your app does support universal links

// Optionally set `storeKey` for customers registered in a specific store.
Customer.resetPassword(token: token, newPassword: "password", result: { result in
    if let customer = result.model, let email = customer.email, result.isSuccess {
        // Password has been successfully reset, now would be a good time to present the login screen
    }
})
```
- Verify email with token (user must be logged in)
```swift
let token = "" // Usually this token is retrieved from the activation link, in case your app does support universal links

// Optionally set `storeKey` for customers registered in a specific store.
Customer.verifyEmail(token: token, result: { result in
    if let customer = result.model, let email = customer.email, result.isSuccess {
        // Email has been successfully verified, probably show UIAlertController with this info
    }
})
```

#### Order

Order endpoint provides the ability to create an order from an existing `Cart`, but also retrieve orders by UUID, and perform queries for orders.

#### Shipping Method

In order to present shipping options to the customer during checkout, you need to use the shipping method endpoint:
- Retrieve shipping methods for a cart
```swift
ShippingMethod.for(cart: cart) { result in
    if let shippingMethods = result.model, result.isSuccess {
        // present shipping methods to the customer
    }
}
```
- Retrieve shipping methods for a country
```swift
ShippingMethod.for(country: "DE") { result in
    if let shippingMethods = result.model, result.isSuccess {
        // present shipping methods to the customer
    }
}
```
- Query for shipping methods
```swift
let predicate = "name=\"DHL\""

ShippingMethod.query(predicates: [predicate], result: { result in
    if let response = result.model, let count = response.count,
			let results = response.results, result.isSuccess {
        // results contains an array of shipping method objects
    }
})
```
- Retrieve shipping method by UUID
```swift
ShippingMethod.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
    if let shippingMethod = result.model, result.isSuccess {
        // response contains product projection object
    }
})
```

#### Product Projection

Most common way for your iOS app to retrieve the product data is by consuming the product projection endpoint. The following actions are currently supported:
- Search for product projections
```swift
ProductProjection.search(sort: ["name.en asc"], limit: 10, lang: Locale(identifier: "en"), text: "Michael Kors", result: { result in
    if let response = result.model, let total = response.total,
    		let results = response.results, result.isSuccess {
        // results contains an array of product projection objects
    }
})
```
- Product projection keyword suggestions
```swift
ProductProjection.suggest(lang: Locale(identifier: "en"), searchKeywords: "michael", result: { result in
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

#### Store

Using `view_stores` scope, it is possible to retrieve by UUID, key and query for stores.
- Query for stores
```swift
Store.query(limit: 10, offset: 1, result: { result in
    if let response = result.model, let count = response.count,
            let stores = response.results, result.isSuccess {
        // stores contains an array of store objects
    }
})
```
- Retrieve store by UUID
```swift
Store.byId("cddddddd-ffff-4b44-b5b0-004e7d4bc2dd", result: { result in
    if let store = result.model, result.isSuccess {
        // response contains store object
    }
})
```
- Retrieve store by key
```swift
Store.byKey("unionSquare", result: { result in
    if let store = result.model, result.isSuccess {
        // response contains store object
    }
})
```

## Consuming Machine Learning Endpoints

For [machine learning API](https://docs.commercetools.com/http-api-ml) Commercetools provides, the SDK has a separate set of endpoints.

### Currently Supported Machine Learning Endpoints

#### Similar products
Searching for similar products is possible using one method for initiating a search request, and another for checking the progress and obtaining search results.
- Initiate a search request for similar products
```swift
let request = SimilarProductSearchRequest(limit: 10, similarityMeasures: SimilarityMeasures(name: 1))

SimilarProducts.initiateSearch(request: request) { result in
    if let taskToken = result.model {
        // use taskToken.taskId to monitor for progress
    }
}
```
- Check for status, and obtain results
```swift
SimilarProducts.status(for: taskToken.taskId) { result in
    if let taskStatus = result.model, taskStatus == .success {
        // task has been completed, use taskStatus.result to get the products from `PagedQueryResult`
    }
}
```

#### Category recommendations
Searching for best-fitting categories for a specific product ID is possible using provided query method.
- Searching for category recommendations
```swift
CategoryRecommendations.query(productId: product.id) { result in
    if let results = result.model?.results {
        // results contains an array of `ProjectCategoryRecommendation`s
    }
}
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
