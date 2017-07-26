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
    public let key: String?
    public let dimensions: [AssetDimensions]?
    public let contentType: String?

    public init(map: Map) throws {
        uri              = try map.value("uri")
        key              = try? map.value("key")
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

    public var currency: String!
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

    public init(currency: String, customerId: String? = nil, customerEmail: String? = nil, anonymousId: String? = nil, country: String? = nil, inventoryMode: InventoryMode? = nil, taxMode: TaxMode? = nil, lineItems: [LineItemDraft]? = nil, customLineItems: [CustomLineItemDraft]? = nil, shippingAddress: Address? = nil, billingAddress: Address? = nil, shippingMethod: Reference<ShippingMethod>? = nil, externalTaxRateForShippingMethod: ExternalTaxRateDraft? = nil, custom: [String: Any]? = nil, locale: String? = nil, deleteDaysAfterLastModification: UInt? = nil) {
        self.currency = currency
        self.customerId = customerId
        self.customerEmail = customerEmail
        self.anonymousId = anonymousId
        self.country = country
        self.inventoryMode = inventoryMode
        self.taxMode = taxMode
        self.lineItems = lineItems
        self.customLineItems = customLineItems
        self.shippingAddress = shippingAddress
        self.billingAddress = billingAddress
        self.shippingMethod = shippingMethod
        self.externalTaxRateForShippingMethod = externalTaxRateForShippingMethod
        self.custom = custom
        self.locale = locale
        self.deleteDaysAfterLastModification = deleteDaysAfterLastModification
    }
    
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

    case addLineItem(lineItemDraft: LineItemDraft)
    case removeLineItem(lineItemId: String, quantity: UInt?)
    case changeLineItemQuantity(lineItemId: String, quantity: UInt)
    case setCustomerEmail(email: String?)
    case setShippingAddress(address: Address?)
    case setBillingAddress(address: Address?)
    case setCountry(country: String?)
    case setShippingMethod(shippingMethod: Reference<ShippingMethod>?, externalTaxRate: ExternalTaxRateDraft?)
    case setCustomShippingMethod(shippingMethodName: String, shippingRate: ShippingRate, taxCategory: Reference<TaxCategory>?, externalTaxRate: ExternalTaxRateDraft?)
    case addDiscountCode(code: String)
    case removeDiscountCode(discountCode: Reference<DiscountCode>)
    case recalculate(updateProductData: Bool?)
    case setCustomType(type: ResourceIdentifier?, fields: [String: Any]?)
    case setCustomField(name: String, value: Any?)
    case setLineItemCustomType(type: ResourceIdentifier?, lineItemId: String, fields: [String: Any]?)
    case setLineItemCustomField(lineItemId: String, name: String, value: Any?)
    case addPayment(payment: Reference<Payment>)
    case removePayment(payment: Reference<Payment>)
    case changeTaxMode(taxMode: TaxMode)
    case setLocale(locale: String)
    case setDeleteDaysAfterLastModification(deleteDaysAfterLastModification: UInt?)
    
    public var toJSON: [String: Any] {
        switch self {
        case .addLineItem(let lineItemDraft):
            return filterJSON(parameters: ["action": "addLineItem", "productId": lineItemDraft.productVariantSelection.values.productId,
                                           "sku": lineItemDraft.productVariantSelection.values.sku, "quantity": lineItemDraft.quantity,
                                           "variantId": lineItemDraft.productVariantSelection.values.variantId,
                                           "supplyChannel": lineItemDraft.supplyChannel, "distributionChannel": lineItemDraft.distributionChannel,
                                           "externalTaxRate": lineItemDraft.externalTaxRate, "custom": lineItemDraft.custom])
        case .removeLineItem(let lineItemId, let quantity):
            return filterJSON(parameters: ["action": "removeLineItem", "lineItemId": lineItemId, "quantity": quantity])
        case .changeLineItemQuantity(let lineItemId, let quantity):
            return filterJSON(parameters: ["action": "changeLineItemQuantity", "lineItemId": lineItemId, "quantity": quantity])
        case .setCustomerEmail(let email):
            return filterJSON(parameters: ["action": "setCustomerEmail", "email": email])
        case .setShippingAddress(let address):
            return filterJSON(parameters: ["action": "setShippingAddress", "address": address])
        case .setBillingAddress(let address):
            return filterJSON(parameters: ["action": "setBillingAddress", "address": address])
        case .setCountry(let country):
            return filterJSON(parameters: ["action": "setCountry", "country":country])
        case .setShippingMethod(let shippingMethod, let externalTaxRate):
            return filterJSON(parameters: ["action": "setShippingMethod", "shippingMethod": shippingMethod, "externalTaxRate": externalTaxRate])
        case .setCustomShippingMethod(let shippingMethodName, let shippingRate, let taxCategory, let externalTaxRate):
            return filterJSON(parameters: ["action": "setCustomShippingMethod", "shippingMethodName": shippingMethodName, "shippingRate": shippingRate, "taxCategory": taxCategory, "externalTaxRate": externalTaxRate])
        case .addDiscountCode(let code):
            return filterJSON(parameters: ["action": "addDiscountCode", "code": code])
        case .removeDiscountCode(let discountCode):
            return filterJSON(parameters: ["action": "removeDiscountCode", "discountCode": discountCode])
        case .recalculate(let updateProductData):
            return filterJSON(parameters: ["action": "recalculate", "updateProductData": updateProductData])
        case .setCustomType(let type, let fields):
            return filterJSON(parameters: ["action": "setCustomType", "type": type, "fields": fields])
        case .setCustomField(let name, let value):
            return filterJSON(parameters: ["action": "setCustomField", "name": name, "value": value])
        case .setLineItemCustomType(let type, let lineItemId, let fields):
            return filterJSON(parameters: ["action": "setLineItemCustomType", "type": type, "lineItemId": lineItemId, "fields": fields])
        case .setLineItemCustomField(let lineItemId, let name, let value):
            return filterJSON(parameters: ["action": "setLineItemCustomField", "lineItemId": lineItemId, "name": name, "value": value])
        case .addPayment(let payment):
            return filterJSON(parameters: ["action": "addPayment", "payment": payment])
        case .removePayment(let payment):
            return filterJSON(parameters: ["action": "removePayment", "payment": payment])
        case .changeTaxMode(let taxMode):
            return filterJSON(parameters: ["action": "changeTaxMode", "taxMode": taxMode.rawValue])
        case .setLocale(let locale):
            return filterJSON(parameters: ["action": "setLocale", "locale": locale])
        case .setDeleteDaysAfterLastModification(let deleteDaysAfterLastModification):
            return filterJSON(parameters: ["action": "setDeleteDaysAfterLastModification", "deleteDaysAfterLastModification": deleteDaysAfterLastModification])
        }
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
        roles                   = try map.value("roles", using: EnumTransform<ChannelRole>())
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

    public var name: LocalizedString!
    public var quantity: UInt?
    public var money: Money!
    public var slug: String!
    public var taxCategory: Reference<TaxCategory>?
    public var externalTaxRate: ExternalTaxRateDraft?
    public var custom: [String: Any]?

    public init(name: LocalizedString, quantity: UInt? = nil, money: Money, slug: String, taxCategory: Reference<TaxCategory>? = nil, externalTaxRate: ExternalTaxRateDraft? = nil, custom: [String: Any]? = nil) {
        self.name = name
        self.quantity = quantity
        self.money = money
        self.slug = slug
        self.taxCategory = taxCategory
        self.externalTaxRate = externalTaxRate
        self.custom = custom
    }
    
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

    public var email: String!
    public var password: String!
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

    public init(email: String, password: String, firstName: String? = nil, lastName: String? = nil, middleName: String? = nil, title: String? = nil, dateOfBirth: Date? = nil, companyName: String? = nil, vatId: String? = nil, addresses: [Address]? = nil, defaultBillingAddress: Int? = nil, defaultShippingAddress: Int? = nil, custom: [String: Any]? = nil, locale: String? = nil) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
        self.title = title
        self.dateOfBirth = dateOfBirth
        self.companyName = companyName
        self.vatId = vatId
        self.addresses = addresses
        self.defaultBillingAddress = defaultBillingAddress
        self.defaultShippingAddress = defaultShippingAddress
        self.custom = custom
        self.locale = locale
    }
    
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
    public let key: String?
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: String

    public init(map: Map) throws {
        id               = try map.value("id")
        key              = try? map.value("key")
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

    case changeEmail(email: String)
    case setFirstName(firstName: String?)
    case setLastName(lastName: String?)
    case setMiddleName(middleName: String?)
    case setTitle(title: String?)
    case setSalutation(salutation: String?)
    case addAddress(address: Address)
    case changeAddress(addressId: String, address: Address)
    case removeAddress(addressId: String)
    case setDefaultShippingAddress(addressId: String?)
    case addShippingAddressId(addressId: String)
    case removeShippingAddressId(addressId: String)
    case setDefaultBillingAddress(addressId: String?)
    case addBillingAddressId(addressId: String)
    case removeBillingAddressId(addressId: String)
    case setCompanyName(companyName: String?)
    case setDateOfBirth(dateOfBirth: Date?)
    case setVatId(vatId: String?)
    case setCustomType(type: ResourceIdentifier?, fields: [String: Any]?)
    case setCustomField(name: String, value: Any?)
    case setLocale(locale: String)

    public var toJSON: [String: Any] {
        switch self {
        case .changeEmail(let email):
            return filterJSON(parameters: ["action": "changeEmail", "email": email])
        case .setFirstName(let firstName):
            return filterJSON(parameters: ["action": "setFirstName", "firstName": firstName])
        case .setLastName(let lastName):
            return filterJSON(parameters: ["action": "setLastName", "lastName": lastName])
        case .setMiddleName(let middleName):
            return filterJSON(parameters: ["action": "setMiddleName", "middleName": middleName])
        case .setTitle(let title):
            return filterJSON(parameters: ["action": "setTitle", "title": title])
        case .setSalutation(let salutation):
            return filterJSON(parameters: ["action": "setSalutation", "salutation": salutation])
        case .addAddress(let address):
            return filterJSON(parameters: ["action": "addAddress", "address": address])
        case .changeAddress(let addressId, let address):
            return filterJSON(parameters: ["action": "changeAddress", "addressId": addressId, "address": address])
        case .removeAddress(let addressId):
            return filterJSON(parameters: ["action": "removeAddress", "addressId": addressId])
        case .setDefaultShippingAddress(let addressId):
            return filterJSON(parameters: ["action": "setDefaultShippingAddress", "addressId": addressId])
        case .addShippingAddressId(let addressId):
            return filterJSON(parameters: ["action": "addShippingAddressId", "addressId": addressId])
        case .removeShippingAddressId(let addressId):
            return filterJSON(parameters: ["action": "removeShippingAddressId", "addressId": addressId])
        case .setDefaultBillingAddress(let addressId):
            return filterJSON(parameters: ["action": "setDefaultBillingAddress", "addressId": addressId])
        case .addBillingAddressId(let addressId):
            return filterJSON(parameters: ["action": "addBillingAddressId", "addressId": addressId])
        case .removeBillingAddressId(let addressId):
            return filterJSON(parameters: ["action": "removeBillingAddressId", "addressId": addressId])
        case .setCompanyName(let companyName):
            return filterJSON(parameters: ["action": "setCompanyName", "companyName": companyName])
        case .setDateOfBirth(let dateOfBirth):
            return filterJSON(parameters: ["action": "setDateOfBirth", "dateOfBirth": ISO8601DateTransform().transformToJSON(dateOfBirth)])
        case .setVatId(let vatId):
            return filterJSON(parameters: ["action": "setVatId", "vatId": vatId])
        case .setCustomType(let type, let fields):
            return filterJSON(parameters: ["action": "setCustomType", "type": type, "fields": fields])
        case .setCustomField(let name, let value):
            return filterJSON(parameters: ["action": "setCustomField", "name": name, "value": value])
        case .setLocale(let locale):
            return filterJSON(parameters: ["action": "setLocale", "locale": locale])
        }
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
    public let cartDiscounts: [Reference<CartDiscount>]
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

    public var name: String!
    public var amount: Double?
    public var country: String!
    public var state: String?
    public var subRates: [SubRate]?

    public init(name: String, amount: Double? = nil, country: String, state: String? = nil, subRates: [SubRate]? = nil) {
        self.name = name
        self.amount = amount
        self.country = country
        self.state = state
        self.subRates = subRates
    }
    
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

public class LineItemDraft: Mappable {

    public enum ProductVariantSelection {

        case sku(sku: String)
        case productVariant(productId: String, variantId: Int)

        var values: (productId: String?, variantId: Int?, sku: String?) {
            switch self {
                case .productVariant(let productId, let variantId):
                    return (productId: productId, variantId: variantId, sku: nil)
                case .sku(let sku):
                    return (productId: nil, variantId: nil, sku: sku)
            }
        }
    }

    // MARK: - Properties

    public var productVariantSelection: ProductVariantSelection!
    public var quantity: UInt?
    public var supplyChannel: Reference<Channel>?
    public var distributionChannel: Reference<Channel>?
    public var externalTaxRate: ExternalTaxRateDraft?
    public var custom: [String: Any]?
    internal var productId: String?
    internal var variantId: Int?
    internal var sku: String?

    public init(productVariantSelection: ProductVariantSelection, quantity: UInt? = nil, supplyChannel: Reference<Channel>? = nil, distributionChannel: Reference<Channel>? = nil, externalTaxRate: ExternalTaxRateDraft? = nil, custom: [String: Any]? = nil) {
        self.productVariantSelection = productVariantSelection
        self.quantity = quantity
        self.supplyChannel = supplyChannel
        self.distributionChannel = distributionChannel
        self.externalTaxRate = externalTaxRate
        self.custom = custom
    }
    
    public required init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        productId                    <- (map["productId"], TransformOf<String, String>(fromJSON: { _ in return nil },
                                             toJSON: { [unowned self] _ in return self.productVariantSelection.values.productId
                                         }))
        variantId                    <- (map["variantId"], TransformOf<Int, Int>(fromJSON: { _ in return nil },
                                             toJSON: { [unowned self] _ in return self.productVariantSelection.values.variantId
                                         }))
        sku                          <- (map["sku"], TransformOf<String, String>(fromJSON: { _ in return nil },
                                             toJSON: { [unowned self] _ in return self.productVariantSelection.values.sku
                                         }))
        sku                          <- map["sku"]
        quantity                     <- map["quantity"]
        supplyChannel                <- map["supplyChannel"]
        distributionChannel          <- map["distributionChannel"]
        externalTaxRate              <- map["externalTaxRate"]
        custom                       <- map["custom"]
    }
}

public enum LineItemPriceMode: String {

    case platform = "Platform"
    case externalPrice = "ExternalPrice"
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

    public var id: String!
    public var version: UInt!

    public init(id: String, version: UInt) {
        self.id = id
        self.version = version
    }
    
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
        self.obj = nil
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

    public init(id: String? = nil, typeId: String? = nil, key: String? = nil) {
        self.id = id
        self.typeId = typeId
        self.key = key
    }
    
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
        roles             = try? map.value("roles", using: EnumTransform<StateRole>())
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

    mutating public func mapping(map: Map) {
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
