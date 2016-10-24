//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import ObjectMapper

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
