//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper
import CoreLocation

public struct Address: Mappable {

    // MARK: - Properties

    public var id: String?
    public var title: String?
    public var salutation: String?
    public var firstName: String?
    public var lastName: String?
    public var streetName: String?
    public var streetNumber: String?
    public var city: String?
    public var region: String?
    public var postalCode: String?
    public var additionalStreetInfo: String?
    public var state: String?
    public var country: String?
    public var company: String?
    public var department: String?
    public var building: String?
    public var apartment: String?
    public var pOBox: String?
    public var phone: String?
    public var mobile: String?
    public var email: String?
    public var fax: String?
    public var additionalAddressInfo: String?
    public var externalId: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                      <- map["id"]
        title                   <- map["title"]
        salutation              <- map["salutation"]
        firstName               <- map["firstName"]
        lastName                <- map["lastName"]
        city                    <- map["city"]
        region                  <- map["region"]
        postalCode              <- map["postalCode"]
        streetName              <- map["streetName"]
        additionalStreetInfo    <- map["additionalStreetInfo"]
        streetNumber            <- map["streetNumber"]
        state                   <- map["state"]
        country                 <- map["country"]
        company                 <- map["company"]
        department              <- map["department"]
        building                <- map["building"]
        apartment               <- map["apartment"]
        pOBox                   <- map["pOBox"]
        phone                   <- map["phone"]
        mobile                  <- map["mobile"]
        email                   <- map["email"]
        fax                     <- map["fax"]
        additionalAddressInfo   <- map["additionalAddressInfo"]
        externalId              <- map["externalId"]
    }

}

public enum AnonymousCartSignInMode: String {

    case mergeWithExistingCustomerCart = "MergeWithExistingCustomerCart"
    case useAsNewActiveCustomerCart = "UseAsNewActiveCustomerCart"

}

public struct Asset: Mappable {

    // MARK: - Properties

    public var id: String?
    public var sources: [AssetSource]?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var tags: [String]?
    public var custom: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id               <- map["id"]
        sources          <- map["sources"]
        name             <- map["name"]
        description      <- map["description"]
        tags             <- map["tags"]
        custom           <- map["custom"]
    }
}

public struct AssetSource: Mappable {

    // MARK: - Properties

    public var uri: String?
    public var key: String?
    public var dimensions: [AssetDimensions]?
    public var contentType: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        uri              <- map["uri"]
        key              <- map["key"]
        dimensions       <- map["dimensions"]
        contentType      <- map["contentType"]
    }
}

public struct AssetDimensions: Mappable {

    // MARK: - Properties

    public var w: Double?
    public var h: Double?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        w              <- map["w"]
        h              <- map["h"]
    }
}

public struct Attribute: Mappable {

    // MARK: - Properties

    public var name: String?
    public var value: AnyObject?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        name               <- map["name"]
        value              <- map["value"]
    }
}

public struct AttributeDefinition: Mappable {

    // MARK: - Properties

    public var type: AttributeType?
    public var name: String?
    public var label: [String: String]?
    public var inputTip: [String: String]?
    public var isRequired: Bool?
    public var isSearchable: Bool?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type               <- map["type"]
        name               <- map["name"]
        label              <- map["label"]
        inputTip           <- map["inputTip"]
        isRequired         <- map["isRequired"]
        isSearchable       <- map["isSearchable"]
    }

}

public class AttributeType: Mappable {

    // MARK: - Properties

    public var name: String?
    public var elementType: AttributeType?

    required public init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        name               <- map["name"]
        elementType        <- map["elementType"]
    }

}

public struct CartDiscount: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var value: CartDiscountValue?
    public var cartPredicate: String?
    public var target: CartDiscountTarget?
    public var sortOrder: String?
    public var isActive: Bool?
    public var validFrom: Date?
    public var validUntil: Date?
    public var requiresDiscountCode: Bool?
    public var references: [GenericReference]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                    <- map["id"]
        version               <- map["version"]
        createdAt             <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt        <- (map["lastModifiedAt"], ISO8601DateTransform())
        name                  <- map["name"]
        description           <- map["description"]
        value                 <- map["value"]
        cartPredicate         <- map["cartPredicate"]
        target                <- map["target"]
        sortOrder             <- map["sortOrder"]
        isActive              <- map["isActive"]
        validFrom             <- (map["validFrom"], ISO8601DateTransform())
        validUntil            <- (map["validUntil"], ISO8601DateTransform())
        requiresDiscountCode  <- map["requiresDiscountCode"]
        references            <- map["references"]
    }

}

public struct CartDiscountTarget: Mappable {

    // MARK: - Properties

    public var type: String?
    public var predicate: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type          <- map["type"]
        predicate     <- map["predicate"]
    }

}

public struct CartDiscountValue: Mappable {

    // MARK: - Properties

    public var type: String?
    public var permyriad: Int?
    public var money: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type          <- map["type"]
        permyriad     <- map["permyriad"]
        money         <- map["money"]
    }

}

public struct CartDraft: Mappable {

    // MARK: - Properties

    public var currency: String?
    public var customerId: String?
    public var customerEmail: String?
    public var anonymousId: String?
    public var country: String?
    public var inventoryMode: InventoryMode?
    public var taxMode: TaxMode?
    public var lineItems: [LineItemDraft]?
    public var customLineItems: [CustomLineItemDraft]?
    public var shippingAddress: Address?
    public var billingAddress: Address?
    public var shippingMethod: Reference<ShippingMethod>?
    public var externalTaxRateForShippingMethod: ExternalTaxRateDraft?
    public var custom: [String: Any]?
    public var locale: String?
    public var deleteDaysAfterLastModification: UInt?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        currency                          <- map["currency"]
        customerId                        <- map["customerId"]
        customerEmail                     <- map["customerEmail"]
        anonymousId                       <- map["anonymousId"]
        country                           <- map["country"]
        inventoryMode                     <- map["inventoryMode"]
        taxMode                           <- map["taxMode"]
        lineItems                         <- map["lineItems"]
        customLineItems                   <- map["customLineItems"]
        shippingAddress                   <- map["shippingAddress"]
        billingAddress                    <- map["billingAddress"]
        shippingMethod                    <- map["shippingMethod"]
        externalTaxRateForShippingMethod  <- map["externalTaxRateForShippingMethod"]
        custom                            <- map["custom"]
        locale                            <- map["locale"]
        deleteDaysAfterLastModification   <- map["deleteDaysAfterLastModification"]
    }

}

public enum CartState: String {

    case active = "Active"
    case merged = "Merged"
    case ordered = "Ordered"

}

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
    case changeTaxMode(options: ChangeTaxModeOptions)
    case setLocale(options: SetLocaleOptions)
    case setDeleteDaysAfterLastModification(options: SetDeleteDaysAfterLastModificationOptions)

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
        case .changeTaxMode(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "changeTaxMode"
            return optionsJSON
        case .setLocale(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setLocale"
            return optionsJSON
        case .setDeleteDaysAfterLastModification(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setDeleteDaysAfterLastModification"
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

public struct ChangeTaxModeOptions: Mappable {

    // MARK: - Properties

    public var taxMode: TaxMode?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        taxMode                     <- map["taxMode"]
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

public struct SetDeleteDaysAfterLastModificationOptions: Mappable {

    // MARK: - Properties

    public var deleteDaysAfterLastModification: UInt?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        deleteDaysAfterLastModification     <- map["deleteDaysAfterLastModification"]
    }
}

public struct Channel: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var key: String?
    public var roles: [ChannelRole]?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var address: Address?
    public var reviewRatingStatistics: ReviewRatingStatistics?
    public var custom: [String: Any]?
    public var geoLocation: [String: Any]?
    public var location: CLLocation? {
        if let coordinates = geoLocation?["coordinates"] as? [Double], let type = geoLocation?["type"] as? String,
           coordinates.count == 2 && type == "Point" {
            return CLLocation(latitude: coordinates[1], longitude: coordinates[0])
        }
        return nil
    }

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                      <- map["id"]
        version                 <- map["version"]
        createdAt               <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt          <- (map["lastModifiedAt"], ISO8601DateTransform())
        key                     <- map["key"]
        roles                   <- map["roles"]
        name                    <- map["name"]
        description             <- map["description"]
        address                 <- map["address"]
        reviewRatingStatistics  <- map["reviewRatingStatistics"]
        custom                  <- map["custom"]
        geoLocation             <- map["geoLocation"]
    }

}

public enum ChannelRole: String {

    case inventorySupply = "InventorySupply"
    case productDistribution = "ProductDistribution"
    case orderExport =  "OrderExport"
    case orderImport = "OrderImport"
    case primary = "Primary"

}

public struct CustomLineItem: Mappable {

    // MARK: - Properties

    public var id: String?
    public var name: LocalizedString?
    public var money: Money?
    public var taxedPrice: TaxedItemPrice?
    public var totalPrice: Money?
    public var slug: String?
    public var quantity: Int?
    public var state: ItemState?
    public var taxCategory: Reference<TaxCategory>?
    public var taxRate: TaxRate?
    public var discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]?
    public var custom: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                          <- map["id"]
        name                        <- map["name"]
        money                       <- map["money"]
        taxedPrice                  <- map["taxedPrice"]
        totalPrice                  <- map["totalPrice"]
        slug                        <- map["slug"]
        quantity                    <- map["quantity"]
        state                       <- map["state"]
        taxCategory                 <- map["taxCategory"]
        taxRate                     <- map["taxRate"]
        discountedPricePerQuantity  <- map["discountedPricePerQuantity"]
        custom                      <- map["custom"]
    }

}

public struct CustomLineItemDraft: Mappable {

    // MARK: - Properties

    public var name: LocalizedString?
    public var quantity: UInt?
    public var money: Money?
    public var slug: String?
    public var taxCategory: Reference<TaxCategory>?
    public var externalTaxRate: ExternalTaxRateDraft?
    public var custom: [String: Any]?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        name                      <- map["name"]
        quantity                  <- map["quantity"]
        money                     <- map["money"]
        slug                      <- map["slug"]
        taxCategory               <- map["taxCategory"]
        externalTaxRate           <- map["externalTaxRate"]
        custom                    <- map["custom"]
    }
}

public struct CustomerDraft: Mappable {

    // MARK: - Properties

    public var email: String?
    public var password: String?
    public var firstName: String?
    public var lastName: String?
    public var middleName: String?
    public var title: String?
    public var dateOfBirth: Date?
    public var companyName: String?
    public var vatId: String?
    public var addresses: [Address]?
    public var defaultBillingAddress: Int?
    public var defaultShippingAddress: Int?
    public var custom: [String: Any]?
    public var locale: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        email                     <- map["email"]
        password                  <- map["password"]
        firstName                 <- map["firstName"]
        lastName                  <- map["lastName"]
        middleName                <- map["middleName"]
        title                     <- map["title"]
        dateOfBirth               <- (map["dateOfBirth"], ISO8601DateTransform())
        companyName               <- map["companyName"]
        vatId                     <- map["vatId"]
        addresses                 <- map["addresses"]
        defaultBillingAddress     <- map["defaultBillingAddress"]
        defaultShippingAddress    <- map["defaultShippingAddress"]
        custom                    <- map["custom"]
        locale                    <- map["locale"]
    }
}

public struct CustomerGroup: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        name             <- map["name"]
    }

}

public struct CustomerSignInResult: Mappable {

    // MARK: - Properties

    public var customer: Customer?
    public var cart: Cart?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        customer         <- map["customer"]
        cart             <- map["cart"]
    }
}

public enum CustomerUpdateAction: JSONRepresentable {

    case changeEmail(options: ChangeEmailOptions)
    case setFirstName(options: SetFirstNameOptions)
    case setLastName(options: SetLastNameOptions)
    case setMiddleName(options: SetMiddleNameOptions)
    case setTitle(options: SetTitleOptions)
    case addAddress(options: AddAddressOptions)
    case changeAddress(options: ChangeAddressOptions)
    case removeAddress(options: RemoveAddressOptions)
    case setDefaultShippingAddress(options: SetDefaultShippingAddressOptions)
    case addShippingAddressId(options: AddressIdOptions)
    case removeShippingAddressId(options: AddressIdOptions)
    case setDefaultBillingAddress(options: SetDefaultBillingAddressOptions)
    case addBillingAddressId(options: AddressIdOptions)
    case removeBillingAddressId(options: AddressIdOptions)
    case setCompanyName(options: SetCompanyNameOptions)
    case setDateOfBirth(options: SetDateOfBirthOptions)
    case setVatId(options: SetVatIdOptions)
    case setCustomType(options: SetCustomTypeOptions)
    case setCustomField(options: SetCustomFieldOptions)
    case setLocale(options: SetLocaleOptions)

    public var toJSON: [String: Any] {
        switch self {
        case .changeEmail(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "changeEmail"
            return optionsJSON
        case .setFirstName(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setFirstName"
            return optionsJSON
        case .setLastName(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setLastName"
            return optionsJSON
        case .setMiddleName(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setMiddleName"
            return optionsJSON
        case .setTitle(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setTitle"
            return optionsJSON
        case .addAddress(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "addAddress"
            return optionsJSON
        case .changeAddress(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "changeAddress"
            return optionsJSON
        case .removeAddress(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "removeAddress"
            return optionsJSON
        case .setDefaultShippingAddress(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setDefaultShippingAddress"
            return optionsJSON
        case .addShippingAddressId(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "addShippingAddressId"
            return optionsJSON
        case .removeShippingAddressId(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "removeShippingAddressId"
            return optionsJSON
        case .setDefaultBillingAddress(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setDefaultBillingAddress"
            return optionsJSON
        case .addBillingAddressId(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "addBillingAddressId"
            return optionsJSON
        case .removeBillingAddressId(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "removeBillingAddressId"
            return optionsJSON
        case .setCompanyName(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setCompanyName"
            return optionsJSON
        case .setDateOfBirth(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setDateOfBirth"
            return optionsJSON
        case .setVatId(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setVatId"
            return optionsJSON
        case .setCustomType(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setCustomType"
            return optionsJSON
        case .setCustomField(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setCustomField"
            return optionsJSON
        case .setLocale(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setLocale"
            return optionsJSON
        }
    }
}

public struct ChangeEmailOptions: Mappable {

    // MARK: - Properties

    public var email: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        email                        <- map["email"]
    }
}

public struct SetFirstNameOptions: Mappable {

    // MARK: - Properties

    public var firstName: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        firstName                   <- map["firstName"]
    }
}

public struct SetLastNameOptions: Mappable {

    // MARK: - Properties

    public var lastName: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        lastName                    <- map["lastName"]
    }
}

public struct SetMiddleNameOptions: Mappable {

    // MARK: - Properties

    public var middleName: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        middleName                  <- map["middleName"]
    }
}

public struct SetTitleOptions: Mappable {

    // MARK: - Properties

    public var title: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        title                      <- map["title"]
    }
}

public struct AddAddressOptions: Mappable {

    // MARK: - Properties

    public var address: Address?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        address                     <- map["address"]
    }
}

public struct ChangeAddressOptions: Mappable {

    // MARK: - Properties

    public var addressId: String?
    public var address: Address?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        addressId                   <- map["addressId"]
        address                     <- map["address"]
    }
}

public struct RemoveAddressOptions: Mappable {

    // MARK: - Properties

    public var addressId: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        addressId                   <- map["addressId"]
    }
}

public struct SetDefaultShippingAddressOptions: Mappable {

    // MARK: - Properties

    public var addressId: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        addressId                   <- map["addressId"]
    }
}

public struct AddressIdOptions: Mappable {

    // MARK: - Properties

    public var addressId: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        addressId                   <- map["addressId"]
    }
}

public struct SetDefaultBillingAddressOptions: Mappable {

    // MARK: - Properties

    public var addressId: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        addressId                   <- map["addressId"]
    }
}

public struct SetCompanyNameOptions: Mappable {

    // MARK: - Properties

    public var companyName: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        companyName                <- map["companyName"]
    }
}

public struct SetDateOfBirthOptions: Mappable {

    // MARK: - Properties

    public var dateOfBirth: Date?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        dateOfBirth                <- (map["dateOfBirth"], ISO8601DateTransform())
    }
}

public struct SetVatIdOptions: Mappable {

    // MARK: - Properties

    public var vatId: Date?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        vatId                      <- map["vatId"]
    }
}

public struct Delivery: Mappable {

    // MARK: - Properties

    public var id: String?
    public var createdAt: Date?
    public var items: [DeliveryItem]?
    public var parcels: [Parcel]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        items             <- map["items"]
        parcels           <- map["parcels"]
    }

}

public struct DeliveryItem: Mappable {

    // MARK: - Properties

    public var id: String?
    public var quantity: Int?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        quantity          <- map["quantity"]
    }

}

public struct DiscountCode: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var code: String?
    public var cartDiscounts: [CartDiscount]?
    public var cartPredicate: String?
    public var isActive: Bool?
    public var references: [GenericReference]?
    public var maxApplications: Int?
    public var maxApplicationsPerCustomer: Int?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                           <- map["id"]
        version                      <- map["version"]
        createdAt                    <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt               <- (map["lastModifiedAt"], ISO8601DateTransform())
        name                         <- map["name"]
        description                  <- map["description"]
        code                         <- map["code"]
        cartDiscounts                <- map["cartDiscounts"]
        cartPredicate                <- map["cartPredicate"]
        isActive                     <- map["isActive"]
        references                   <- map["references"]
        maxApplications              <- map["maxApplications"]
        maxApplicationsPerCustomer   <- map["maxApplicationsPerCustomer"]
    }

}

public struct DiscountCodeInfo: Mappable {

    // MARK: - Properties

    public var discountCode: Reference<DiscountCode>?
    public var state: DiscountCodeState?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        discountCode           <- map["discountCode"]
        state                  <- map["state"]
    }

}

public enum DiscountCodeState: String {

    case notActive = "NotActive"
    case doesNotMatchCart = "DoesNotMatchCart"
    case matchesCart = "MatchesCart"
    case maxApplicationReached = "MaxApplicationReached"

}

public struct DiscountedLineItemPortion: Mappable {

    // MARK: - Properties

    public var discount: Reference<CartDiscount>?
    public var discountedAmount: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        discount          <- map["discount"]
        discountedAmount  <- map["discountedAmount"]
    }

}

public struct DiscountedLineItemPrice: Mappable {

    // MARK: - Properties

    public var value: Money?
    public var includedDiscounts: [DiscountedLineItemPortion]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        value             <- map["value"]
        includedDiscounts <- map["includedDiscounts"]
    }

}

public struct DiscountedLineItemPriceForQuantity: Mappable {

    // MARK: - Properties

    public var quantity: Int?
    public var discountedPrice: DiscountedLineItemPrice?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        quantity         <- map["quantity"]
        discountedPrice  <- map["discountedPrice"]
    }

}

public struct DiscountedPrice: Mappable {

    // MARK: - Properties

    public var value: Money?
    public var discount: Reference<ProductDiscount>?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        value              <- map["value"]
        discount           <- map["discount"]
    }
}

public struct ExternalLineItemTotalPrice: Mappable {

    // MARK: - Properties

    public var price: Money?
    public var totalPrice: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        price              <- map["price"]
        totalPrice         <- map["totalPrice"]
    }
}

public struct ExternalTaxRateDraft: Mappable {

    // MARK: - Properties

    public var name: String?
    public var amount: Double?
    public var country: String?
    public var state: String?
    public var subRates: [SubRate]?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        name                   <- map["name"]
        amount                 <- map["amount"]
        country                <- map["country"]
        state                  <- map["state"]
        subRates               <- map["subRates"]
    }
}

public struct Image: Mappable {

    // MARK: - Properties

    public var url: String?
    public var dimensions: [String: Int]?
    public var label: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        url                <- map["url"]
        dimensions         <- map["dimensions"]
        label              <- map["label"]
    }

}

public enum InventoryMode: String {

    case trackOnly = "TrackOnly"
    case reserveOnOrder = "ReserveOnOrder"
    case none = "None"

}

public struct ItemState: Mappable {

    // MARK: - Properties

    public var quantity: Int?
    public var state: Reference<State>?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        quantity                <- map["quantity"]
        state                   <- map["state"]
    }

}

public typealias LocalizedString = [String: String]

public struct LineItem: Mappable {

    // MARK: - Properties

    public var id: String?
    public var productId: String?
    public var name: LocalizedString?
    public var productSlug: LocalizedString?
    public var productType: Reference<ProductType>?
    public var variant: ProductVariant?
    public var price: Price?
    public var taxedPrice: TaxedItemPrice?
    public var totalPrice: Money?
    public var quantity: Int?
    public var state: [ItemState]?
    public var taxRate: TaxRate?
    public var supplyChannel: Reference<Channel>?
    public var distributionChannel: Reference<Channel>?
    public var discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]?
    public var priceMode: LineItemPriceMode?
    public var custom: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                         <- map["id"]
        productId                  <- map["productId"]
        name                       <- map["name"]
        productSlug                <- map["productSlug"]
        productType                <- map["productType"]
        variant                    <- map["variant"]
        price                      <- map["price"]
        totalPrice                 <- map["totalPrice"]
        discountedPricePerQuantity <- map["discountedPricePerQuantity"]
        quantity                   <- map["quantity"]
        distributionChannel        <- map["distributionChannel"]
    }

}

public struct LineItemDraft: Mappable {

    // MARK: - Properties

    public var productId: String?
    public var variantId: Int?
    public var quantity: UInt?
    public var supplyChannel: Reference<Channel>?
    public var distributionChannel: Reference<Channel>?
    public var externalTaxRate: ExternalTaxRateDraft?
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
        externalTaxRate              <- map["externalTaxRate"]
        custom                       <- map["custom"]
    }
}

public enum LineItemPriceMode: String {

    case platform = "Platform"
    case externalTotal = "ExternalTotal"

}

public struct Location: Mappable {

    // MARK: - Properties

    public var country: String?
    public var state: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        country           <- map["country"]
        state             <- map["state"]
    }

}

public struct Money: Mappable {

    // MARK: - Properties

    public var currencyCode: String?
    public var centAmount: Int?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        currencyCode       <- map["currencyCode"]
        centAmount         <- map["centAmount"]
    }
}

public struct OrderDraft: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                          <- map["id"]
        version                     <- map["version"]
    }
}

public enum OrderState: String {

    case `open` = "Open"
    case confirmed = "Confirmed"
    case complete = "Complete"
    case cancelled = "Cancelled"

}

public struct Parcel: Mappable {

    // MARK: - Properties

    public var id: String?
    public var createdAt: Date?
    public var measurements: ParcelMeasurements?
    public var trackingData: TrackingData?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        measurements      <- map["measurements"]
        trackingData      <- map["trackingData"]
    }

}

public struct ParcelMeasurements: Mappable {

    // MARK: - Properties

    public var heightInMillimeter: Double?
    public var lengthInMillimeter: Double?
    public var widthInMillimeter: Double?
    public var weightInGram: Double?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        heightInMillimeter   <- map["heightInMillimeter"]
        lengthInMillimeter   <- map["lengthInMillimeter"]
        widthInMillimeter    <- map["widthInMillimeter"]
        weightInGram         <- map["weightInGram"]
    }

}

public struct Payment: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var customer: Reference<Customer>?
    public var externalId: String?
    public var interfaceId: String?
    public var amountPlanned: Money?
    public var amountAuthorized: Money?
    public var authorizedUntil: String?
    public var amountPaid: Money?
    public var amountRefunded: Money?
    public var paymentMethodInfo: PaymentMethodInfo?
    public var paymentStatus: PaymentStatus?
    public var transactions: [Transaction]?
    public var interfaceInteractions: [[String: Any]]?
    public var custom: [String: Any]?
    public var createdAt: Date?
    public var lastModifiedAt: Date?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                    <- map["id"]
        version               <- map["version"]
        customer              <- map["customer"]
        externalId            <- map["externalId"]
        interfaceId           <- map["interfaceId"]
        amountPlanned         <- map["amountPlanned"]
        amountAuthorized      <- map["amountAuthorized"]
        authorizedUntil       <- map["authorizedUntil"]
        amountPaid            <- map["amountPaid"]
        amountRefunded        <- map["amountRefunded"]
        paymentMethodInfo     <- map["paymentMethodInfo"]
        paymentStatus         <- map["paymentStatus"]
        transactions          <- map["transactions"]
        interfaceInteractions <- map["interfaceInteractions"]
        custom                <- map["custom"]
        createdAt             <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt        <- (map["lastModifiedAt"], ISO8601DateTransform())
    }

}

public struct PaymentInfo: Mappable {

    // MARK: - Properties

    public var payments: [Reference<Payment>]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        payments           <- map["payments"]
    }

}

public struct PaymentMethodInfo: Mappable {

    // MARK: - Properties

    public var paymentInterface: String?
    public var method: String?
    public var name: LocalizedString?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        paymentInterface      <- map["paymentInterface"]
        method                <- map["method"]
        name                  <- map["name"]
    }

}

public enum PaymentState: String {

    case balanceDue = "BalanceDue"
    case failed = "Failed"
    case pending = "Pending"
    case creditOwed = "CreditOwed"
    case paid = "Paid"

}

public struct PaymentStatus: Mappable {

    // MARK: - Properties

    public var interfaceCode: String?
    public var interfaceText: String?
    public var state: Reference<State>?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        interfaceCode      <- map["interfaceCode"]
        interfaceText      <- map["interfaceText"]
        state              <- map["state"]
    }

}

public struct Price: Mappable {

    // MARK: - Properties

    public var value: Money?
    public var country: String?
    public var customerGroup: Reference<CustomerGroup>?
    public var channel: Reference<Channel>?
    public var validFrom: Date?
    public var validUntil: Date?
    public var discounted: DiscountedPrice?
    public var custom: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        value              <- map["value"]
        country            <- map["country"]
        customerGroup      <- map["customerGroup"]
        channel            <- map["channel"]
        validFrom          <- (map["validFrom"], ISO8601DateTransform())
        validUntil         <- (map["validUntil"], ISO8601DateTransform())
        discounted         <- map["discounted"]
        custom             <- map["custom"]
    }
}

public struct ProductDiscount: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var value: ProductDiscountValue?
    public var predicate: String?
    public var sortOrder: String?
    public var isActive: Bool?
    public var references: [GenericReference]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        version           <- map["version"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt    <- (map["lastModifiedAt"], ISO8601DateTransform())
        name              <- map["name"]
        description       <- map["description"]
        value             <- map["value"]
        predicate         <- map["predicate"]
        sortOrder         <- map["sortOrder"]
        isActive          <- map["isActive"]
        references        <- map["references"]
    }
}

public struct ProductDiscountValue: Mappable {

    // MARK: - Properties

    public var type: String?
    public var permyriad: Int?
    public var money: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type            <- map["type"]
        permyriad       <- map["permyriad"]
        money           <- map["money"]
    }
}

public struct ProductVariant: Mappable {

    // MARK: - Properties

    public var id: Int?
    public var sku: String?
    public var key: String?
    public var prices: [Price]?
    public var attributes: [Attribute]?
    public var price: Price?
    public var images: [Image]?
    public var assets: [Asset]?
    public var availability: ProductVariantAvailability?
    public var isMatchingVariant: Bool?
    public var scopedPrice: ScopedPrice?
    public var scopedPriceDiscounted: Bool?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                     <- map["id"]
        sku                    <- map["sku"]
        key                    <- map["key"]
        prices                 <- map["prices"]
        attributes             <- map["attributes"]
        price                  <- map["price"]
        images                 <- map["images"]
        assets                 <- map["assets"]
        availability           <- map["availability"]
        isMatchingVariant      <- map["isMatchingVariant"]
        scopedPrice            <- map["scopedPrice"]
        scopedPriceDiscounted  <- map["scopedPriceDiscounted"]
    }
}

public struct ProductVariantAvailability: Mappable {

    // MARK: - Properties

    public var isOnStock: Bool?
    public var restockableInDays: Int?
    public var availableQuantity: Int?
    public var channels: [String: ProductVariantAvailability]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        isOnStock                <- map["isOnStock"]
        restockableInDays        <- map["restockableInDays"]
        availableQuantity        <- map["availableQuantity"]
        channels                 <- map["channels"]
    }
}

public struct Reference<T: Mappable>: Mappable {

    // MARK: - Properties

    public var id: String?
    public var typeId: String?
    public var obj: T?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id              <- map["id"]
        typeId          <- map["typeId"]
        obj             <- map["obj"]
    }
}

public struct GenericReference: Mappable {

    // MARK: - Properties

    public var id: String?
    public var typeId: String?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id              <- map["id"]
        typeId          <- map["typeId"]
    }
}

public struct ResourceIdentifier: Mappable {

    // MARK: - Properties

    public var id: String?
    public var typeId: String?
    public var key: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                 <- map["id"]
        typeId             <- map["typeId"]
        key                <- map["key"]
    }
}

public struct ReturnInfo: Mappable {

    // MARK: - Properties

    public var items: [ReturnItem]?
    public var returnTrackingId: String?
    public var returnDate: Date?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        items              <- map["items"]
        returnTrackingId   <- map["returnTrackingId"]
        returnDate         <- (map["returnDate"], ISO8601DateTransform())
    }
}

public struct ReturnItem: Mappable {

    // MARK: - Properties

    public var id: String?
    public var quantity: UInt?
    public var lineItemId: String?
    public var comment: String?
    public var shipmentState: ReturnShipmentState?
    public var paymentState: ReturnPaymentState?
    public var lastModifiedAt: Date?
    public var createdAt: Date?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id             <- map["id"]
        quantity       <- map["quantity"]
        lineItemId     <- map["lineItemId"]
        comment        <- map["comment"]
        shipmentState  <- map["shipmentState"]
        paymentState   <- map["paymentState"]
        lastModifiedAt <- (map["lastModifiedAt"], ISO8601DateTransform())
        createdAt      <- (map["createdAt"], ISO8601DateTransform())
    }
}

public enum ReturnPaymentState: String {

    case nonRefundable = "NonRefundable"
    case initial = "Initial"
    case refunded = "Refunded"
    case notRefunded = "NotRefunded"

}
public enum ReturnShipmentState: String {

    case advised = "Advised"
    case returned = "Returned"
    case backInStock = "BackInStock"
    case unusable = "Unusable"

}
public struct ReviewRatingStatistics: Mappable {

    // MARK: - Properties

    public var averageRating: Double?
    public var highestRating: Double?
    public var lowestRating: Double?
    public var count: UInt?
    public var ratingsDistribution: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        averageRating        <- map["averageRating"]
        highestRating        <- map["highestRating"]
        lowestRating         <- map["lowestRating"]
        count                <- map["count"]
        ratingsDistribution  <- map["ratingsDistribution"]
    }
}

public struct ScopedPrice: Mappable {

    // MARK: - Properties

    public var id: String?
    public var value: Money?
    public var currentValue: Money?
    public var country: String?
    public var customerGroup: Reference<CustomerGroup>?
    public var channel: Reference<Channel>?
    public var validFrom: Date?
    public var validUntil: Date?
    public var discounted: DiscountedPrice?
    public var custom: [String: Any]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                   <- map["id"]
        value                <- map["value"]
        currentValue         <- map["currentValue"]
        country              <- map["country"]
        customerGroup        <- map["customerGroup"]
        channel              <- map["channel"]
        validFrom            <- map["validFrom"]
        validUntil           <- map["validUntil"]
        discounted           <- map["discounted"]
        custom               <- map["custom"]
    }
}

public struct SearchKeyword: Mappable {

    // MARK: - Properties

    public var text: String?
    public var suggestTokenizer: SuggestTokenizer?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        text                  <- map["text"]
        suggestTokenizer      <- map["suggestTokenizer"]
    }
}

public struct SuggestTokenizer: Mappable {

    // MARK: - Properties

    public var type: String?
    public var inputs: [String]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        type                  <- map["type"]
        inputs                <- map["inputs"]
    }
}

public enum ShipmentState: String {

    case shipped = "Shipped"
    case ready = "Ready"
    case pending = "Pending"
    case delayed = "Delayed"
    case partial = "Partial"
    case backorder = "Backorder"

}


public struct ShippingInfo: Mappable {

    // MARK: - Properties

    public var shippingMethodName: String?
    public var price: Money?
    public var shippingRate: ShippingRate?
    public var taxedPrice: TaxedItemPrice?
    public var taxRate: TaxRate?
    public var taxCategory: Reference<TaxCategory>?
    public var shippingMethod: Reference<ShippingMethod>?
    public var deliveries: [Delivery]?
    public var discountedPrice: DiscountedLineItemPrice?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        shippingMethodName         <- map["shippingMethodName"]
        price                      <- map["price"]
        shippingRate               <- map["shippingRate"]
        taxedPrice                 <- map["taxedPrice"]
        taxRate                    <- map["taxRate"]
        taxCategory                <- map["taxCategory"]
        shippingMethod             <- map["shippingMethod"]
        deliveries                 <- map["deliveries"]
        discountedPrice            <- map["discountedPrice"]
    }

}

public struct ShippingMethod: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: String?
    public var description: String?
    public var taxCategory: Reference<TaxCategory>?
    public var zoneRates: [ZoneRate]?
    public var isDefault: Bool?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        name             <- map["name"]
        description      <- map["description"]
        taxCategory      <- map["taxCategory"]
        zoneRates        <- map["zoneRates"]
        isDefault        <- map["isDefault"]
    }

}

public struct ShippingRate: Mappable {

    // MARK: - Properties

    public var price: Money?
    public var freeAbove: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        price             <- map["price"]
        freeAbove         <- map["freeAbove"]
    }

}

public struct State: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var key: String?
    public var type: StateType?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var initial: Bool?
    public var builtIn: Bool?
    public var roles: [StateRole]?
    public var transitions: [Reference<State>]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        version           <- map["version"]
        createdAt         <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt    <- (map["lastModifiedAt"], ISO8601DateTransform())
        key               <- map["key"]
        type              <- map["type"]
        name              <- map["name"]
        description       <- map["description"]
        initial           <- map["initial"]
        builtIn           <- map["builtIn"]
        roles             <- map["roles"]
        transitions       <- map["transitions"]
    }

}

public enum StateRole: String {

    case reviewIncludedInStatistics = "ReviewIncludedInStatistics"

}

public enum StateType: String {

    case orderState = "OrderState"
    case lineItemState = "LineItemState"
    case productState =  "ProductState"
    case reviewState = "ReviewState"
    case paymentState = "PaymentState"

}

public struct SubRate: Mappable {

    // MARK: - Properties

    public var name: String?
    public var amount: Double?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        name       <- map["name"]
        amount     <- map["amount"]
    }

}

public struct SyncInfo: Mappable {

    // MARK: - Properties

    public var channel: Reference<Channel>?
    public var externalId: String?
    public var syncedAt: Date?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        channel          <- map["channel"]
        externalId       <- map["externalId"]
        syncedAt         <- (map["syncedAt"], ISO8601DateTransform())
    }
}

public struct TaxCategory: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: String?
    public var description: String?
    public var rates: [TaxRate]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        name             <- map["name"]
        description      <- map["description"]
        rates            <- map["rates"]
    }

}

public enum TaxMode: String {

    case platform = "Platform"
    case external = "External"
    case disabled = "Disabled"

}

public enum RoundingMode: String {

    case halfEven = "HalfEven"
    case halfUp = "HalfUp"
    case halfDown = "HalfDown"

}

public struct TaxRate: Mappable {

    // MARK: - Properties

    public var id: String?
    public var name: String?
    public var includedInPrice: Bool?
    public var country: String?
    public var state: String?
    public var subRates: [SubRate]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                <- map["id"]
        name              <- map["name"]
        includedInPrice   <- map["includedInPrice"]
        country           <- map["country"]
        state             <- map["state"]
        subRates          <- map["subRates"]
    }

}

public struct TaxedItemPrice: Mappable {

    // MARK: - Properties

    public var totalNet: Money?
    public var totalGross: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        totalNet                <- map["totalNet"]
        totalGross              <- map["totalGross"]
    }

}

public struct TaxedPrice: Mappable {

    // MARK: - Properties

    public var totalNet: Money?
    public var totalGross: Money?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        totalNet         <- map["totalNet"]
        totalGross       <- map["totalGross"]
    }

}

public struct TrackingData: Mappable {

    // MARK: - Properties

    public var trackingId: String?
    public var carrier: String?
    public var provider: String?
    public var providerTransaction: String?
    public var isReturn: Bool?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        trackingId           <- map["trackingId"]
        carrier              <- map["carrier"]
        provider             <- map["provider"]
        providerTransaction  <- map["providerTransaction"]
        isReturn             <- map["isReturn"]
    }

}

public struct Transaction: Mappable {

    // MARK: - Properties

    public var id: String?
    public var timestamp: Date?
    public var type: TransactionType?
    public var amount: Money?
    public var interactionId: String?
    public var state: TransactionState?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                    <- map["id"]
        timestamp             <- map["timestamp"]
        type                  <- map["type"]
        amount                <- map["amount"]
        interactionId         <- map["interactionId"]
        state                 <- map["state"]
    }

}

public enum TransactionState: String {

    case pending = "Pending"
    case success = "Success"
    case failure = "Failure"

}

public enum TransactionType: String {

    case authorization = "Authorization"
    case cancelAuthorization = "CancelAuthorization"
    case charge =  "Charge"
    case refund = "Refund"
    case chargeback = "Chargeback"

}

public struct Zone: Mappable {

    // MARK: - Properties

    public var id: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var name: String?
    public var description: String?
    public var locations: [Location]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id               <- map["id"]
        version          <- map["version"]
        createdAt        <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt   <- (map["lastModifiedAt"], ISO8601DateTransform())
        name             <- map["name"]
        description      <- map["description"]
        locations        <- map["locations"]
    }

}

public struct ZoneRate: Mappable {

    // MARK: - Properties

    public var zone: Reference<Zone>?
    public var shippingRates: [ShippingRate]?

    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        zone              <- map["zone"]
        shippingRates     <- map["shippingRates"]
    }

}