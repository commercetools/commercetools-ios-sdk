//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

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
    }

}
