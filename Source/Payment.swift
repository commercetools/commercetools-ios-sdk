//
// Copyright (c) 2017 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides complete set of interactions for querying, retrieving, creating and updating payments.
 */
public struct Payment: QueryEndpoint, ByIdEndpoint, CreateEndpoint, UpdateEndpoint, DeleteEndpoint, Codable {
    
    public typealias ResponseType = Payment
    public typealias RequestDraft = PaymentDraft
    public typealias UpdateAction = PaymentUpdateAction
    
    public static let path = "me/payments"
    
    // MARK: - Properties
    
    public let id: String
    public let version: UInt
    public let createdAt: Date
    public let createdBy: CreatedBy?
    public let lastModifiedAt: Date
    public let lastModifiedBy: LastModifiedBy?
    public let customer: Reference<Customer>?
    public let anonymousId: String?
    public let amountPlanned: Money
    public let paymentMethodInfo: PaymentMethodInfo
    public let transactions: [Transaction]
    public let custom: JsonValue?
}
