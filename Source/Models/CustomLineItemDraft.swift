//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

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
