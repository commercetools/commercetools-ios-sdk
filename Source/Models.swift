//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
#if !os(Linux)
import CoreLocation
#endif

public struct Address: Codable {

    // MARK: - Properties

    public var id: String?
    public var key: String?
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
    public var country: String
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
    
    public init(id: String? = nil, key: String? = nil, title: String? = nil, salutation: String? = nil, firstName: String? = nil, lastName: String? = nil, streetName: String? = nil, streetNumber: String? = nil, city: String? = nil, region: String? = nil, postalCode: String? = nil, additionalStreetInfo: String? = nil, state: String? = nil, country: String, company: String? = nil, department: String? = nil, building: String? = nil, apartment: String? = nil, pOBox: String? = nil, phone: String? = nil, mobile: String? = nil, email: String? = nil, fax: String? = nil, additionalAddressInfo: String? = nil, externalId: String? = nil) {
        self.id = id
        self.key = key
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
}

public enum AnonymousCartSignInMode: String, Codable {

    case mergeWithExistingCustomerCart = "MergeWithExistingCustomerCart"
    case useAsNewActiveCustomerCart = "UseAsNewActiveCustomerCart"

}

public struct Asset: Codable {

    // MARK: - Properties

    public let id: String
    public let key: String?
    public let sources: [AssetSource]
    public let name: LocalizedString
    public let description: LocalizedString?
    public let tags: [String]?
    public let custom: JsonValue?
}

public struct AssetSource: Codable {

    // MARK: - Properties

    public let uri: String
    public let key: String?
    public let dimensions: [AssetDimensions]?
    public let contentType: String?
}

public struct AssetDimensions: Codable {

    // MARK: - Properties

    public let w: Double
    public let h: Double
}

public struct Attribute: Codable {

    // MARK: - Properties

    public let name: String
    public let value: JsonValue
}

public struct AttributeDefinition: Codable {

    // MARK: - Properties

    public let type: AttributeType
    public let name: String
    public let label: [String: String]
    public let inputTip: [String: String]?
    public let isRequired: Bool
    public let isSearchable: Bool
}

public class AttributeType: Codable {
    
    public init(name: String, elementType: AttributeType?, values: [EnumValue]?) {
        self.name = name
        self.elementType = elementType
        self.values = values
    }

    // MARK: - Properties

    public let name: String
    public let elementType: AttributeType?
    public let values: [EnumValue]?

    public struct EnumValue: Codable {

        public let key: String
        public let label: JsonValue

        public var stringLabel: String? {
            return label.string
        }
        public var localizedStringLabel: LocalizedString? {
            return label.dictionary?.keys.reduce(into: [String: String]()) {
                if let stringValue = label.dictionary?[$1]?.string {
                    $0[$1] = stringValue
                }
            }
        }
    }
}

public struct CartDiscount: Codable {

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
    public let stackingMode: StackingMode
    public let custom: JsonValue?
}

public struct CartDiscountTarget: Codable {

    // MARK: - Properties

    public let type: String
    public let predicate: String?
}

public struct CartDiscountValue: Codable {

    // MARK: - Properties

    public let type: String
    public let permyriad: Int?
    public let money: Money?
}

public enum StackingMode: String, Codable {

    // MARK: - Properties

    case stacking = "Stacking"
    case stopAfterThisDiscount = "StopAfterThisDiscount"
}

public struct CartDraft: Codable {

    // MARK: - Properties

    public var currency: String
    public var customerEmail: String?
    public var country: String?
    public var inventoryMode: InventoryMode?
    public var taxMode: TaxMode?
    public var lineItems: [LineItemDraft]?
    public var shippingAddress: Address?
    public var billingAddress: Address?
    public var shippingMethod: Reference<ShippingMethod>?
    public var custom: JsonValue?
    public var locale: String?
    public var deleteDaysAfterLastModification: UInt?
    public var itemShippingAddresses: [Address]

    public init(currency: String, customerEmail: String? = nil, country: String? = nil, inventoryMode: InventoryMode? = nil, taxMode: TaxMode? = nil, lineItems: [LineItemDraft]? = nil, shippingAddress: Address? = nil, billingAddress: Address? = nil, shippingMethod: Reference<ShippingMethod>? = nil, custom: JsonValue? = nil, locale: String? = nil, deleteDaysAfterLastModification: UInt? = nil, itemShippingAddresses: [Address] = []) {
        self.currency = currency
        self.customerEmail = customerEmail
        self.country = country
        self.inventoryMode = inventoryMode
        self.taxMode = taxMode
        self.lineItems = lineItems
        self.shippingAddress = shippingAddress
        self.billingAddress = billingAddress
        self.shippingMethod = shippingMethod
        self.custom = custom
        self.locale = locale
        self.deleteDaysAfterLastModification = deleteDaysAfterLastModification
        self.itemShippingAddresses = itemShippingAddresses
    }
}

public enum CartState: String, Codable {

    case active = "Active"
    case merged = "Merged"
    case ordered = "Ordered"

}

public enum CartUpdateAction: JSONRepresentable {

    case addLineItem(lineItemDraft: LineItemDraft)
    case removeLineItem(lineItemId: String, quantity: UInt?, shippingDetailsToRemove: ItemShippingDetailsDraft?)
    case changeLineItemQuantity(lineItemId: String, quantity: UInt)
    case setCustomerEmail(email: String?)
    case setShippingAddress(address: Address?)
    case setBillingAddress(address: Address?)
    case setCountry(country: String?)
    case setShippingMethod(shippingMethod: Reference<ShippingMethod>?)
    case addDiscountCode(code: String)
    case removeDiscountCode(discountCode: Reference<DiscountCode>)
    case recalculate(updateProductData: Bool?)
    case setCustomType(type: ResourceIdentifier?, fields: JsonValue?)
    case setCustomField(name: String, value: JsonValue?)
    case setLineItemCustomType(type: ResourceIdentifier?, lineItemId: String, fields: JsonValue?)
    case setLineItemCustomField(lineItemId: String, name: String, value: JsonValue?)
    case addPayment(payment: Reference<Payment>)
    case removePayment(payment: Reference<Payment>)
    case changeTaxMode(taxMode: TaxMode)
    case setLocale(locale: String)
    case setDeleteDaysAfterLastModification(deleteDaysAfterLastModification: UInt?)
    case addItemShippingAddress(address: Address)
    case removeItemShippingAddress(addressKey: String)
    case updateItemShippingAddress(address: Address)
    case applyDeltaToLineItemShippingDetailsTargets(lineItemId: String, targetsDelta: [ItemShippingTarget])
    case setLineItemShippingDetails(lineItemId: String, shippingDetails: ItemShippingDetailsDraft?)

    public var toJSON: [String: Any]? {
        switch self {
        case .addLineItem(let lineItemDraft):
            return filterJSON(parameters: ["action": "addLineItem", "productId": lineItemDraft.productId, "sku": lineItemDraft.sku,
                                           "quantity": lineItemDraft.quantity, "variantId": lineItemDraft.variantId, "supplyChannel": lineItemDraft.supplyChannel?.toJSON,
                                           "distributionChannel": lineItemDraft.distributionChannel?.toJSON, "custom": lineItemDraft.custom?.toJSON])
        case .removeLineItem(let lineItemId, let quantity, let shippingDetailsToRemove):
            return filterJSON(parameters: ["action": "removeLineItem", "lineItemId": lineItemId, "quantity": quantity, "shippingDetailsToRemove": shippingDetailsToRemove])
        case .changeLineItemQuantity(let lineItemId, let quantity):
            return filterJSON(parameters: ["action": "changeLineItemQuantity", "lineItemId": lineItemId, "quantity": quantity])
        case .setCustomerEmail(let email):
            return filterJSON(parameters: ["action": "setCustomerEmail", "email": email])
        case .setShippingAddress(let address):
            return filterJSON(parameters: ["action": "setShippingAddress", "address": address?.toJSON])
        case .setBillingAddress(let address):
            return filterJSON(parameters: ["action": "setBillingAddress", "address": address?.toJSON])
        case .setCountry(let country):
            return filterJSON(parameters: ["action": "setCountry", "country": country])
        case .setShippingMethod(let shippingMethod):
            return filterJSON(parameters: ["action": "setShippingMethod", "shippingMethod": shippingMethod?.toJSON])
        case .addDiscountCode(let code):
            return filterJSON(parameters: ["action": "addDiscountCode", "code": code])
        case .removeDiscountCode(let discountCode):
            return filterJSON(parameters: ["action": "removeDiscountCode", "discountCode": discountCode.toJSON])
        case .recalculate(let updateProductData):
            return filterJSON(parameters: ["action": "recalculate", "updateProductData": updateProductData])
        case .setCustomType(let type, let fields):
            return filterJSON(parameters: ["action": "setCustomType", "type": type?.toJSON, "fields": fields?.toJSON])
        case .setCustomField(let name, let value):
            return filterJSON(parameters: ["action": "setCustomField", "name": name, "value": value?.toJSON])
        case .setLineItemCustomType(let type, let lineItemId, let fields):
            return filterJSON(parameters: ["action": "setLineItemCustomType", "type": type?.toJSON, "lineItemId": lineItemId, "fields": fields.toJSON])
        case .setLineItemCustomField(let lineItemId, let name, let value):
            return filterJSON(parameters: ["action": "setLineItemCustomField", "lineItemId": lineItemId, "name": name, "value": value?.toJSON])
        case .addPayment(let payment):
            return filterJSON(parameters: ["action": "addPayment", "payment": payment.toJSON])
        case .removePayment(let payment):
            return filterJSON(parameters: ["action": "removePayment", "payment": payment.toJSON])
        case .changeTaxMode(let taxMode):
            return filterJSON(parameters: ["action": "changeTaxMode", "taxMode": taxMode.rawValue])
        case .setLocale(let locale):
            return filterJSON(parameters: ["action": "setLocale", "locale": locale])
        case .setDeleteDaysAfterLastModification(let deleteDaysAfterLastModification):
            return filterJSON(parameters: ["action": "setDeleteDaysAfterLastModification", "deleteDaysAfterLastModification": deleteDaysAfterLastModification])
        case .addItemShippingAddress(let address):
            return filterJSON(parameters: ["action": "addItemShippingAddress", "address": address])
        case .removeItemShippingAddress(let addressKey):
            return filterJSON(parameters: ["action": "removeItemShippingAddress", "addressKey": addressKey])
        case .updateItemShippingAddress(let address):
            return filterJSON(parameters: ["action": "updateItemShippingAddress", "address": address])
        case .applyDeltaToLineItemShippingDetailsTargets(let lineItemId, let targetsDelta):
            return filterJSON(parameters: ["action": "applyDeltaToLineItemShippingDetailsTargets", "lineItemId": lineItemId, "targetsDelta": targetsDelta.map({ $0.toJSON })])
        case .setLineItemShippingDetails(let lineItemId, let shippingDetails):
            return filterJSON(parameters: ["action": "setLineItemShippingDetails", "lineItemId": lineItemId, "shippingDetails": shippingDetails])
        }
    }
}

public struct ShoppingListDraft: Codable {
    public var name: LocalizedString
    public var description: LocalizedString?
    public var lineItems: [LineItemDraft]?
    public var textLineItems: [TextLineItemDraft]?
    public var custom: JsonValue?
    public var deleteDaysAfterLastModification: Int?

    public init(name: LocalizedString, description: LocalizedString? = nil, lineItems: [LineItemDraft]? = nil, textLineItems: [TextLineItemDraft]? = nil, custom: JsonValue? = nil, deleteDaysAfterLastModification: Int? = nil) {
        self.name = name
        self.description = description
        self.lineItems = lineItems
        self.textLineItems = textLineItems
        self.custom = custom
        self.deleteDaysAfterLastModification = deleteDaysAfterLastModification
    }

    public struct LineItemDraft: Codable {
        public var productId: String
        public var variantId: Int?
        public var quantity: Int?
        public var addedAt: Date?
        public var custom: JsonValue?

        public init(productId: String, variantId: Int? = nil, quantity: Int? = nil, addedAt: Date? = nil, custom: JsonValue? = nil) {
            self.productId = productId
            self.variantId = variantId
            self.quantity = quantity
            self.addedAt = addedAt
            self.custom = custom
        }
    }
}

public struct TextLineItemDraft: Codable {
    public var name: LocalizedString
    public var description: LocalizedString?
    public var quantity: Int?
    public var addedAt: Date?
    public var custom: JsonValue?

    public init(name: LocalizedString, description: LocalizedString? = nil, quantity: Int? = nil, addedAt: Date? = nil, custom: JsonValue? = nil) {
        self.name = name
        self.description = description
        self.quantity = quantity
        self.addedAt = addedAt
        self.custom = custom
    }
}

public enum ShoppingListUpdateAction: JSONRepresentable {

    case changeName(name: LocalizedString)
    case setDescription(description: LocalizedString?)
    case setCustomType(type: ResourceIdentifier?, fields: JsonValue?)
    case setCustomField(name: String, value: JsonValue?)
    case addLineItem(productId: String, variantId: Int?, quantity: Int?, addedAt: Date?, custom: JsonValue?)
    case removeLineItem(lineItemId: String, quantity: Int?)
    case changeLineItemQuantity(lineItemId: String, quantity: Int)
    case changeLineItemsOrder(lineItemOrder: [String])
    case setLineItemCustomType(lineItemId: String, type: ResourceIdentifier?, fields: JsonValue?)
    case setLineItemCustomField(lineItemId: String, name: String, value: JsonValue?)
    case addTextLineItem(name: LocalizedString, description: LocalizedString?, quantity: Int?, addedAt: Date?, custom: JsonValue?)
    case removeTextLineItem(textLineItemId: String, quantity: Int?)
    case changeTextLineItemQuantity(textLineItemId: String, quantity: Int)
    case changeTextLineItemName(textLineItemId: String, name: LocalizedString)
    case setTextLineItemDescription(textLineItemId: String, description: LocalizedString?)
    case changeTextLineItemsOrder(textLineItemOrder: [String])
    case setTextLineItemCustomType(lineItemId: String, type: ResourceIdentifier?, fields: JsonValue?)
    case setTextLineItemCustomField(lineItemId: String, name: String, value: JsonValue?)
    case setDeleteDaysAfterLastModification(deleteDaysAfterLastModification: UInt?)

    public var toJSON: [String: Any]? {
        switch self {
        case .changeName(let name):
            return filterJSON(parameters: ["action": "changeName", "name": name])
        case .setDescription(let description):
            return filterJSON(parameters: ["action": "setDescription", "name": description])
        case .setCustomType(let type, let fields):
            return filterJSON(parameters: ["action": "setCustomType", "type": type, "fields": fields])
        case .setCustomField(let name, let value):
            return filterJSON(parameters: ["action": "setCustomField", "name": name, "value": value])
        case .addLineItem(let productId, let variantId, let quantity, let addedAt, let custom):
            return filterJSON(parameters: ["action": "addLineItem", "productId": productId, "variantId": variantId, "quantity": quantity, "addedAt": addedAt, "custom": custom])
        case .removeLineItem(let lineItemId, let quantity):
            return filterJSON(parameters: ["action": "removeLineItem", "lineItemId": lineItemId, "quantity": quantity])
        case .changeLineItemQuantity(let lineItemId, let quantity):
            return filterJSON(parameters: ["action": "changeLineItemQuantity", "lineItemId": lineItemId, "quantity": quantity])
        case .changeLineItemsOrder(let lineItemOrder):
            return filterJSON(parameters: ["action": "changeLineItemsOrder", "lineItemOrder": lineItemOrder])
        case .setLineItemCustomType(let lineItemId, let type, let fields):
            return filterJSON(parameters: ["action": "setLineItemCustomType", "lineItemId": lineItemId, "type": type, "fields": fields])
        case .setLineItemCustomField(let lineItemId, let name, let value):
            return filterJSON(parameters: ["action": "setLineItemCustomField", "lineItemId": lineItemId, "name": name, "value": value])
        case .addTextLineItem(let name, let description, let quantity, let addedAt, let custom):
            return filterJSON(parameters: ["action": "addTextLineItem", "name": name, "description": description, "quantity": quantity, "addedAt": addedAt, "custom": custom])
        case .removeTextLineItem(let textLineItemId, let quantity):
            return filterJSON(parameters: ["action": "removeTextLineItem", "textLineItemId": textLineItemId, "quantity": quantity])
        case .changeTextLineItemQuantity(let textLineItemId, let quantity):
            return filterJSON(parameters: ["action": "changeTextLineItemQuantity", "textLineItemId": textLineItemId, "quantity": quantity])
        case .changeTextLineItemName(let textLineItemId, let name):
            return filterJSON(parameters: ["action": "changeTextLineItemName", "textLineItemId": textLineItemId, "name": name])
        case .setTextLineItemDescription(let textLineItemId, let description):
            return filterJSON(parameters: ["action": "setTextLineItemDescription", "textLineItemId": textLineItemId, "description": description])
        case .changeTextLineItemsOrder(let textLineItemOrder):
            return filterJSON(parameters: ["action": "changeTextLineItemsOrder", "textLineItemOrder": textLineItemOrder])
        case .setTextLineItemCustomType(let lineItemId, let type, let fields):
            return filterJSON(parameters: ["action": "setTextLineItemCustomType", "lineItemId": lineItemId, "type": type, "fields": fields])
        case .setTextLineItemCustomField(let lineItemId, let name, let value):
            return filterJSON(parameters: ["action": "setTextLineItemCustomField", "lineItemId": lineItemId, "name": name, "value": value])
        case .setDeleteDaysAfterLastModification(let deleteDaysAfterLastModification):
            return filterJSON(parameters: ["action": "setDeleteDaysAfterLastModification", "deleteDaysAfterLastModification": deleteDaysAfterLastModification])
        }
    }
}

public struct Channel: Codable {

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
    public let custom: JsonValue?
    public let geoLocation: JsonValue?
    #if !os(Linux)
        public var location: CLLocation? {
            if let geoLocation = geoLocation, case .dictionary(let dictionary) = geoLocation,
                let coordinatesValue = dictionary["coordinates"], let typeValue = dictionary["type"],
                case .array(let coordinates) = coordinatesValue, case .string(let type) = typeValue,
                case .double(let latitude) = coordinates[1], case .double(let longitude) = coordinates[0],
                coordinates.count == 2 && type == "Point" {
                return CLLocation(latitude: latitude, longitude: longitude)
            }
            return nil
        }
    #endif
}

public enum ChannelRole: String, Codable {

    case inventorySupply = "InventorySupply"
    case productDistribution = "ProductDistribution"
    case orderExport =  "OrderExport"
    case orderImport = "OrderImport"
    case primary = "Primary"

}

public struct CustomLineItem: Codable {

    // MARK: - Properties

    public let id: String
    public let name: LocalizedString
    public let money: BaseMoney
    public let taxedPrice: TaxedItemPrice?
    public let totalPrice: Money
    public let slug: String
    public let quantity: Int
    public let state: ItemState
    public let taxCategory: Reference<TaxCategory>?
    public let taxRate: TaxRate?
    public let discountedPricePerQuantity: [DiscountedLineItemPriceForQuantity]
    public let custom: JsonValue?
    public let shippingDetails: ItemShippingDetails?

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(LocalizedString.self, forKey: .name)
        let money = try values.decode(MoneyContainer.self, forKey: .money)
        self.money = money.actualType
        taxedPrice = try? values.decode(TaxedItemPrice.self, forKey: .taxedPrice)
        totalPrice = try values.decode(Money.self, forKey: .totalPrice)
        slug = try values.decode(String.self, forKey: .slug)
        quantity = try values.decode(Int.self, forKey: .quantity)
        state = try values.decode(ItemState.self, forKey: .state)
        taxCategory = try? values.decode(Reference<TaxCategory>.self, forKey: .taxCategory)
        taxRate = try? values.decode(TaxRate.self, forKey: .taxRate)
        discountedPricePerQuantity = try values.decode([DiscountedLineItemPriceForQuantity].self, forKey: .discountedPricePerQuantity)
        custom = try? values.decode(JsonValue.self, forKey: .custom)
        shippingDetails = try? values.decode(ItemShippingDetails.self, forKey: .shippingDetails)
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(MoneyContainer.container(for: money), forKey: .money)
        try? container.encode(taxedPrice, forKey: .taxedPrice)
        try container.encode(totalPrice, forKey: .totalPrice)
        try container.encode(slug, forKey: .slug)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(state, forKey: .state)
        try? container.encode(taxCategory, forKey: .taxCategory)
        try? container.encode(taxRate, forKey: .taxRate)
        try container.encode(discountedPricePerQuantity, forKey: .discountedPricePerQuantity)
        try? container.encode(custom, forKey: .custom)
        try? container.encode(shippingDetails, forKey: .shippingDetails)
    }

    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case money
        case taxedPrice
        case totalPrice
        case slug
        case quantity
        case state
        case taxCategory
        case taxRate
        case discountedPricePerQuantity
        case custom
        case shippingDetails
    }
}

public struct CustomerDraft: Codable {

    // MARK: - Properties

    public var email: String
    public var password: String
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
    public var custom: JsonValue?
    public var locale: String?

    public init(email: String, password: String, firstName: String? = nil, lastName: String? = nil, middleName: String? = nil, title: String? = nil, dateOfBirth: Date? = nil, companyName: String? = nil, vatId: String? = nil, addresses: [Address]? = nil, defaultBillingAddress: Int? = nil, defaultShippingAddress: Int? = nil, custom: JsonValue? = nil, locale: String? = nil) {
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
}

public struct CustomerGroup: Codable {

    // MARK: - Properties

    public let id: String
    public let key: String?
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: String
    public let custom: JsonValue?
}

public struct CustomerSignInResult: Codable {

    // MARK: - Properties

    public let customer: Customer
    public let cart: Cart?
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
    case setCustomType(type: ResourceIdentifier?, fields: JsonValue?)
    case setCustomField(name: String, value: JsonValue?)
    case setLocale(locale: String)

    public var toJSON: [String: Any]? {
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
            return filterJSON(parameters: ["action": "addAddress", "address": address.toJSON])
        case .changeAddress(let addressId, let address):
            return filterJSON(parameters: ["action": "changeAddress", "addressId": addressId, "address": address.toJSON])
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
            return filterJSON(parameters: ["action": "setDateOfBirth", "dateOfBirth": dateOfBirth != nil ? dateFormatter.string(from: dateOfBirth!) : nil])
        case .setVatId(let vatId):
            return filterJSON(parameters: ["action": "setVatId", "vatId": vatId])
        case .setCustomType(let type, let fields):
            return filterJSON(parameters: ["action": "setCustomType", "type": type?.toJSON, "fields": fields?.toJSON])
        case .setCustomField(let name, let value):
            return filterJSON(parameters: ["action": "setCustomField", "name": name, "value": value?.toJSON])
        case .setLocale(let locale):
            return filterJSON(parameters: ["action": "setLocale", "locale": locale])
        }
    }
}

public struct Delivery: Codable {

    // MARK: - Properties

    public let id: String
    public let createdAt: Date
    public let items: [DeliveryItem]
    public let parcels: [Parcel]
}

public struct DeliveryItem: Codable {

    // MARK: - Properties

    public let id: String
    public let quantity: Int
}

public struct DiscountCode: Codable {

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
    public let groups: [String]
    public let isActive: Bool
    public let validFrom: Date?
    public let validUntil: Date?
    public let references: [GenericReference]
    public let maxApplications: Int?
    public let maxApplicationsPerCustomer: Int?
    public let custom: JsonValue?
}

public struct DiscountCodeInfo: Codable {

    // MARK: - Properties

    public let discountCode: Reference<DiscountCode>
    public let state: DiscountCodeState?
}

public enum DiscountCodeState: String, Codable {

    case notActive = "NotActive"
    case notValid = "NotValid"
    case doesNotMatchCart = "DoesNotMatchCart"
    case matchesCart = "MatchesCart"
    case maxApplicationReached = "MaxApplicationReached"
    case applicationStoppedByPreviousDiscount = "ApplicationStoppedByPreviousDiscount"

}

public struct DiscountedLineItemPortion: Codable {

    // MARK: - Properties

    public let discount: Reference<CartDiscount>
    public let discountedAmount: BaseMoney

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        discount = try values.decode(Reference<CartDiscount>.self, forKey: .discount)
        let discountedAmount = try values.decode(MoneyContainer.self, forKey: .discountedAmount)
        self.discountedAmount = discountedAmount.actualType
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(discount, forKey: .discount)
        try container.encode(MoneyContainer.container(for: discountedAmount), forKey: .discountedAmount)
    }

    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case discount
        case discountedAmount
    }
}

public struct DiscountedLineItemPrice: Codable {

    // MARK: - Properties

    public let value: BaseMoney
    public let includedDiscounts: [DiscountedLineItemPortion]

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let value = try values.decode(MoneyContainer.self, forKey: .value)
        self.value = value.actualType
        includedDiscounts = try values.decode([DiscountedLineItemPortion].self, forKey: .includedDiscounts)
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(MoneyContainer.container(for: value), forKey: .value)
        try container.encode(includedDiscounts, forKey: .includedDiscounts)
    }

    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case value
        case includedDiscounts
    }
}

public struct DiscountedLineItemPriceForQuantity: Codable {

    // MARK: - Properties

    public let quantity: Int
    public let discountedPrice: DiscountedLineItemPrice
}

public struct DiscountedPrice: Codable {

    // MARK: - Properties

    public let value: Money
    public let discount: Reference<ProductDiscount>
}

public struct ExternalLineItemTotalPrice: Codable {

    // MARK: - Properties

    public let price: BaseMoney
    public let totalPrice: Money

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let price = try values.decode(MoneyContainer.self, forKey: .price)
        self.price = price.actualType
        totalPrice = try values.decode(Money.self, forKey: .totalPrice)
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(MoneyContainer.container(for: price), forKey: .price)
        try container.encode(totalPrice, forKey: .totalPrice)
    }

    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case price
        case totalPrice
    }
}

public struct ExternalTaxRateDraft: Codable {

    // MARK: - Properties

    public var name: String
    public var amount: Double?
    public var country: String
    public var state: String?
    public var subRates: [SubRate]?

    public init(name: String, amount: Double? = nil, country: String, state: String? = nil, subRates: [SubRate]? = nil) {
        self.name = name
        self.amount = amount
        self.country = country
        self.state = state
        self.subRates = subRates
    }
}

public struct ItemShippingDetails: Codable {

    // MARK: - Properties

    public let targets: [ItemShippingTarget]
    public let valid: Bool
}

public struct ItemShippingTarget: Codable {

    // MARK: - Properties

    public let addressKey: String
    public let quantity: Int

    public init(addressKey: String, quantity: Int) {
        self.addressKey = addressKey
        self.quantity = quantity
    }
}

public struct Image: Codable {

    // MARK: - Properties

    public let url: String
    public let dimensions: [String: Int]
    public let label: String?
}

public enum InventoryMode: String, Codable {

    case trackOnly = "TrackOnly"
    case reserveOnOrder = "ReserveOnOrder"
    case none = "None"

}

public enum CartOrigin: String, Codable {

    case customer = "Customer"
    case merchant = "Merchant"

}

public struct ItemState: Codable {

    // MARK: - Properties

    public let quantity: Int
    public let state: Reference<State>
}

public typealias LocalizedString = [String: String]

public struct LineItem: Codable {

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
    public let custom: JsonValue?
    public let shippingDetails: ItemShippingDetails?
}

public struct TextLineItem: Codable {
    
    // MARK: - Properties
    
    public let id: String
    public let name: LocalizedString
    public let description: LocalizedString?
    public let quantity: Int
    public let custom: JsonValue?
    public let addedAt: Date
}

public class LineItemDraft: Codable {

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
    
    internal var productId: String?
    internal var variantId: Int?
    internal var sku: String?
    public var quantity: UInt?
    public var supplyChannel: Reference<Channel>?
    public var distributionChannel: Reference<Channel>?
    public var custom: JsonValue?
    public var shippingDetails: ItemShippingDetailsDraft?

    public init(productVariantSelection: ProductVariantSelection, quantity: UInt? = nil, supplyChannel: Reference<Channel>? = nil, distributionChannel: Reference<Channel>? = nil, custom: JsonValue? = nil, shippingDetails: ItemShippingDetailsDraft? = nil) {
        switch productVariantSelection {
        case .productVariant(let productId, let variantId):
            self.productId = productId
            self.variantId = variantId
            self.sku = nil
        case .sku(let sku):
            self.productId = nil
            self.variantId = nil
            self.sku = sku
        }
        self.quantity = quantity
        self.supplyChannel = supplyChannel
        self.distributionChannel = distributionChannel
        self.custom = custom
        self.shippingDetails = shippingDetails
    }
}

public struct ItemShippingDetailsDraft: Codable {
    public var targets: [ItemShippingTarget]
}

public enum LineItemPriceMode: String, Codable {

    case platform = "Platform"
    case externalPrice = "ExternalPrice"
    case externalTotal = "ExternalTotal"

}

public enum LineItemMode: String, Codable {

    case standard = "Standard"
    case giftLineItem = "GiftLineItem"

}

public struct Location: Codable {

    // MARK: - Properties

    public let country: String
    public let state: String?
}

public struct Money: BaseMoney, Codable {

    // MARK: - Properties

    public let currencyCode: String
    public let centAmount: Int
    
    public init(currencyCode: String, centAmount: Int) {
        self.currencyCode = currencyCode
        self.centAmount = centAmount
    }
}

public struct HighPrecisionMoney: BaseMoney, Codable {

    // MARK: - Properties

    public let currencyCode: String
    public let centAmount: Int
    public let preciseAmount: Int
    public let fractionDigits: Int

    public init(currencyCode: String, centAmount: Int, preciseAmount: Int, fractionDigits: Int) {
        self.currencyCode = currencyCode
        self.centAmount = centAmount
        self.preciseAmount = preciseAmount
        self.fractionDigits = fractionDigits
    }
}

public protocol BaseMoney: Codable {
    var currencyCode: String { get }
    var centAmount: Int { get }
}

struct MoneyContainer: Codable {

    // MARK: - Properties

    let type: MoneyType
    let currencyCode: String
    let centAmount: Int
    let preciseAmount: Int?
    let fractionDigits: Int?

    enum MoneyType: String, Codable {
        case centPrecision = "centPrecision"
        case highPrecision = "highPrecision"
    }

    var actualType: BaseMoney {
        switch type {
            case .centPrecision:
                return Money(currencyCode: currencyCode, centAmount: centAmount)
            case .highPrecision:
                return HighPrecisionMoney(currencyCode: currencyCode, centAmount: centAmount, preciseAmount: preciseAmount!, fractionDigits: fractionDigits!)
        }
    }

    static func container(for baseMoney: BaseMoney) -> MoneyContainer {
        switch baseMoney {
            case let money as Money:
                return MoneyContainer(type: .centPrecision, currencyCode: money.currencyCode, centAmount: money.centAmount, preciseAmount: nil, fractionDigits: nil)
            case let money as HighPrecisionMoney:
                return MoneyContainer(type: .highPrecision, currencyCode: money.currencyCode, centAmount: money.centAmount, preciseAmount: money.preciseAmount, fractionDigits: money.fractionDigits)
            default:
                fatalError("Unsupported BaseMoney value.")
        }
    }
}

public struct OrderDraft: Codable {

    // MARK: - Properties

    public var id: String
    public var version: UInt

    public init(id: String, version: UInt) {
        self.id = id
        self.version = version
    }
}

public enum OrderState: String, Codable {

    case `open` = "Open"
    case confirmed = "Confirmed"
    case complete = "Complete"
    case cancelled = "Cancelled"

}

public struct Parcel: Codable {

    // MARK: - Properties

    public let id: String
    public let createdAt: Date
    public let measurements: ParcelMeasurements?
    public let trackingData: TrackingData?
}

public struct ParcelMeasurements: Codable {

    // MARK: - Properties

    public let heightInMillimeter: Double
    public let lengthInMillimeter: Double
    public let widthInMillimeter: Double
    public let weightInGram: Double
}

public struct PaymentDraft: Codable {
    public var amountPlanned: Money
    public var paymentMethodInfo: PaymentMethodInfo?
    public var custom: JsonValue?
    public var transaction: TransactionDraft?

    public init(amountPlanned: Money, paymentMethodInfo: PaymentMethodInfo? = nil, custom: JsonValue? = nil, transaction: TransactionDraft? = nil) {
        self.amountPlanned = amountPlanned
        self.paymentMethodInfo = paymentMethodInfo
        self.custom = custom
        self.transaction = transaction
    }
}

public struct TransactionDraft: Codable {
    public var timestamp: Date?
    public var type: TransactionType
    public var amount: Money
    public var interactionId: String?

    public init(timestamp: Date? = nil, type: TransactionType, amount: Money, interactionId: String? = nil) {
        self.timestamp = timestamp
        self.type = type
        self.amount = amount
        self.interactionId = interactionId
    }
}

public enum PaymentUpdateAction: JSONRepresentable {

    case setMethodInfoInterface(interface: String)
    case setMethodInfoMethod(method: String?)
    case setMethodInfoName(name: LocalizedString?)
    case addTransaction(transaction: TransactionDraft)
    case setCustomField(name: String, value: JsonValue?)
    case changeAmountPlanned(amount: Money)

    public var toJSON: [String: Any]? {
        switch self {
        case .setMethodInfoInterface(let interface):
            return filterJSON(parameters: ["action": "setMethodInfoInterface", "interface": interface])
        case .setMethodInfoMethod(let method):
            return filterJSON(parameters: ["action": "setMethodInfoMethod", "method": method])
        case .setMethodInfoName(let name):
            return filterJSON(parameters: ["action": "setMethodInfoName", "name": name])
        case .addTransaction(let transaction):
            return filterJSON(parameters: ["action": "addTransaction", "transaction": transaction.toJSON])
        case .setCustomField(let name, let value):
            return filterJSON(parameters: ["action": "setCustomField", "name": name, "value": value?.toJSON])
        case .changeAmountPlanned(let amount):
            return filterJSON(parameters: ["action": "changeAmountPlanned", "amount": amount.toJSON])
        }
    }
}

public struct PaymentInfo: Codable {

    // MARK: - Properties

    public let payments: [Reference<Payment>]
}

public struct PaymentMethodInfo: Codable {

    // MARK: - Properties

    public let paymentInterface: String?
    public let method: String?
    public let name: LocalizedString?

    public init(paymentInterface: String? = nil, method: String? = nil, name: LocalizedString? = nil) {
        self.paymentInterface = paymentInterface
        self.method = method
        self.name = name
    }
}

public enum PaymentState: String, Codable {

    case balanceDue = "BalanceDue"
    case failed = "Failed"
    case pending = "Pending"
    case creditOwed = "CreditOwed"
    case paid = "Paid"

}

public struct PaymentStatus: Codable {

    // MARK: - Properties

    public let interfaceCode: String?
    public let interfaceText: String?
    public let state: Reference<State>?
}

public struct Price: Codable {

    // MARK: - Properties

    public let id: String
    public let value: BaseMoney
    public let country: String?
    public let customerGroup: Reference<CustomerGroup>?
    public let channel: Reference<Channel>?
    public let validFrom: Date?
    public let validUntil: Date?
    public let tiers: [PriceTier]?
    public let discounted: DiscountedPrice?
    public let custom: JsonValue?

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        let value = try values.decode(MoneyContainer.self, forKey: .value)
        self.value = value.actualType
        country = try? values.decode(String.self, forKey: .country)
        customerGroup = try? values.decode(Reference<CustomerGroup>.self, forKey: .customerGroup)
        channel = try? values.decode(Reference<Channel>.self, forKey: .channel)
        validFrom = try? values.decode(Date.self, forKey: .validFrom)
        validUntil = try? values.decode(Date.self, forKey: .validUntil)
        tiers = try? values.decode([PriceTier].self, forKey: .tiers)
        discounted = try? values.decode(DiscountedPrice.self, forKey: .discounted)
        custom = try? values.decode(JsonValue.self, forKey: .custom)
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(MoneyContainer.container(for: value), forKey: .value)
        try? container.encode(country, forKey: .country)
        try? container.encode(customerGroup, forKey: .customerGroup)
        try? container.encode(channel, forKey: .channel)
        try? container.encode(validFrom, forKey: .validFrom)
        try? container.encode(validUntil, forKey: .validUntil)
        try? container.encode(tiers, forKey: .tiers)
        try? container.encode(discounted, forKey: .discounted)
        try? container.encode(custom, forKey: .custom)
    }

    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case id
        case value
        case country
        case customerGroup
        case channel
        case validFrom
        case validUntil
        case tiers
        case discounted
        case custom
    }
}

public struct PriceTier: Codable {

    // MARK: - Properties

    public let minimumQuantity: UInt
    public let value: BaseMoney


    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        minimumQuantity = try values.decode(UInt.self, forKey: .minimumQuantity)
        let value = try values.decode(MoneyContainer.self, forKey: .value)
        self.value = value.actualType
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(minimumQuantity, forKey: .minimumQuantity)
        try container.encode(MoneyContainer.container(for: value), forKey: .value)
    }

    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case minimumQuantity
        case value
    }
}

public struct ProductDiscount: Codable {

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
    public let validFrom: Date?
    public let validUntil: Date?
    public let references: [GenericReference]
}

public struct ProductDiscountValue: Codable {

    // MARK: - Properties

    public let type: String
    public let permyriad: Int?
    public let money: Money?
}

public struct ProductVariant: Codable {

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
}

public struct ProductVariantAvailability: Codable {

    // MARK: - Properties

    public let isOnStock: Bool?
    public let restockableInDays: Int?
    public let availableQuantity: Int?
    public let channels: [String: ProductVariantAvailability]?
}

public struct Reference<T: Codable>: Codable {

    // MARK: - Properties

    public let id: String
    public let typeId: String
    public let obj: T?
    
    public init(id: String, typeId: String) {
        self.id = id
        self.typeId = typeId
        self.obj = nil
    }
}

public struct GenericReference: Codable {

    // MARK: - Properties

    public let id: String
    public let typeId: String
    
    public init(id: String, typeId: String) {
        self.id = id
        self.typeId = typeId
    }
}

public struct ResourceIdentifier: Codable {

    // MARK: - Properties

    public let id: String?
    public let typeId: String?
    public let key: String?

    public init(id: String? = nil, typeId: String? = nil, key: String? = nil) {
        self.id = id
        self.typeId = typeId
        self.key = key
    }
}

public struct ReturnInfo: Codable {

    // MARK: - Properties

    public let items: [ReturnItem]
    public let returnTrackingId: String
    public let returnDate: Date
}

public struct ReturnItem: Codable {

    // MARK: - Properties

    public let id: String
    public let quantity: Int
    public let lineItemId: String
    public let comment: String
    public let shipmentState: ReturnShipmentState
    public let paymentState: ReturnPaymentState
    public let lastModifiedAt: Date
    public let createdAt: Date
}

public enum ReturnPaymentState: String, Codable {

    case nonRefundable = "NonRefundable"
    case initial = "Initial"
    case refunded = "Refunded"
    case notRefunded = "NotRefunded"
}

public enum ReturnShipmentState: String, Codable {

    case advised = "Advised"
    case returned = "Returned"
    case backInStock = "BackInStock"
    case unusable = "Unusable"
}

public struct ReviewRatingStatistics: Codable {

    // MARK: - Properties

    public let averageRating: Double
    public let highestRating: Double
    public let lowestRating: Double
    public let count: UInt
    public let ratingsDistribution: JsonValue
}

public struct ScopedPrice: Codable {

    // MARK: - Properties

    public let id: String
    public let value: BaseMoney
    public let currentValue: BaseMoney
    public let country: String?
    public let customerGroup: Reference<CustomerGroup>?
    public let channel: Reference<Channel>?
    public let validFrom: Date?
    public let validUntil: Date?
    public let discounted: DiscountedPrice?
    public let custom: JsonValue?


    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        let value = try values.decode(MoneyContainer.self, forKey: .value)
        self.value = value.actualType
        let currentValue = try values.decode(MoneyContainer.self, forKey: .currentValue)
        self.currentValue = currentValue.actualType
        country = try? values.decode(String.self, forKey: .country)
        customerGroup = try? values.decode(Reference<CustomerGroup>.self, forKey: .customerGroup)
        channel = try? values.decode(Reference<Channel>.self, forKey: .channel)
        validFrom = try? values.decode(Date.self, forKey: .validFrom)
        validUntil = try? values.decode(Date.self, forKey: .validUntil)
        discounted = try? values.decode(DiscountedPrice.self, forKey: .discounted)
        custom = try? values.decode(JsonValue.self, forKey: .custom)
    }

    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(MoneyContainer.container(for: value), forKey: .value)
        try container.encode(MoneyContainer.container(for: currentValue), forKey: .currentValue)
        try? container.encode(country, forKey: .country)
        try? container.encode(customerGroup, forKey: .customerGroup)
        try? container.encode(channel, forKey: .channel)
        try? container.encode(validFrom, forKey: .validFrom)
        try? container.encode(validUntil, forKey: .validUntil)
        try? container.encode(discounted, forKey: .discounted)
        try? container.encode(custom, forKey: .custom)
    }

    // MARK: - Coding keys

    enum CodingKeys: String, CodingKey {
        case id
        case value
        case currentValue
        case country
        case customerGroup
        case channel
        case validFrom
        case validUntil
        case discounted
        case custom
    }
}

public struct SearchKeyword: Codable {

    // MARK: - Properties

    public let text: String
    public let suggestTokenizer: SuggestTokenizer?
}

public struct SuggestTokenizer: Codable {

    // MARK: - Properties

    public let type: String
    public let inputs: [String]?
}

public enum ShipmentState: String, Codable {

    case shipped = "Shipped"
    case ready = "Ready"
    case pending = "Pending"
    case delayed = "Delayed"
    case partial = "Partial"
    case backorder = "Backorder"
}


public struct ShippingInfo: Codable {

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
    public let shippingMethodState: ShippingMethodState
}

public enum ShippingMethodState: String, Codable {
    case doesNotMatchCart = "DoesNotMatchCart"
    case matchesCart = "MatchesCart"
}

public struct ShippingRate: Codable {

    // MARK: - Properties

    public let price: Money
    public let freeAbove: Money?
    public let isMatching: Bool?
}

public struct State: Codable {

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
}

public enum StateRole: String, Codable {

    case reviewIncludedInStatistics = "ReviewIncludedInStatistics"
}

public enum StateType: String, Codable {

    case orderState = "OrderState"
    case lineItemState = "LineItemState"
    case productState =  "ProductState"
    case reviewState = "ReviewState"
    case paymentState = "PaymentState"
}

public struct SubRate: Codable {

    // MARK: - Properties

    public let name: String
    public let amount: Double
    
    public init(name: String, amount: Double) {
        self.name = name
        self.amount = amount
    }
}

public struct SyncInfo: Codable {

    // MARK: - Properties

    public let channel: Reference<Channel>
    public let externalId: String?
    public let syncedAt: Date
}

public struct TaxCategory: Codable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let key: String?
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: String
    public let description: String?
    public let rates: [TaxRate]
}

public enum TaxMode: String, Codable {

    case platform = "Platform"
    case external = "External"
    case externalAmount = "ExternalAmount"
    case disabled = "Disabled"
}

public enum RoundingMode: String, Codable {

    case halfEven = "HalfEven"
    case halfUp = "HalfUp"
    case halfDown = "HalfDown"
}

public struct TaxRate: Codable {

    // MARK: - Properties

    public let id: String?
    public let name: String
    public let includedInPrice: Bool
    public let country: String
    public let state: String?
    public let subRates: [SubRate]
}

public struct TaxedItemPrice: Codable {

    // MARK: - Properties

    public let totalNet: Money
    public let totalGross: Money
}

public struct TaxedPrice: Codable {

    // MARK: - Properties

    public let totalNet: Money
    public let totalGross: Money
    public let taxPortions: [TaxPortion]
}

public struct TaxPortion: Codable {

	// MARK: - Properties
	
	public let name: String?
	public let rate: Double
	public let amount: Money
}

public struct TrackingData: Codable {

    // MARK: - Properties

    public let trackingId: String?
    public let carrier: String?
    public let provider: String?
    public let providerTransaction: String?
    public let isReturn: Bool?
}

public struct Transaction: Codable {

    // MARK: - Properties

    public let id: String
    public let timestamp: Date?
    public let type: TransactionType
    public let amount: Money
    public let interactionId: String?
    public let state: TransactionState
}

public enum TransactionState: String, Codable {

    case pending = "Pending"
    case initial = "Initial"
    case success = "Success"
    case failure = "Failure"
}

public enum TransactionType: String, Codable {

    case authorization = "Authorization"
    case cancelAuthorization = "CancelAuthorization"
    case charge =  "Charge"
    case refund = "Refund"
    case chargeback = "Chargeback"
}

public struct Zone: Codable {

    // MARK: - Properties

    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let name: String
    public let description: String?
    public let locations: [Location]
}

public struct ZoneRate: Codable {

    // MARK: - Properties

    public let zone: Reference<Zone>
    public let shippingRates: [ShippingRate]
}

public enum JsonValue: Codable {
    case bool(value: Bool)
    case int(value: Int)
    case double(value: Double)
    case string(value: String)
    case dictionary(value: [String: JsonValue])
    case array(value: [JsonValue])
    case unknown
    
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        if let string = try? value.decode(String.self) {
            self = .string(value: string)
        } else if let bool = try? value.decode(Bool.self) {
            self = .bool(value: bool)
        } else if let int = try? value.decode(Int.self) {
            self = .int(value: int)
        } else if let double = try? value.decode(Double.self) {
            self = .double(value: double)
        } else if let dictionary = try? value.decode([String: JsonValue].self) {
            self = .dictionary(value: dictionary)
        } else if let array = try? value.decode([JsonValue].self) {
            self = .array(value: array)
        } else {
            self = .unknown
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .dictionary(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .unknown:
            Log.error("Error while trying to encode unknown JsonValue")
        }
    }
    
    // MARK: - Convenience
    
    public var bool: Bool? {
        if case .bool(let value) = self {
            return value
        }
        return nil
    }
    public var int: Int? {
        if case .int(let value) = self {
            return value
        }
        return nil
    }
    public var double: Double? {
        if case .double(let value) = self {
            return value
        }
        return nil
    }
    public var string: String? {
        if case .string(let value) = self {
            return value
        }
        return nil
    }
    public var dictionary: [String: JsonValue]? {
        if case .dictionary(let value) = self {
            return value
        }
        return nil
    }
    public var array: [JsonValue]? {
        if case .array(let value) = self {
            return value
        }
        return nil
    }
}
