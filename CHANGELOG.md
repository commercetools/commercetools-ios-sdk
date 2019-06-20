# Change Log
All changes to this project will be documented in this file.

#### 0.x Releases
- `0.9.x` Releases - [0.9.0](#090)
- `0.8.x` Releases - [0.8.0](#080)
- `0.7.x` Releases - [0.7.0](#070) | [0.7.1](#071) | [0.7.2](#072) | [0.7.3](#073) | [0.7.4](#074) | [0.7.5](#075)
- `0.6.x` Releases - [0.6.0](#060) | [0.6.1](#061)
- `0.5.x` Releases - [0.5.0](#050) | [0.5.1](#051) | [0.5.2](#052) | [0.5.3](#053) | [0.5.4](#054) | [0.5.5](#055) | [0.5.6](#056) | [0.5.7](#057) | [0.5.8](#058) | [0.5.9](#059)
- `0.4.x` Releases - [0.4.0](#040) | [0.4.1](#041) | [0.4.2](#042)
- `0.3.x` Releases - [0.3.0](#030)
- `0.2.x` Releases - [0.2.0](#020)
- `0.1.x` Releases - [0.1.0](#010)
- `0.0.x` Releases - [0.0.1](#001) | [0.0.2](#002) | [0.0.3](#003)

---

## [0.9.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.9.0)
Released on 2019-06-20.

#### Added
- `key` attribute to the `CartDiscount`.
- `key` attribute to the `ProductDiscount`.
- `lastModifiedBy` and `createdBy` fields to a number of endpoints.
- Following methods for the `Cart`:
  - Get a Cart in a Store by ID
  - Get Active Cart in a Store by ID
  - Query Carts in a Store
  - Create a Cart in a Store
  - Update a Cart in a Store
  - Delete a Cart in a Store
- Following methods for the `Order`:
  - Get Order in a Store by ID
  - Query Orders in a Store by ID
  - Create Order in a Store from a Cart

#### Updated
- `SimilarProductSearchRequestMeta` model.
- Similar Products’s `ProductSetSelector`.

## [0.8.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.8.0)
Released on 2019-04-26.

#### Added
- `SimilarProducts` machine learning endpoint.
- `CategoryRecommendations` machine learning endpoint.
- `Store` endpoint.
- `CustomLineItemReturnItem` to be used on a `ReturnInfo`.
- `key` attribute on the `Zone`.

#### Updated
- Use `ResourceIdentifier` for `distributionChannel` and `supplyChannel` on `LineItemDraft`.
- Use `ResourceIdentifier` for `shippingMethod` on `CartDraft`.

## [0.7.6](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.7.6)
Released on 2018-08-31.

#### Added
- Support for recovering from invalid access token.
- `invalidToken` error type.

## [0.7.5](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.7.5)
Released on 2018-06-11.

#### Added
- Support for high precision money.
- `LineItem` specific shipping addresses.
- `groups` to `DiscountCode`s.
- `CartOrigin`
- Custom field to `CustomerGroup`.

## [0.7.4](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.7.4)
Released on 2018-02-02.

#### Added
- `notValid` and `applicationStoppedByPreviousDiscount` to `DiscountCodeState`.
- `validFrom` and `validUntil` to `DiscountCode` and `ProductDiscount`.
- `key` to `Asset`.
- Custom field to `CartDiscount`.

## [0.7.3](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.7.3)
Released on 2017-11-14.

#### Added
- Custom field to the `DiscountCode`.
- `StackingMode` to `CartDiscount`.

## [0.7.2](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.7.2)
Released on 2017-09-29.

#### Added
- `ExternalAmount` to `TaxMode`.
- `Predicate` to `ShippingMethod`.
- `ShippingMethodState` to `ShippingInfo`.

## [0.7.1](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.7.1)
Released on 2017-09-15.

#### Added
- Support for `ShoppingList` endpoint.
- Support for `Payment` endpoint.

#### Removed
- `trialUntil` field on `Project` settings.

## [0.7.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.7.0)
Released on 2017-08-18.

#### Added
- `key` to the `Customer` endpoint.
- `key` to the `TaxCategory` model.

#### Updated
- Replaced `[String: Any]` instances with `JsonValue` enum.

#### Removed
- ObjectMapper dependency.

## [0.6.1](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.6.1)
Released on 2017-08-04.

#### Added
- Support for adding products to cart by SKU.
- `ShippingMethod` endpoint now conforms to `ByKeyEndpoint` protocol.
- Linux support.

#### Removed
- Alamofire dependency.

## [0.6.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.6.0)
Released on 2017-07-14.

#### Added
- `ExternalPrice` case to the `LineItemPriceMode`.
- Add `key` field to the `CustomerGroup`.
- Support for Swift 4.

#### Updated
- Updated all models and update actions, so that optional fields in the SDK are only those which are also optional according to the API specs.

## [0.5.9](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.9)
Released on 2017-05-31.

#### Added
- `PriceTier`, `tiers` array to the `Price` model.
- `salutation` field for the `Customer` endpoint, as well as `setSalutation` update action.
- `Category` endpoint now conforms to `ByKeyEndpoint` protocol.
- `lineItemMode` to `LineItem`, `refusedGifts` to `Cart` endpoint.

#### Updated
- `ProductProjection` `search` and `suggest` endpoint: language parameter now being set based on the locale and language identifier, compared against project settings.

## [0.5.8](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.8)
Released on 2017-05-05.

#### Added
- `isMatching` filed to the `ShippingRate` model.

#### Updated
- `ProductProjection` `search` and `suggest` endpoint: language parameter now being set based on the locale and language identifier, compared against project settings.

## [0.5.7](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.7)
Released on 2017-03-24.

#### Added
- Support for project settings endpoint.

## [0.5.6](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.6)
Released on 2017-03-20.

#### Added
- Support for `ShippingMethod` endpoint.

## [0.5.5](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.5)
Released on 2017-03-01.

#### Added
- Public modifier for the dictionary config initializer.

#### Updated
- Scope to be optional configuration parameter.
- Improved WatchConnectivity communication.

## [0.5.4](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.4)
Released on 2017-02-20.

#### Added
- `taxRoundingMode` field to `Cart` and `Order` endpoints.
- Support for multiple filters for product projection search.
- `deleteDaysAfterLastModification` to the `Cart` endpoint.
- Fixes for Swift Package Manager.

## [0.5.3](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.3)
Released on 2017-01-23.

#### Added
- Support for `Category` assets.
- `productType` reference for cart line items.

## [0.5.2](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.2)
Released on 2017-01-02.

#### Added
- `shippingAddressIds` and `billingAddressIds` to `Customer` model.
- Update actions for `addShippingAddressId`, `removeShippingAddressId`, `addBillingAddressId`, and `removeBillingAddressId`.
- Extensions parameter for `Customer` profile endpoint.
- `geoLocation` field to `Channel` model.

## [0.5.1](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.1)
Released on 2016-12-09.

#### Added
- Token sharing between `iOS` and `watchOS` app using WatchConnectivity.

#### Updated
- Updated User-Agent header to properly identify newly added platforms.

## [0.5.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.5.0)
Released on 2016-11-27.

#### Added
- Support for `watchOS`, `tvOS`, and `macOS` platforms.

## [0.4.2](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.4.2)
Released on 2016-11-09.

#### Added
- Support for keychain sharing configuration when using the SDK for multiple apps, or apps and extension(s).
- `externalId` to the Address struct.
- `ProductProjection` endpoint now conforms to `ByKeyEndpoint` protocol.

## [0.4.1](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.4.1)
Released on 2016-10-31.

#### Added
- Support for carts and orders migration on successful log in or sign up, if using an anonymous session.
- Centralized customer authorization methods.

#### Removed
- Direct access to `AuthManager` `login` and `logut` method. From now on, `Commercetools.loginCustomer` and `Commercetools.logoutCustomer` should be used.
- Direct access to `Customer` `signUp` method. From now on, `Commercetools.signUpCustomer` should be used.

## [0.4.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.4.0)
Released on 2016-10-25.

#### Added
- Updated `Endpoint` protocol and `Result` enum to support model objects.
- Updated `Create`, `Delete`, `ById`, `ByKey`, and `UpdateByKey` endpoints to support models.
- Support for obtaining model and JSON dictionary results
- Added `NoMapping` type for easy endpoint creation where no domain model exists.
- `Cart`, `Category`, `Customer`, `Order`, `ProductProjection`, `ProductType` response models.
- Draft models for creating resources on `Cart`, `Customer`, and `Order` endpoint.
- Actions for updating `Cart` and `Customer` objects.
- Updated User-Agent header format.

## [0.3.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.3.0)
Released on 2016-09-23.

#### Added
- Migrated codebase to Swift 3.
- Introduced `CTError` type providing more flexible error handling.
- Updated project for Alamofire v4.0.

## [0.2.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.2.0)
Released on 2016-07-08.

#### Added
- Support for retrieving active cart.
- Anonymous sessions support, with flexible configuration.
- Multi target app support.
- Improved error handling.

## [0.1.0](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.1.0)
Released on 2016-05-12.

#### Added
- Product projections search functionality.
- Suggestions from product projections endpoint.
- Support for Swift package manager.
- Product type endpoint.
- Support for categories endpoint.

## [0.0.3](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.0.3)
Released on 2016-05-06.

#### Added
- Support for byKey retrieve and update endpoints.
- Customer profile endpoint and sign up.
- Advanced customer actions - account verification, password reset.
- Support for orders endpoint.
- Product projection endpoint query and retrieval functionality.

## [0.0.2](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.0.2)
Released on 2016-04-28.

#### Added
- Complete shopping cart support.
- Support for query endpoints.
- Support for byId endpoints.
- Support for delete endpoints.
- Support for create endpoints.

## [0.0.1](https://github.com/commercetools/commercetools-ios-sdk/releases/tag/0.0.1)
Released on 2016-04-21.

#### Added
- Initial release of the Commercetools SDK.
- Easy and customizable commercetools project configuration.
- Authentication manager completely abstracting away the entire auth process.