//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation
import Alamofire

/**
    Provides complete set of interactions for querying, retrieving and creating an order.
*/
public class ProductProjection: QueryEndpoint, ByIdEndpoint {

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
        - parameter filter:                   An optional filter to be applied to the search results
                                              (after facets have been calculated).
        - parameter filterQuery:              An optional filter to be applied to the search results
                                              (before facets have been calculated).
        - parameter filterFacets:             An optional filter for all facets calculations.
        - parameter facets:                   An optional facets param used for calculating statistical counts
                                              to aid in faceted navigation.
        - parameter priceCurrency:            An optional currency code compliant to ISO 4217.
        - parameter priceCountry:             An optional two-digit country code as per ISO 3166-1 alpha-2.
        - parameter priceCustomerGroup:       An optional price customer group UUID.
        - parameter priceChannel:             An optional price channel UUID.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func search(staged staged: Bool? = nil, sort: [String]? = nil, expansion: [String]? = nil, limit: UInt? = nil,
                              offset: UInt? = nil, lang: NSLocale = NSLocale.currentLocale(), text: String? = nil,
                              fuzzy: Bool? = nil, filter: String? = nil, filterQuery: String? = nil, filterFacets: String? = nil,
                              facets: [String]? = nil, priceCurrency: String? = nil, priceCountry: String? = nil,
                              priceCustomerGroup: String? = nil, priceChannel: String? = nil,
                              result: (Result<[String: AnyObject], NSError>) -> Void) {

        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute query command - check if the configuration is valid.")
            result(Result.Failure([Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion("\(path)search", expansion: expansion)

            var parameters = paramsWithStaged(staged, params: queryParameters(predicates: nil, sort: sort,
                    limit: limit, offset: offset))
            parameters = searchParams(lang: lang, text: text, fuzzy: fuzzy, filter: filter, filterQuery: filterQuery,
                    filterFacets: filterFacets, facets: facets, priceCurrency: priceCurrency,
                    priceCountry: priceCountry, priceCustomerGroup: priceCustomerGroup,
                    priceChannel: priceChannel, params: parameters)

            Alamofire.request(.GET, fullPath, parameters: parameters, encoding: .URL, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
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
    public static func query(staged staged: Bool? = nil, predicates: [String]? = nil, sort: [String]? = nil, expansion: [String]? = nil,
                      limit: UInt? = nil, offset: UInt? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute query command - check if the configuration is valid.")
            result(Result.Failure([Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion(path, expansion: expansion)
            let parameters = paramsWithStaged(staged, params: queryParameters(predicates: predicates, sort: sort,
                                              limit: limit, offset: offset))

            Alamofire.request(.GET, fullPath, parameters: parameters, encoding: .URL, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }

    /**
        Retrieves a product projection by UUID.

        - parameter staged:                   An optional bool value, determining whether to retrieve current or staged
                                              product projection variant.
        - parameter id:                       Unique ID of the product projection to be retrieved.
        - parameter expansion:                An optional array of expansion property names.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func byId(id: String, staged: Bool? = nil, expansion: [String]? = nil, result: (Result<[String: AnyObject], NSError>) -> Void) {
        guard let config = Config.currentConfig, path = fullPath where config.validate() else {
            Log.error("Cannot execute byId command - check if the configuration is valid.")
            result(Result.Failure([Error.error(code: .GeneralCommercetoolsError)]))
            return
        }

        AuthManager.sharedInstance.token { token, error in
            guard let token = token else {
                result(Result.Failure([error ?? Error.error(code: .GeneralCommercetoolsError)]))
                return
            }

            let fullPath = pathWithExpansion(path + id, expansion: expansion)

            Alamofire.request(.GET, fullPath, parameters: paramsWithStaged(staged), encoding: .URL, headers: self.headers(token))
            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
                handleResponse(response, result: result)
            })
        }
    }

    // MARK: - Helpers

    private static func paramsWithStaged(staged: Bool?, params: [String: AnyObject]? = nil) -> [String: AnyObject] {
        var params = params ?? [String: AnyObject]()

        if let staged = staged {
            params["staged"] = staged ? "true" : "false"
        }

        return params
    }

    private static func searchParams(lang lang: NSLocale, text: String? = nil, fuzzy: Bool?,
                                     filter: String?, filterQuery: String?, filterFacets: String?, facets: [String]?,
                                     priceCurrency: String?, priceCountry: String?, priceCustomerGroup: String?, priceChannel: String?,
                                     params: [String: AnyObject]? = nil) -> [String: AnyObject] {
        var params = params ?? [String: AnyObject]()

        if let text = text {
            params["text." + lang.localeIdentifier.stringByReplacingOccurrencesOfString("_", withString: "-")] = text
        }

        if let fuzzy = fuzzy {
            params["fuzzy"] = fuzzy ? "true" : "false"
        }

        if let filter = filter {
            params["filter"] = filter
        }

        if let filterQuery = filterQuery {
            params["filter.query"] = filterQuery
        }

        if let filterFacets = filterFacets {
            params["filter.facets"] = filterFacets
        }

        if let facets = facets where facets.count > 0 {
            params["facet"] = facets
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

}