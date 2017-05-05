//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/**
    Provides complete set of interactions for querying and retrieving product projections.
*/
open class ProductProjection: QueryEndpoint, ByIdEndpoint, ByKeyEndpoint, Mappable {

    public typealias ResponseType = ProductProjection

    // MARK: - Properties

    open static let path = "product-projections"

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
        - parameter filterQuery:              An optional filter to be applied to the search results
                                              (before facets have been calculated).
        - parameter filterFacets:             An optional filter for all facets calculations.
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
    open static func search(staged: Bool? = nil, sort: [String]? = nil, expansion: [String]? = nil, limit: UInt? = nil,
                            offset: UInt? = nil, lang: Locale = Locale.current, text: String? = nil,
                            fuzzy: Bool? = nil, fuzzyLevel: Int? = nil, filters: [String]? = nil, filterQuery: String? = nil,
                            filterFacets: String? = nil, facets: [String]? = nil, markMatchingVariants: Bool? = nil,
                            priceCurrency: String? = nil, priceCountry: String? = nil, priceCustomerGroup: String? = nil,
                            priceChannel: String? = nil, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {

        var parameters = paramsWithStaged(staged, params: queryParameters(predicates: nil, sort: sort,
                limit: limit, offset: offset))
        parameters = searchParams(lang: lang, text: text, fuzzy: fuzzy, fuzzyLevel: fuzzyLevel, filters: filters,
                filterQuery: filterQuery, filterFacets: filterFacets, facets: facets, markMatchingVariants: markMatchingVariants,
                priceCurrency: priceCurrency, priceCountry: priceCountry, priceCustomerGroup: priceCustomerGroup,
                priceChannel: priceChannel, params: parameters)

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion("\(path)search", expansion: expansion)

            Alamofire.request(fullPath, parameters: parameters, encoding: URLEncoding.queryString, headers: self.headers(token))
                    .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                        handleResponse(response, result: result)
                    })
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
    open static func suggest(staged: Bool? = nil, limit: UInt? = nil, lang: Locale = Locale.current,
                             searchKeywords: String, fuzzy: Bool? = nil, result: @escaping (Result<NoMapping>) -> Void) {

        var parameters = paramsWithStaged(staged, params: queryParameters(limit: limit))
        parameters = searchParams(fuzzy: fuzzy)
        parameters["searchKeywords." + searchLanguage(for: lang)] = searchKeywords as NSString

        requestWithTokenAndPath(result, { token, path in
            Alamofire.request("\(path)suggest", parameters: parameters, encoding: URLEncoding.queryString, headers: self.headers(token))
                    .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                        handleResponse(response, result: result)
                    })
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
    open static func query(staged: Bool? = nil, predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil,
                           limit: UInt? = nil, offset: UInt? = nil, result: @escaping (Result<QueryResponse<ResponseType>>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path, expansion: expansion)
            let parameters = paramsWithStaged(staged, params: queryParameters(predicates: predicates, sort: sort,
                    limit: limit, offset: offset))

            Alamofire.request(fullPath, parameters: parameters, encoding: URLEncoding.queryString, headers: self.headers(token))
                    .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                        handleResponse(response, result: result)
                    })
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
    open static func byId(_ id: String, staged: Bool? = nil, expansion: [String]? = nil, result: @escaping (Result<ResponseType>) -> Void) {

        requestWithTokenAndPath(result, { token, path in
            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(fullPath, parameters: paramsWithStaged(staged), encoding: URLEncoding.queryString, headers: self.headers(token))
                    .responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
                        handleResponse(response, result: result)
                    })
        })
    }

    // MARK: - Properties

    public var id: String?
    public var key: String?
    public var version: UInt?
    public var createdAt: Date?
    public var lastModifiedAt: Date?
    public var productType: Reference<ProductType>?
    public var name: LocalizedString?
    public var description: LocalizedString?
    public var slug: LocalizedString?
    public var categories: [Reference<Category>]?
    public var categoryOrderHints: [String: String]?
    public var metaTitle: LocalizedString?
    public var metaDescription: LocalizedString?
    public var metaKeywords: LocalizedString?
    public var searchKeywords: [String: [SearchKeyword]]?
    public var hasStagedChanges: Bool?
    public var published: Bool?
    public var masterVariant: ProductVariant?
    public var variants: [ProductVariant]?
    /// The union of `masterVariant` and other`variants`.
    public var allVariants: [ProductVariant] {
        var allVariants = [ProductVariant]()
        if let masterVariant = masterVariant {
            allVariants.append(masterVariant)
        }
        if let otherVariants = variants {
            allVariants += otherVariants
        }
        return allVariants
    }
    public var taxCategory: Reference<TaxCategory>?
    public var state: Reference<State>?
    public var reviewRatingStatistics: ReviewRatingStatistics?

    public required init?(map: Map) {}

    // MARK: - Mappable

    public func mapping(map: Map) {
        id                      <- map["id"]
        key                     <- map["key"]
        version                 <- map["version"]
        createdAt               <- (map["createdAt"], ISO8601DateTransform())
        lastModifiedAt          <- (map["lastModifiedAt"], ISO8601DateTransform())
        productType             <- map["productType"]
        name                    <- map["name"]
        description             <- map["description"]
        slug                    <- map["slug"]
        categories              <- map["categories"]
        categoryOrderHints      <- map["categoryOrderHints"]
        metaTitle               <- map["metaTitle"]
        metaDescription         <- map["metaDescription"]
        metaKeywords            <- map["metaKeywords"]
        searchKeywords          <- map["searchKeywords"]
        hasStagedChanges        <- map["hasStagedChanges"]
        published               <- map["published"]
        masterVariant           <- map["masterVariant"]
        variants                <- map["variants"]
        taxCategory             <- map["taxCategory"]
        state                   <- map["state"]
        reviewRatingStatistics  <- map["reviewRatingStatistics"]
    }

    // MARK: - Helpers

    private static func paramsWithStaged(_ staged: Bool?, params: [String: Any]? = nil) -> [String: Any] {
        var params = params ?? [String: Any]()

        if let staged = staged {
            params["staged"] = staged ? "true" : "false"
        }

        return params
    }

    private static func searchParams(lang: Locale = Locale.current, text: String? = nil, fuzzy: Bool? = nil,
                                     fuzzyLevel: Int? = nil, filters: [String]? = nil, filterQuery: String? = nil,
                                     filterFacets: String? = nil, facets: [String]? = nil, markMatchingVariants: Bool? = nil,
                                     priceCurrency: String? = nil, priceCountry: String? = nil, priceCustomerGroup: String? = nil,
                                     priceChannel: String? = nil, params: [String: Any]? = nil) -> [String: Any] {
        var params = params ?? [String: Any]()

        if let text = text {
            params["text." + searchLanguage(for: lang)] = text
        }

        if let fuzzy = fuzzy {
            params["fuzzy"] = fuzzy ? "true" : "false"
        }

        if let fuzzyLevel = fuzzyLevel {
            params["fuzzyLevel"]  = fuzzyLevel
        }

        if let filters = filters, filters.count > 0 {
            params["filter"] = filters
        }

        if let filterQuery = filterQuery {
            params["filter.query"] = filterQuery
        }

        if let filterFacets = filterFacets {
            params["filter.facets"] = filterFacets
        }

        if let facets = facets, facets.count > 0 {
            params["facet"] = facets
        }

        if let markMatchingVariants = markMatchingVariants {
            params["markMatchingVariants"] = markMatchingVariants ? "true" : "false"
        }

        if let priceCurrency = priceCurrency {
            params["priceCurrency"] = priceCurrency
        }

        if let priceCountry = priceCountry {
            params["priceCountry"] = priceCountry
        }

        if let priceCustomerGroup = priceCustomerGroup {
            params["priceCustomerGroup"] = priceCustomerGroup
        }

        if let priceChannel = priceChannel {
            params["priceChannel"] = priceChannel
        }

        return params
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
        if projectLanguages?.contains(localeIdentifier) == true {
            return localeIdentifier
        } else if let languageCode = locale.languageCode, projectLanguages?.contains(languageCode) == true {
            return languageCode
        } else {
            return projectLanguages?.first ?? locale.identifier
        }
    }
}
