//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper
import CoreLocation

public struct Address: ImmutableMappable {

    // MARK: - Properties

    public let id: String?
    public let title: String?
    public let salutation: String?
    public let firstName: String?
    public let lastName: String?
    public let streetName: String?
    public let streetNumber: String?
    public let city: String?
    public let region: String?
    public let postalCode: String?
    public let additionalStreetInfo: String?
    public let state: String?
    public let country: String
    public let company: String?
    public let department: String?
    public let building: String?
    public let apartment: String?
    public let pOBox: String?
    public let phone: String?
    public let mobile: String?
    public let email: String?
    public let fax: String?
    public let additionalAddressInfo: String?
    public let externalId: String?
    
    public init(id: String? = nil, title: String? = nil, salutation: String? = nil, firstName: String? = nil, lastName: String? = nil, streetName: String? = nil, streetNumber: String? = nil, city: String? = nil, region: String? = nil, postalCode: String? = nil, additionalStreetInfo: String? = nil, state: String? = nil, country: String, company: String? = nil, department: String? = nil, building: String? = nil, apartment: String? = nil, pOBox: String? = nil, phone: String? = nil, mobile: String? = nil, email: String? = nil, fax: String? = nil, additionalAddressInfo: String? = nil, externalId: String? = nil) {
        self.id = id
        self.title = title
        self.salutation = salutation
        self.firstName = firstName
        self.lastName = lastName
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.city = city
        self.region = region
        self.postalCode = postalCode
        self.additionalStreetInfo = additionalStreetInfo
        self.state = state
        self.country = country
        self.company = company
        self.department = department
        self.building = building
        self.apartment = apartment
        self.pOBox = pOBox
        self.phone = phone
        self.mobile = mobile
        self.email = email
        self.fax = fax
        self.additionalAddressInfo = additionalAddressInfo
        self.externalId = externalId
    }
    
    public init(map: Map) throws {
        id                      = try? map.value("id")
        title                   = try? map.value("title")
        salutation              = try? map.value("salutation")
        firstName               = try? map.value("firstName")
        lastName                = try? map.value("lastName")
        city                    = try? map.value("city")
        region                  = try? map.value("region")
        postalCode              = try? map.value("postalCode")
        streetName              = try? map.value("streetName")
        additionalStreetInfo    = try? map.value("additionalStreetInfo")
        streetNumber            = try? map.value("streetNumber")
        state                   = try? map.value("state")
        country                 = try map.value("country")
        company                 = try? map.value("company")
        department              = try? map.value("department")
        building                = try? map.value("building")
        apartment               = try? map.value("apartment")
        pOBox                   = try? map.value("pOBox")
        phone                   = try? map.value("phone")
        mobile                  = try? map.value("mobile")
        email                   = try? map.value("email")
        fax                     = try? map.value("fax")
        additionalAddressInfo   = try? map.value("additionalAddressInfo")
        externalId              = try? map.value("externalId")
    }

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        id                      >>> map["id"]
        title                   >>> map["title"]
        salutation              >>> map["salutation"]
        firstName               >>> map["firstName"]
        lastName                >>> map["lastName"]
        city                    >>> map["city"]
        region                  >>> map["region"]
        postalCode              >>> map["postalCode"]
        streetName              >>> map["streetName"]
        additionalStreetInfo    >>> map["additionalStreetInfo"]
        streetNumber            >>> map["streetNumber"]
        state                   >>> map["state"]
        country                 >>> map["country"]
        company                 >>> map["company"]
        department              >>> map["department"]
        building                >>> map["building"]
        apartment               >>> map["apartment"]
        pOBox                   >>> map["pOBox"]
        phone                   >>> map["phone"]
        mobile                  >>> map["mobile"]
        email                   >>> map["email"]
        fax                     >>> map["fax"]
        additionalAddressInfo   >>> map["additionalAddressInfo"]
        externalId              >>> map["externalId"]
    }
}

public enum AnonymousCartSignInMode: String {

    case mergeWithExistingCustomerCart = "MergeWithExistingCustomerCart"
    case useAsNewActiveCustomerCart = "UseAsNewActiveCustomerCart"

}

public struct Asset: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let sources: [AssetSource]
    public let name: LocalizedString
    public let description: LocalizedString?
    public let tags: [String]?
    public let custom: [String: Any]?

    public init(map: Map) throws {
        id               = try map.value("id")
        sources          = try map.value("sources")
        name             = try map.value("name")
        description      = try? map.value("description")
        tags             = try? map.value("tags")
        custom           = try? map.value("custom")
    }
}

public struct AssetSource: ImmutableMappable {

    // MARK: - Properties

    public let uri: String
    public let key: String
    public let dimensions: [AssetDimensions]?
    public let contentType: String?

    public init(map: Map) throws {
        uri              = try map.value("uri")
        key              = try map.value("key")
        dimensions       = try? map.value("dimensions")
        contentType      = try? map.value("contentType")
    }
}

public struct AssetDimensions: ImmutableMappable {

    // MARK: - Properties

    public let w: Double
    public let h: Double

    public init(map: Map) throws {
        w              = try map.value("w")
        h              = try map.value("h")
    }
}

public struct Attribute: ImmutableMappable {

    // MARK: - Properties

    public let name: String
    public let value: AnyObject

    public init(map: Map) throws {
        name               = try map.value("name")
        value              = try map.value("value")
    }
}

public struct AttributeDefinition: ImmutableMappable {

    // MARK: - Properties

    public let type: AttributeType
    public let name: String
    public let label: [String: String]
    public let inputTip: [String: String]?
    public let isRequired: Bool
    public let isSearchable: Bool

    public init(map: Map) throws {
        type               = try map.value("type")
        name               = try map.value("name")
        label              = try map.value("label")
        inputTip           = try? map.value("inputTip")
        isRequired         = try map.value("isRequired")
        isSearchable       = try map.value("isSearchable")
    }
}

public class AttributeType: ImmutableMappable {

    // MARK: - Properties

    public let name: String
    public let elementType: AttributeType?

    required public init(map: Map) throws {
        name               = try map.value("name")
        elementType        = try? map.value("elementType")
    }
}

public struct CartDiscount: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: LocalizedString
    public let description: LocalizedString?
    public let value: CartDiscountValue
    public let cartPredicate: String
    public let target: CartDiscountTarget
    public let sortOrder: String
    public let isActive: Bool
    public let validFrom: Date?
    public let validUntil: Date?
    public let requiresDiscountCode: Bool
    public let references: [GenericReference]

    public init(map: Map) throws {
        id                    = try map.value("id")
        version               = try map.value("version")
        createdAt             = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt        = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        name                  = try map.value("name")
        description           = try? map.value("description")
        value                 = try map.value("value")
        cartPredicate         = try map.value("cartPredicate")
        target                = try map.value("target")
        sortOrder             = try map.value("sortOrder")
        isActive              = try map.value("isActive")
        validFrom             = try? map.value("validFrom", using: ISO8601DateTransform())
        validUntil            = try? map.value("validUntil", using: ISO8601DateTransform())
        requiresDiscountCode  = try map.value("requiresDiscountCode")
        references            = try map.value("references")
    }
}

public struct CartDiscountTarget: ImmutableMappable {

    // MARK: - Properties

    public let type: String
    public let predicate: String?

    public init(map: Map) throws {
        type          = try map.value("type")
        predicate     = try? map.value("predicate")
    }
}

public struct CartDiscountValue: ImmutableMappable {

    // MARK: - Properties

    public let type: String
    public let permyriad: Int?
    public let money: Money?

    public init(map: Map) throws {
        type          = try map.value("type")
        permyriad     = try? map.value("permyriad")
        money         = try? map.value("money")
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

public struct Channel: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let key: String
    public let roles: [ChannelRole]
    public let name: LocalizedString?
    public let description: LocalizedString?
    public let address: Address?
    public let reviewRatingStatistics: ReviewRatingStatistics?
    public let custom: [String: Any]?
    public let geoLocation: [String: Any]?
    public var location: CLLocation? {
        if let coordinates = geoLocation?["coordinates"] as? [Double], let type = geoLocation?["type"] as? String,
           coordinates.count == 2 && type == "Point" {
            return CLLocation(latitude: coordinates[1], longitude: coordinates[0])
        }
        return nil
    }

    public init(map: Map) throws {
        id                      = try map.value("id")
        version                 = try map.value("version")
        createdAt               = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt          = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        key                     = try map.value("key")
        roles                   = try map.value("roles")
        name                    = try? map.value("name")
        description             = try? map.value("description")
        address                 = try? map.value("address")
        reviewRatingStatistics  = try? map.value("reviewRatingStatistics")
        custom                  = try? map.value("custom")
        geoLocation             = try? map.value("geoLocation")
    }
}

public enum ChannelRole: String {

    case inventorySupply = "InventorySupply"
    case productDistribution = "ProductDistribution"
    case orderExport =  "OrderExport"
    case orderImport = "OrderImport"
    case primary = "Primary"

}

public struct CustomLineItem: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let name: LocalizedString
    public let money: Money
    public let taxedPrice: TaxedItemPrice?
    public let totalPrice: Money
    public let slug: String
    public let quantity: Int
    public let state: ItemState
    public let taxCategory: Reference<TaxCategory>?
    public let taxRate: TaxRate?
    public let discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]
    public let custom: [String: Any]?

    public init(map: Map) throws {
        id                          = try map.value("id")
        name                        = try map.value("name")
        money                       = try map.value("money")
        taxedPrice                  = try? map.value("taxedPrice")
        totalPrice                  = try map.value("totalPrice")
        slug                        = try map.value("slug")
        quantity                    = try map.value("quantity")
        state                       = try map.value("state")
        taxCategory                 = try? map.value("taxCategory")
        taxRate                     = try? map.value("taxRate")
        discountedPricePerQuantity  = try map.value("discountedPricePerQuantity")
        custom                      = try? map.value("custom")
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

public struct CustomerGroup: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: String

    public init(map: Map) throws {
        id               = try map.value("id")
        version          = try map.value("version")
        createdAt        = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt   = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        name             = try map.value("name")
    }
}

public struct CustomerSignInResult: ImmutableMappable {

    // MARK: - Properties

    public let customer: Customer
    public let cart: Cart?

    public init(map: Map) throws {
        customer         = try map.value("customer")
        cart             = try? map.value("cart")
    }
}

public enum CustomerUpdateAction: JSONRepresentable {

    case changeEmail(options: ChangeEmailOptions)
    case setFirstName(options: SetFirstNameOptions)
    case setLastName(options: SetLastNameOptions)
    case setMiddleName(options: SetMiddleNameOptions)
    case setTitle(options: SetTitleOptions)
    case setSalutation(options: SetSalutationOptions)
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
        case .setSalutation(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setSalutation"
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

public struct SetSalutationOptions: Mappable {

    // MARK: - Properties

    public var salutation: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        salutation                 <- map["salutation"]
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

public struct Delivery: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let createdAt: Date
    public let items: [DeliveryItem]
    public let parcels: [Parcel]

    public init(map: Map) throws {
        id                = try map.value("id")
        createdAt         = try map.value("createdAt", using: ISO8601DateTransform())
        items             = try map.value("items")
        parcels           = try map.value("parcels")
    }
}

public struct DeliveryItem: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let quantity: Int

    public init(map: Map) throws {
        id                = try map.value("id")
        quantity          = try map.value("quantity")
    }
}

public struct DiscountCode: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: LocalizedString?
    public let description: LocalizedString?
    public let code: String
    public let cartDiscounts: [CartDiscount]
    public let cartPredicate: String?
    public let isActive: Bool
    public let references: [GenericReference]
    public let maxApplications: Int?
    public let maxApplicationsPerCustomer: Int?

    public init(map: Map) throws {
        id                           = try map.value("id")
        version                      = try map.value("version")
        createdAt                    = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt               = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        name                         = try? map.value("name")
        description                  = try? map.value("description")
        code                         = try map.value("code")
        cartDiscounts                = try map.value("cartDiscounts")
        cartPredicate                = try? map.value("cartPredicate")
        isActive                     = try map.value("isActive")
        references                   = try map.value("references")
        maxApplications              = try? map.value("maxApplications")
        maxApplicationsPerCustomer   = try? map.value("maxApplicationsPerCustomer")
    }
}

public struct DiscountCodeInfo: ImmutableMappable {

    // MARK: - Properties

    public let discountCode: Reference<DiscountCode>
    public let state: DiscountCodeState?

    public init(map: Map) throws {
        discountCode           = try map.value("discountCode")
        state                  = try? map.value("state")
    }
}

public enum DiscountCodeState: String {

    case notActive = "NotActive"
    case doesNotMatchCart = "DoesNotMatchCart"
    case matchesCart = "MatchesCart"
    case maxApplicationReached = "MaxApplicationReached"

}

public struct DiscountedLineItemPortion: ImmutableMappable {

    // MARK: - Properties

    public let discount: Reference<CartDiscount>
    public let discountedAmount: Money

    public init(map: Map) throws {
        discount          = try map.value("discount")
        discountedAmount  = try map.value("discountedAmount")
    }
}

public struct DiscountedLineItemPrice: ImmutableMappable {

    // MARK: - Properties

    public let value: Money
    public let includedDiscounts: [DiscountedLineItemPortion]

    public init(map: Map) throws {
        value             = try map.value("value")
        includedDiscounts = try map.value("includedDiscounts")
    }
}

public struct DiscountedLineItemPriceForQuantity: ImmutableMappable {

    // MARK: - Properties

    public let quantity: Int
    public let discountedPrice: DiscountedLineItemPrice

    public init(map: Map) throws {
        quantity         = try map.value("quantity")
        discountedPrice  = try map.value("discountedPrice")
    }
}

public struct DiscountedPrice: ImmutableMappable {

    // MARK: - Properties

    public let value: Money
    public let discount: Reference<ProductDiscount>

    public init(map: Map) throws {
        value              = try map.value("value")
        discount           = try map.value("discount")
    }
}

public struct ExternalLineItemTotalPrice: ImmutableMappable {

    // MARK: - Properties

    public let price: Money
    public let totalPrice: Money

    public init(map: Map) throws {
        price              = try map.value("price")
        totalPrice         = try map.value("totalPrice")
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

public struct Image: ImmutableMappable {

    // MARK: - Properties

    public let url: String
    public let dimensions: [String: Int]
    public let label: String?

    public init(map: Map) throws {
        url                = try map.value("url")
        dimensions         = try map.value("dimensions")
        label              = try? map.value("label")
    }
}

public enum InventoryMode: String {

    case trackOnly = "TrackOnly"
    case reserveOnOrder = "ReserveOnOrder"
    case none = "None"

}

public struct ItemState: ImmutableMappable {

    // MARK: - Properties

    public let quantity: Int
    public let state: Reference<State>

    public init(map: Map) throws {
        quantity                = try map.value("quantity")
        state                   = try map.value("state")
    }
}

public typealias LocalizedString = [String: String]

public struct LineItem: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let productId: String
    public let name: LocalizedString
    public let productSlug: LocalizedString?
    public let productType: Reference<ProductType>?
    public let variant: ProductVariant
    public let price: Price
    public let taxedPrice: TaxedItemPrice?
    public let totalPrice: Money
    public let quantity: Int
    public let state: [ItemState]
    public let taxRate: TaxRate?
    public let supplyChannel: Reference<Channel>?
    public let distributionChannel: Reference<Channel>?
    public let discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]
    public let priceMode: LineItemPriceMode
    public let lineItemMode: LineItemMode
    public let custom: [String: Any]?

    public init(map: Map) throws {
        id                         = try map.value("id")
        productId                  = try map.value("productId")
        name                       = try map.value("name")
        productSlug                = try? map.value("productSlug")
        productType                = try? map.value("productType")
        variant                    = try map.value("variant")
        price                      = try map.value("price")
        taxedPrice                 = try? map.value("taxedPrice")
        totalPrice                 = try map.value("totalPrice")
        quantity                   = try map.value("quantity")
        state                      = try map.value("state")
        taxRate                    = try? map.value("taxRate")
        supplyChannel              = try? map.value("supplyChannel")
        distributionChannel        = try? map.value("distributionChannel")
        discountedPricePerQuantity = try map.value("discountedPricePerQuantity")
        priceMode                  = try map.value("priceMode")
        lineItemMode               = try map.value("lineItemMode")
        custom                     = try? map.value("custom")
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

public enum LineItemMode: String {

    case standard = "Standard"
    case giftLineItem = "GiftLineItem"

}

public struct Location: ImmutableMappable {

    // MARK: - Properties

    public let country: String
    public let state: String?

    public init(map: Map) throws {
        country           = try map.value("country")
        state             = try? map.value("state")
    }
}

public struct Money: ImmutableMappable {

    // MARK: - Properties

    public let currencyCode: String
    public let centAmount: Int
    
    public init(currencyCode: String, centAmount: Int) {
        self.currencyCode = currencyCode
        self.centAmount = centAmount
    }
    
    public init(map: Map) throws {
        currencyCode       = try map.value("currencyCode")
        centAmount         = try map.value("centAmount")
    }

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        currencyCode       >>> map["currencyCode"]
        centAmount         >>> map["centAmount"]
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

public struct Parcel: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let createdAt: Date
    public let measurements: ParcelMeasurements?
    public let trackingData: TrackingData?

    public init(map: Map) throws {
        id                = try map.value("id")
        createdAt         = try map.value("createdAt", using: ISO8601DateTransform())
        measurements      = try? map.value("measurements")
        trackingData      = try? map.value("trackingData")
    }
}

public struct ParcelMeasurements: ImmutableMappable {

    // MARK: - Properties

    public let heightInMillimeter: Double
    public let lengthInMillimeter: Double
    public let widthInMillimeter: Double
    public let weightInGram: Double

    public init(map: Map) throws {
        heightInMillimeter   = try map.value("heightInMillimeter")
        lengthInMillimeter   = try map.value("lengthInMillimeter")
        widthInMillimeter    = try map.value("widthInMillimeter")
        weightInGram         = try map.value("weightInGram")
    }
}

public struct Payment: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let customer: Reference<Customer>?
    public let externalId: String?
    public let interfaceId: String?
    public let amountPlanned: Money
    public let amountAuthorized: Money?
    public let authorizedUntil: String?
    public let amountPaid: Money?
    public let amountRefunded: Money?
    public let paymentMethodInfo: PaymentMethodInfo
    public let paymentStatus: PaymentStatus
    public let transactions: [Transaction]
    public let interfaceInteractions: [[String: Any]]
    public let custom: [String: Any]?
    public let createdAt: Date
    public let lastModifiedAt: Date

    public init(map: Map) throws {
        id                    = try map.value("id")
        version               = try map.value("version")
        customer              = try? map.value("customer")
        externalId            = try? map.value("externalId")
        interfaceId           = try? map.value("interfaceId")
        amountPlanned         = try map.value("amountPlanned")
        amountAuthorized      = try? map.value("amountAuthorized")
        authorizedUntil       = try? map.value("authorizedUntil")
        amountPaid            = try? map.value("amountPaid")
        amountRefunded        = try? map.value("amountRefunded")
        paymentMethodInfo     = try map.value("paymentMethodInfo")
        paymentStatus         = try map.value("paymentStatus")
        transactions          = try map.value("transactions")
        interfaceInteractions = try map.value("interfaceInteractions")
        custom                = try? map.value("custom")
        createdAt             = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt        = try map.value("lastModifiedAt", using: ISO8601DateTransform())
    }
}

public struct PaymentInfo: ImmutableMappable {

    // MARK: - Properties

    public let payments: [Reference<Payment>]

    public init(map: Map) throws {
        payments           = try map.value("payments")
    }
}

public struct PaymentMethodInfo: ImmutableMappable {

    // MARK: - Properties

    public let paymentInterface: String?
    public let method: String?
    public let name: LocalizedString?

    public init(map: Map) throws {
        paymentInterface      = try? map.value("paymentInterface")
        method                = try? map.value("method")
        name                  = try? map.value("name")
    }
}

public enum PaymentState: String {

    case balanceDue = "BalanceDue"
    case failed = "Failed"
    case pending = "Pending"
    case creditOwed = "CreditOwed"
    case paid = "Paid"

}

public struct PaymentStatus: ImmutableMappable {

    // MARK: - Properties

    public let interfaceCode: String?
    public let interfaceText: String?
    public let state: Reference<State>?

    public init(map: Map) throws {
        interfaceCode      = try? map.value("interfaceCode")
        interfaceText      = try? map.value("interfaceText")
        state              = try? map.value("state")
    }
}

public struct Price: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let value: Money
    public let country: String?
    public let customerGroup: Reference<CustomerGroup>?
    public let channel: Reference<Channel>?
    public let validFrom: Date?
    public let validUntil: Date?
    public let tiers: [PriceTier]?
    public let discounted: DiscountedPrice?
    public let custom: [String: Any]?

    public init(map: Map) throws {
        id                 = try map.value("id")
        value              = try map.value("value")
        country            = try? map.value("country")
        customerGroup      = try? map.value("customerGroup")
        channel            = try? map.value("channel")
        validFrom          = try? map.value("validFrom", using: ISO8601DateTransform())
        validUntil         = try? map.value("validUntil", using: ISO8601DateTransform())
        tiers              = try? map.value("tiers")
        discounted         = try? map.value("discounted")
        custom             = try? map.value("custom")
    }
}

public struct PriceTier: ImmutableMappable {

    // MARK: - Properties

    public let minimumQuantity: UInt
    public let value: Money

    public init(map: Map) throws {
        minimumQuantity    = try map.value("minimumQuantity")
        value              = try map.value("value")
    }
}

public struct ProductDiscount: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: LocalizedString
    public let description: LocalizedString?
    public let value: ProductDiscountValue
    public let predicate: String
    public let sortOrder: String
    public let isActive: Bool
    public let references: [GenericReference]

    public init(map: Map) throws {
        id                = try map.value("id")
        version           = try map.value("version")
        createdAt         = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt    = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        name              = try map.value("name")
        description       = try? map.value("description")
        value             = try map.value("value")
        predicate         = try map.value("predicate")
        sortOrder         = try map.value("sortOrder")
        isActive          = try map.value("isActive")
        references        = try map.value("references")
    }
}

public struct ProductDiscountValue: ImmutableMappable {

    // MARK: - Properties

    public let type: String
    public let permyriad: Int?
    public let money: Money?

    public init(map: Map) throws {
        type            = try map.value("type")
        permyriad       = try? map.value("permyriad")
        money           = try? map.value("money")
    }
}

public struct ProductVariant: ImmutableMappable {

    // MARK: - Properties

    public let id: Int
    public let sku: String?
    public let key: String?
    public let prices: [Price]?
    public let attributes: [Attribute]?
    public let price: Price?
    public let images: [Image]?
    public let assets: [Asset]?
    public let availability: ProductVariantAvailability?
    public let isMatchingVariant: Bool?
    public let scopedPrice: ScopedPrice?
    public let scopedPriceDiscounted: Bool?

    public init(map: Map) throws {
        id                     = try map.value("id")
        sku                    = try? map.value("sku")
        key                    = try? map.value("key")
        prices                 = try? map.value("prices")
        attributes             = try? map.value("attributes")
        price                  = try? map.value("price")
        images                 = try? map.value("images")
        assets                 = try? map.value("assets")
        availability           = try? map.value("availability")
        isMatchingVariant      = try? map.value("isMatchingVariant")
        scopedPrice            = try? map.value("scopedPrice")
        scopedPriceDiscounted  = try? map.value("scopedPriceDiscounted")
    }
}

public struct ProductVariantAvailability: ImmutableMappable {

    // MARK: - Properties

    public let isOnStock: Bool?
    public let restockableInDays: Int?
    public let availableQuantity: Int?
    public let channels: [String: ProductVariantAvailability]?

    public init(map: Map) throws {
        isOnStock                = try? map.value("isOnStock")
        restockableInDays        = try? map.value("restockableInDays")
        availableQuantity        = try? map.value("availableQuantity")
        channels                 = try? map.value("channels")
    }
}

public struct Reference<T: BaseMappable>: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let typeId: String
    public let obj: T?
    
    public init(id: String, typeId: String) {
        self.id = id
        self.typeId = typeId
    }
    
    public init(map: Map) throws {
        id              = try map.value("id")
        typeId          = try map.value("typeId")
        obj             = try? map.value("obj")
    }
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
        id                      >>> map["id"]
        typeId                  >>> map["typeId"]
    }
}

public struct GenericReference: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let typeId: String
    
    public init(id: String, typeId: String) {
        self.id = id
        self.typeId = typeId
    }

    public init(map: Map) throws {
        id              = try map.value("id")
        typeId          = try map.value("typeId")
    }
    
    // MARK: - Mappable
    
    mutating public func mapping(map: Map) {
        id                      >>> map["id"]
        typeId                  >>> map["typeId"]
    }
}

public struct ResourceIdentifier: ImmutableMappable {

    // MARK: - Properties

    public let id: String?
    public let typeId: String?
    public let key: String?
    
    public init(map: Map) throws {
        id                 = try? map.value("id")
        typeId             = try? map.value("typeId")
        key                = try? map.value("key")
    }
}

public struct ReturnInfo: ImmutableMappable {

    // MARK: - Properties

    public let items: [ReturnItem]
    public let returnTrackingId: String
    public let returnDate: Date

    public init(map: Map) throws {
        items              = try map.value("items")
        returnTrackingId   = try map.value("returnTrackingId")
        returnDate         = try map.value("returnDate", using: ISO8601DateTransform())
    }
}

public struct ReturnItem: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let quantity: UInt
    public let lineItemId: String
    public let comment: String
    public let shipmentState: ReturnShipmentState
    public let paymentState: ReturnPaymentState
    public let lastModifiedAt: Date
    public let createdAt: Date

    public init(map: Map) throws {
        id             = try map.value("id")
        quantity       = try map.value("quantity")
        lineItemId     = try map.value("lineItemId")
        comment        = try map.value("comment")
        shipmentState  = try map.value("shipmentState")
        paymentState   = try map.value("paymentState")
        lastModifiedAt = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        createdAt      = try map.value("createdAt", using: ISO8601DateTransform())
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
public struct ReviewRatingStatistics: ImmutableMappable {

    // MARK: - Properties

    public let averageRating: Double
    public let highestRating: Double
    public let lowestRating: Double
    public let count: UInt
    public let ratingsDistribution: [String: Any]

    public init(map: Map) throws {
        averageRating        = try map.value("averageRating")
        highestRating        = try map.value("highestRating")
        lowestRating         = try map.value("lowestRating")
        count                = try map.value("count")
        ratingsDistribution  = try map.value("ratingsDistribution")
    }
}

public struct ScopedPrice: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let value: Money
    public let currentValue: Money
    public let country: String?
    public let customerGroup: Reference<CustomerGroup>?
    public let channel: Reference<Channel>?
    public let validFrom: Date?
    public let validUntil: Date?
    public let discounted: DiscountedPrice?
    public let custom: [String: Any]?

    public init(map: Map) throws {
        id                   = try map.value("id")
        value                = try map.value("value")
        currentValue         = try map.value("currentValue")
        country              = try? map.value("country")
        customerGroup        = try? map.value("customerGroup")
        channel              = try? map.value("channel")
        validFrom            = try? map.value("validFrom")
        validUntil           = try? map.value("validUntil")
        discounted           = try? map.value("discounted")
        custom               = try? map.value("custom")
    }
}

public struct SearchKeyword: ImmutableMappable {

    // MARK: - Properties

    public let text: String
    public let suggestTokenizer: SuggestTokenizer?

    public init(map: Map) throws {
        text                  = try map.value("text")
        suggestTokenizer      = try? map.value("suggestTokenizer")
    }
}

public struct SuggestTokenizer: ImmutableMappable {

    // MARK: - Properties

    public let type: String
    public let inputs: [String]?

    public init(map: Map) throws {
        type                  = try map.value("type")
        inputs                = try? map.value("inputs")
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


public struct ShippingInfo: ImmutableMappable {

    // MARK: - Properties

    public let shippingMethodName: String
    public let price: Money
    public let shippingRate: ShippingRate
    public let taxedPrice: TaxedItemPrice?
    public let taxRate: TaxRate?
    public let taxCategory: Reference<TaxCategory>?
    public let shippingMethod: Reference<ShippingMethod>?
    public let deliveries: [Delivery]
    public let discountedPrice: DiscountedLineItemPrice?

    public init(map: Map) throws {
        shippingMethodName         = try map.value("shippingMethodName")
        price                      = try map.value("price")
        shippingRate               = try map.value("shippingRate")
        taxedPrice                 = try? map.value("taxedPrice")
        taxRate                    = try? map.value("taxRate")
        taxCategory                = try? map.value("taxCategory")
        shippingMethod             = try? map.value("shippingMethod")
        deliveries                 = try map.value("deliveries")
        discountedPrice            = try? map.value("discountedPrice")
    }
}

public struct ShippingRate: ImmutableMappable {

    // MARK: - Properties

    public let price: Money
    public let freeAbove: Money?
    public let isMatching: Bool?

    public init(map: Map) throws {
        price             = try map.value("price")
        freeAbove         = try? map.value("freeAbove")
        isMatching        = try? map.value("isMatching")
    }
}

public struct State: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let key: String
    public let type: StateType
    public let name: LocalizedString
    public let description: LocalizedString
    public let initial: Bool
    public let builtIn: Bool
    public let roles: [StateRole]?
    public let transitions: [Reference<State>]?

    public init(map: Map) throws {
        id                = try map.value("id")
        version           = try map.value("version")
        createdAt         = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt    = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        key               = try map.value("key")
        type              = try map.value("type")
        name              = try map.value("name")
        description       = try map.value("description")
        initial           = try map.value("initial")
        builtIn           = try map.value("builtIn")
        roles             = try? map.value("roles")
        transitions       = try? map.value("transitions")
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

public struct SubRate: ImmutableMappable {

    // MARK: - Properties

    public let name: String
    public let amount: Double
    
    public init(name: String, amount: Double) {
        self.name = name
        self.amount = amount
    }
    
    public init(map: Map) throws {
        name       = try map.value("name")
        amount     = try map.value("amount")
    }

    // MARK: - Mappable

    mutating func mapping(map: Map) {
        name       >>> map["name"]
        amount     >>> map["amount"]
    }
}

public struct SyncInfo: ImmutableMappable {

    // MARK: - Properties

    public let channel: Reference<Channel>
    public let externalId: String?
    public let syncedAt: Date

    public init(map: Map) throws {
        channel          = try map.value("channel")
        externalId       = try? map.value("externalId")
        syncedAt         = try map.value("syncedAt", using: ISO8601DateTransform())
    }
}

public struct TaxCategory: ImmutableMappable {

    // MARK: - Properties

    public let id: String!
    public let version: UInt!
    public let createdAt: Date!
    public let lastModifiedAt: Date!
    public let name: String!
    public let description: String?
    public let rates: [TaxRate]!

    public init(map: Map) throws {
        id               = try map.value("id")
        version          = try map.value("version")
        createdAt        = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt   = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        name             = try map.value("name")
        description      = try? map.value("description")
        rates            = try map.value("rates")
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

public struct TaxRate: ImmutableMappable {

    // MARK: - Properties

    public let id: String?
    public let name: String
    public let includedInPrice: Bool
    public let country: String
    public let state: String?
    public let subRates: [SubRate]

    public init(map: Map) throws {
        id                = try? map.value("id")
        name              = try map.value("name")
        includedInPrice   = try map.value("includedInPrice")
        country           = try map.value("country")
        state             = try? map.value("state")
        subRates          = try map.value("subRates")
    }
}

public struct TaxedItemPrice: ImmutableMappable {

    // MARK: - Properties

    public let totalNet: Money
    public let totalGross: Money

    public init(map: Map) throws {
        totalNet                = try map.value("totalNet")
        totalGross              = try map.value("totalGross")
    }
}

public struct TaxedPrice: ImmutableMappable {

    // MARK: - Properties

    public let totalNet: Money
    public let totalGross: Money
    public let taxPortions: [TaxPortion]

    public init(map: Map) throws {
        totalNet         = try map.value("totalNet")
        totalGross       = try map.value("totalGross")
        taxPortions      = try map.value("taxPortions")
    }
}

public struct TaxPortion: ImmutableMappable {

	// MARK: - Properties
	
	public let name: String?
	public let rate: Double
	public let amount: Money
	
	public init(map: Map) throws {
        name             = try? map.value("name")
        rate             = try map.value("rate")
        amount           = try map.value("amount")
    }
}

public struct TrackingData: ImmutableMappable {

    // MARK: - Properties

    public let trackingId: String?
    public let carrier: String?
    public let provider: String?
    public let providerTransaction: String?
    public let isReturn: Bool?

    public init(map: Map) throws {
        trackingId           = try? map.value("trackingId")
        carrier              = try? map.value("carrier")
        provider             = try? map.value("provider")
        providerTransaction  = try? map.value("providerTransaction")
        isReturn             = try? map.value("isReturn")
    }
}

public struct Transaction: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let timestamp: Date?
    public let type: TransactionType
    public let amount: Money
    public let interactionId: String?
    public let state: TransactionState

    public init(map: Map) throws {
        id                    = try map.value("id")
        timestamp             = try? map.value("timestamp")
        type                  = try map.value("type")
        amount                = try map.value("amount")
        interactionId         = try? map.value("interactionId")
        state                 = try map.value("state")
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

public struct Zone: ImmutableMappable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: String
    public let description: String?
    public let locations: [Location]

    public init(map: Map) throws {
        id               = try map.value("id")
        version          = try map.value("version")
        createdAt        = try map.value("createdAt", using: ISO8601DateTransform())
        lastModifiedAt   = try map.value("lastModifiedAt", using: ISO8601DateTransform())
        name             = try map.value("name")
        description      = try? map.value("description")
        locations        = try map.value("locations")
    }
}

public struct ZoneRate: ImmutableMappable {

    // MARK: - Properties

    public let zone: Reference<Zone>
    public let shippingRates: [ShippingRate]

    public init(map: Map) throws {
        zone              = try map.value("zone")
        shippingRates     = try map.value("shippingRates")
    }
}
