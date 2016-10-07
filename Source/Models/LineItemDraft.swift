//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

public struct LineItemDraft: Mappable {

    // MARK: - Properties

    var productId: String?
    var variantId: Int?
    var quantity: UInt?
    var supplyChannel: Reference<Channel>?
    var distributionChannel: Reference<Channel>?
    var externalTaxRate: ExternalTaxRateDraft?
    var custom: [String: Any]?

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
