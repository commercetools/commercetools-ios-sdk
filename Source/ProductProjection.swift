//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Dispatch

/**
    Provides complete set of interactions for querying and retrieving product projections.
*/
public struct ProductProjection: QueryEndpoint, ByIdEndpoint, ByKeyEndpoint, Codable {

    public typealias ResponseType = ProductProjection

    // MARK: - Properties

    public static let path = "product-projections"

    // MARK: - Product projection endpoint functionality

    /**
        Full-text search queries over product projections endpoint.

        - parameter staged:                   An optional bool value, determining whether to query
                                              for the current or staged projections.
        - parameter sort:                     An optional array of sort options used for sorting the results.
        - parameter expansion:                An optional array of expansion property names.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter offset:                   An optional parameter to set the offset of the first returned result.
        - parameter lang:                     Locale for text search. If no locale is provided, current locale will be
                                              the default value.
        - parameter text:                     Localized text to analyze and search for.
        - parameter fuzzy:                    An optional parameter determining whether to apply fuzzy search on
                                              the text to analyze.
        - parameter fuzzyLevel:               An optional `Int`, which if used, explicitly sets the desired
                                              fuzzy level, if `fuzzy` is enabled.
        - parameter filters:                  An optional array of filters to be applied to the search results
                                              (after facets have been calculated).
        - parameter filterQuery:              An optional array of filters to be applied to the search results
                                              (before facets have been calculated).
        - parameter filterFacets:             An optional array of filters for all facets calculations.
        - parameter facets:                   An optional facets param used for calculating statistical counts
                                              to aid in faceted navigation.
        - parameter markMatchingVariants:     An optional boolean, specifying whether to mark product variants
                                              in the search result matching the criteria.
        - parameter priceCurrency:            An optional currency code compliant to ISO 4217.
        - parameter priceCountry:             An optional two-digit country code as per ISO 3166-1 alpha-2.
        - parameter priceCustomerGroup:       An optional price customer group UUID.
        - parameter priceChannel:             An optional price channel UUID.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func search(staged: Bool? = nil, sort: [String]? = nil, expansion: [String]? = nil, limit: UInt? = nil,
                            offset: UInt? = nil, lang: Locale = Locale.current, text: String? = nil,
                            fuzzy: Bool? = nil, fuzzyLevel: Int? = nil, filters: [String]? = nil, filterQuery: [String]? = nil,
                            filterFacets: [String]? = nil, facets: [String]? = nil, markMatchingVariants: Bool? = nil,
                            priceCurrency: String? = nil, priceCountry: String? = nil, priceCustomerGroup: String? = nil,
                            priceChannel: String? = nil, result: @escaping (Result<SearchResponse>) -> Void) {

        var parameters = queryParameters(predicates: nil, sort: sort, limit: limit, offset: offset)
        if let staged = staged {
            parameters.append(URLQueryItem(name: "staged", value: staged ? "true" : "false"))
        }
        parameters += searchParams(lang: lang, text: text, fuzzy: fuzzy, fuzzyLevel: fuzzyLevel, filters: filters,
                filterQuery: filterQuery, filterFacets: filterFacets, facets: facets, markMatchingVariants: markMatchingVariants,
                priceCurrency: priceCurrency, priceCountry: priceCountry, priceCustomerGroup: priceCustomerGroup,
                priceChannel: priceChannel)

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion("\(path)search", expansion: expansion)
            let request = self.request(url: fullPath, queryItems: parameters, headers: self.headers(token))

            perform(request: request) { (response: Result<SearchResponse>) in
                result(response)
            }
        })
    }

    /**
        Retrieves suggestions based on the `searchKeyword` product field.

        - parameter staged:                   An optional bool value, determining whether to query
                                              for the current or staged projections.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter lang:                     Locale for text search. If no locale is provided, current locale will be
                                              the default value.
        - parameter searchKeywords:           Localized text to analyze retrieve suggestions for.
        - parameter fuzzy:                    An optional parameter determining whether to apply fuzzy search on
                                              the text to analyze.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func suggest(staged: Bool? = nil, limit: UInt? = nil, lang: Locale = Locale.current,
                             searchKeywords: String, fuzzy: Bool? = nil, result: @escaping (Result<NoMapping>) -> Void) {

        var parameters = queryParameters(limit: limit)
        if let staged = staged {
            parameters.append(URLQueryItem(name: "staged", value: staged ? "true" : "false"))
        }
        parameters += searchParams(fuzzy: fuzzy)
        parameters.append(URLQueryItem(name: "searchKeywords." + searchLanguage(for: lang), value: searchKeywords))

        requestWithTokenAndPath(result, { token, path in
            let request = self.request(url: "\(path)suggest", queryItems: parameters, headers: self.headers(token))

            perform(request: request) { (response: Result<NoMapping>) in
                result(response)
            }
        })
    }

    /**
        Queries for product projection.

        - parameter staged:                   An optional bool value, determining whether to query
                                              for the current or staged projections.
        - parameter predicate:                An optional array of predicates used for querying for  product projections.
        - parameter sort:                     An optional array of sort options used for sorting the results.
        - parameter expansion:                An optional array of expansion property names.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter offset:                   An optional parameter to set the offset of the first returned result.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func query(staged: Bool? = nil, predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil,
                           limit: UInt? = nil, offset: UInt? = nil, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)

            var parameters = queryParameters(predicates: predicates, sort: sort, limit: limit, offset: offset)
            if let staged = staged {
                parameters.append(URLQueryItem(name: "staged", value: staged ? "true" : "false"))
            }

            let request = self.request(url: fullPath, queryItems: parameters, headers: self.headers(token))

            perform(request: request) { (response: Result<QueryResponse<ResponseType>>) in
                result(response)
            }
        })
    }

    /**
        Retrieves a product projection by UUID.

        - parameter staged:                   An optional bool value, determining whether to retrieve current or staged
                                              product projection variant.
        - parameter id:                       Unique ID of the product projection to be retrieved.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func byId(_ id: String, staged: Bool? = nil, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            var parameters = [URLQueryItem]()
            if let staged = staged {
                parameters.append(URLQueryItem(name: "staged", value: staged ? "true" : "false"))
            }

            let request = self.request(url: fullPath, queryItems: parameters, headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        })
    }

    // MARK: - Properties

    public let id: String
    public let key: String?
    public let version: UInt
    public let createdAt: Date
    public let lastModifiedAt: Date
    public let productType: Reference<ProductType>
    public let name: LocalizedString
    public let description: LocalizedString?
    public let slug: LocalizedString
    public let categories: [Reference<Category>]
    public let categoryOrderHints: [String: String]?
    public let metaTitle: LocalizedString?
    public let metaDescription: LocalizedString?
    public let metaKeywords: LocalizedString?
    public let searchKeywords: [String: [SearchKeyword]]
    public let hasStagedChanges: Bool
    public let published: Bool
    public let masterVariant: ProductVariant
    public let variants: [ProductVariant]
    /// The union of `masterVariant` and other`variants`.
    public var allVariants: [ProductVariant] {
        var allVariants = [masterVariant]
        allVariants += variants
        return allVariants
    }
    public let taxCategory: Reference<TaxCategory>?
    public let state: Reference<State>?
    public let reviewRatingStatistics: ReviewRatingStatistics?

    // MARK: - Helpers

    private static func searchParams(lang: Locale = Locale.current, text: String? = nil, fuzzy: Bool? = nil,
                                     fuzzyLevel: Int? = nil, filters: [String]? = nil, filterQuery: [String]? = nil,
                                     filterFacets: [String]? = nil, facets: [String]? = nil, markMatchingVariants: Bool? = nil,
                                     priceCurrency: String? = nil, priceCountry: String? = nil, priceCustomerGroup: String? = nil,
                                     priceChannel: String? = nil) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        if let text = text {
            queryItems.append(URLQueryItem(name: "text." + searchLanguage(for: lang), value: text))
        }

        if let fuzzy = fuzzy {
            queryItems.append(URLQueryItem(name: "fuzzy", value: fuzzy ? "true" : "false"))
        }

        if let fuzzyLevel = fuzzyLevel {
            queryItems.append(URLQueryItem(name: "fuzzyLevel", value: String(fuzzyLevel)))
        }

        filters?.forEach {
            queryItems.append(URLQueryItem(name: "filter", value: $0))
        }

        filterQuery?.forEach {
            queryItems.append(URLQueryItem(name: "filter.query", value: $0))
        }

        filterFacets?.forEach {
            queryItems.append(URLQueryItem(name: "filter.facets", value: $0))
        }

        facets?.forEach {
            queryItems.append(URLQueryItem(name: "facet", value: $0))
        }

        if let markMatchingVariants = markMatchingVariants {
            queryItems.append(URLQueryItem(name: "markMatchingVariants", value: markMatchingVariants ? "true" : "false"))
        }

        if let priceCurrency = priceCurrency {
            queryItems.append(URLQueryItem(name: "priceCurrency", value: priceCurrency))
        }

        if let priceCountry = priceCountry {
            queryItems.append(URLQueryItem(name: "priceCountry", value: priceCountry))
        }

        if let priceCustomerGroup = priceCustomerGroup {
            queryItems.append(URLQueryItem(name: "priceCustomerGroup", value: priceCustomerGroup))
        }

        if let priceChannel = priceChannel {
            queryItems.append(URLQueryItem(name: "priceChannel", value: priceChannel))
        }

        return queryItems
    }

    private static func searchLanguage(for locale: Locale) -> String {
        var projectLanguages = Project.cached?.languages
        if projectLanguages == nil {
            let semaphore = DispatchSemaphore(value: 0)
            Project.settings { result in
                projectLanguages = result.model?.languages
                semaphore.signal()
            }
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        }

        let localeIdentifier = locale.identifier.replacingOccurrences(of: "_", with: "-")
        if let language = projectLanguages?.filter({ $0.hasPrefix(localeIdentifier) }).first {
            return language
        } else if let languageCode = locale.languageCode, let language = projectLanguages?.filter({ $0.hasPrefix(languageCode) }).first {
            return language
        } else {
            return projectLanguages?.first ?? locale.identifier
        }
    }
}

public struct SearchResponse: Codable {

    // MARK: - Properties

    public let offset: UInt
    public let count: UInt
    public let total: UInt
    public let results: [ProductProjection]
    public let facets: JsonValue
}