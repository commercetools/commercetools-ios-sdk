//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public enum CartUpdateAction: JSONRepresentable {

    case addLineItem(options: AddLineItemOptions)
    case removeLineItem(options: RemoveLineItemOptions)
    case changeLineItemQuantity(options: ChangeLineItemQuantityOptions)
    case setCustomerEmail(options: SetCustomerEmailOptions)
    case setShippingAddress(options: SetShippingAddressOptions)
    case setBillingAddress(options: SetBillingAddressOptions)
    case setCountry(options: SetCountryOptions)
    case setShippingMethod(options: SetShippingMethodOptions)
    case setCustomShippingMethod(options: SetCustomShippingMethodOptions)
    case addDiscountCode(options: AddDiscountCodeOptions)
    case removeDiscountCode(options: RemoveDiscountCodeOptions)
    case recalculate(options: RecalculateOptions)
    case setCustomType(options: SetCustomTypeOptions)
    case setCustomField(options: SetCustomFieldOptions)
    case setLineItemCustomType(options: SetLineItemCustomTypeOptions)
    case setLineItemCustomField(options: SetLineItemCustomFieldOptions)
    case addPayment(options: AddPaymentOptions)
    case removePayment(options: RemovePaymentOptions)
    case setLocale(options: SetLocaleOptions)

    public var toJSON: [String: Any] {
        switch self {
        case .addLineItem(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "addLineItem"
            return optionsJSON
        case .removeLineItem(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "removeLineItem"
            return optionsJSON
        case .changeLineItemQuantity(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "changeLineItemQuantity"
            return optionsJSON
        case .setCustomerEmail(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setCustomerEmail"
            return optionsJSON
        case .setShippingAddress(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setShippingAddress"
            return optionsJSON
        case .setBillingAddress(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setBillingAddress"
            return optionsJSON
        case .setCountry(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setCountry"
            return optionsJSON
        case .setShippingMethod(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setShippingMethod"
            return optionsJSON
        case .setCustomShippingMethod(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setCustomShippingMethod"
            return optionsJSON
        case .addDiscountCode(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "addDiscountCode"
            return optionsJSON
        case .removeDiscountCode(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "removeDiscountCode"
            return optionsJSON
        case .recalculate(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "recalculate"
            return optionsJSON
        case .setCustomType(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setCustomType"
            return optionsJSON
        case .setCustomField(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setCustomField"
            return optionsJSON
        case .setLineItemCustomType(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setLineItemCustomType"
            return optionsJSON
        case .setLineItemCustomField(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setLineItemCustomField"
            return optionsJSON
        case .addPayment(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "addPayment"
            return optionsJSON
        case .removePayment(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "removePayment"
            return optionsJSON
        case .setLocale(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setLocale"
            return optionsJSON
        }
    }
}

public struct AddLineItemOptions: Mappable {

    // MARK: - Properties

    public var productId: String?
    public var variantId: Int?
    public var quantity: UInt?
    public var supplyChannel: Reference<Channel>?
    public var distributionChannel: Reference<Channel>?
    public var custom: [String: Any]?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        productId                    <- map["productId"]
        variantId                    <- map["variantId"]
        quantity                     <- map["quantity"]
        supplyChannel                <- map["supplyChannel"]
        distributionChannel          <- map["distributionChannel"]
        custom                       <- map["custom"]
    }
}

public struct RemoveLineItemOptions: Mappable {

    // MARK: - Properties

    public var lineItemId: String?
    public var quantity: UInt?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        lineItemId                  <- map["lineItemId"]
        quantity                    <- map["quantity"]
    }
}

public struct ChangeLineItemQuantityOptions: Mappable {

    // MARK: - Properties

    public var lineItemId: String?
    public var quantity: UInt?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        lineItemId                  <- map["lineItemId"]
        quantity                    <- map["quantity"]
    }
}

public struct SetCustomerEmailOptions: Mappable {

    // MARK: - Properties

    public var email: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        email                    <- map["email"]
    }
}

public struct SetShippingAddressOptions: Mappable {

    // MARK: - Properties

    public var address: Address?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        address                   <- map["address"]
    }
}

public struct SetBillingAddressOptions: Mappable {

    // MARK: - Properties

    public var address: Address?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        address                   <- map["address"]
    }
}

public struct SetCountryOptions: Mappable {

    // MARK: - Properties

    public var country: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        country                    <- map["country"]
    }
}

public struct SetShippingMethodOptions: Mappable {

    // MARK: - Properties

    public var shippingMethod: Reference<ShippingMethod>?
    public var externalTaxRate: ExternalTaxRateDraft?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        shippingMethod              <- map["shippingMethod"]
        externalTaxRate             <- map["externalTaxRate"]
    }
}

public struct SetCustomShippingMethodOptions: Mappable {

    // MARK: - Properties

    public var shippingMethodName: String?
    public var shippingRate: ShippingRate?
    public var taxCategory: Reference<TaxCategory>?
    public var externalTaxRate: ExternalTaxRateDraft?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        shippingMethodName          <- map["shippingMethodName"]
        shippingRate                <- map["shippingRate"]
        taxCategory                 <- map["taxCategory"]
        externalTaxRate             <- map["externalTaxRate"]
    }
}

public struct AddDiscountCodeOptions: Mappable {

    // MARK: - Properties

    public var code: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        code                        <- map["code"]
    }
}

public struct RemoveDiscountCodeOptions: Mappable {

    // MARK: - Properties

    public var discountCode: Reference<DiscountCode>?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        discountCode                 <- map["discountCode"]
    }
}

public struct RecalculateOptions: Mappable {

    // MARK: - Properties

    public var updateProductData: Bool?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        updateProductData            <- map["updateProductData"]
    }
}

public struct SetCustomTypeOptions: Mappable {

    // MARK: - Properties

    public var type: ResourceIdentifier?
    public var fields: [String: Any]?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type                        <- map["type"]
        fields                      <- map["fields"]
    }
}

public struct SetCustomFieldOptions: Mappable {

    // MARK: - Properties

    public var name: String?
    public var value: Any?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        name                        <- map["name"]
        value                       <- map["value"]
    }
}

public struct SetLineItemCustomTypeOptions: Mappable {

    // MARK: - Properties

    public var type: ResourceIdentifier?
    public var lineItemId: String?
    public var fields: [String: Any]?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type                        <- map["type"]
        lineItemId                  <- map["lineItemId"]
        fields                      <- map["fields"]
    }
}

public struct SetLineItemCustomFieldOptions: Mappable {

    // MARK: - Properties

    public var lineItemId: String?
    public var name: String?
    public var value: Any?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        lineItemId                  <- map["lineItemId"]
        name                        <- map["name"]
        value                       <- map["value"]
    }
}

public struct AddPaymentOptions: Mappable {

    // MARK: - Properties

    public var payment: Reference<Payment>?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        payment                     <- map["payment"]
    }
}

public struct RemovePaymentOptions: Mappable {

    // MARK: - Properties

    public var payment: Reference<Payment>?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        payment                     <- map["payment"]
    }
}

public struct SetLocaleOptions: Mappable {

    // MARK: - Properties

    public var locale: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        locale                       <- map["locale"]
    }
}