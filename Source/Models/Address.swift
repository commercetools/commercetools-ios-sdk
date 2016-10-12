//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct Address: Mappable {

    // MARK: - Properties

    var id: String?
    var title: String?
    var salutation: String?
    var firstName: String?
    var lastName: String?
    var streetName: String?
    var streetNumber: String?
    var city: String?
    var region: String?
    var postalCode: String?
    var additionalStreetInfo: String?
    var state: String?
    var country: String?
    var company: String?
    var department: String?
    var building: String?
    var apartment: String?
    var pOBox: String?
    var phone: String?
    var mobile: String?
    var email: String?
    var fax: String?
    var additionalAddressInfo: String?

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
