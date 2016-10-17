//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

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
    case setDefaultBillingAddress(options: SetDefaultBillingAddressOptions)
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
        case .setDefaultBillingAddress(let options):
            var optionsJSON = toJSON(options)
            optionsJSON["action"] = "setDefaultBillingAddress"
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

    func toJSON<T: Mappable>(_ options: T) -> [String: Any] {
        return Mapper<T>().toJSON(options)
    }
}

public struct ChangeEmailOptions: Mappable {

    // MARK: - Properties

    var email: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        email                        <- map["email"]
    }
}

public struct SetFirstNameOptions: Mappable {

    // MARK: - Properties

    var firstName: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        firstName                   <- map["firstName"]
    }
}

public struct SetLastNameOptions: Mappable {

    // MARK: - Properties

    var lastName: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        lastName                    <- map["lastName"]
    }
}

public struct SetMiddleNameOptions: Mappable {

    // MARK: - Properties

    var middleName: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        middleName                  <- map["middleName"]
    }
}

public struct SetTitleOptions: Mappable {

    // MARK: - Properties

    var title: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        title                      <- map["title"]
    }
}

public struct AddAddressOptions: Mappable {

    // MARK: - Properties

    var address: Address?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        address                     <- map["address"]
    }
}

public struct ChangeAddressOptions: Mappable {

    // MARK: - Properties

    var addressId: String?
    var address: Address?

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

    var addressId: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        addressId                   <- map["addressId"]
    }
}

public struct SetDefaultShippingAddressOptions: Mappable {

    // MARK: - Properties

    var addressId: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        addressId                   <- map["addressId"]
    }
}

public struct SetDefaultBillingAddressOptions: Mappable {

    // MARK: - Properties

    var addressId: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        addressId                   <- map["addressId"]
    }
}

public struct SetCompanyNameOptions: Mappable {

    // MARK: - Properties

    var companyName: String?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        companyName                <- map["companyName"]
    }
}

public struct SetDateOfBirthOptions: Mappable {

    // MARK: - Properties

    var dateOfBirth: Date?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        dateOfBirth                <- (map["dateOfBirth"], ISO8601DateTransform())
    }
}

public struct SetVatIdOptions: Mappable {

    // MARK: - Properties

    var vatId: Date?

    public init() {}
    public init?(map: Map) {}

    // MARK: - Mappable

    mutating public func mapping(map: Map) {
        vatId                      <- map["vatId"]
    }
}