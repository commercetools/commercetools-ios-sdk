//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct CustomLineItemDraft: Mappable {

    // MARK: - Properties

    var name: LocalizedString?
    var quantity: UInt?
    var money: Money?
    var slug: String?
    var taxCategory: Reference<TaxCategory>?
    var externalTaxRate: ExternalTaxRateDraft?
    var custom: [String: Any]?

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
