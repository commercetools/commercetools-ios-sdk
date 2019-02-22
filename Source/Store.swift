//
// Copyright (c) 2018 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides set of interactions for querying, retrieving by UUID and by key for stores.
 */
public struct Store: QueryEndpoint, ByIdEndpoint, ByKeyEndpoint, Codable {

    public typealias ResponseType = Store

    public static let path = "stores"

    // MARK: - Properties

    public let id: String
    public let key: String
    public let name: LocalizedString?
    public let createdAt: Date
    public let lastModifiedAt: Date
}
