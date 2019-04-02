//
// Copyright (c) 2018 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides a set of methods used for category recommendations machine learning endpoint.
*/
public struct CategoryRecommendations: MLEndpoint, Codable {

    public typealias ResponseType = PagedQueryResult<ProjectCategoryRecommendation, ProjectCategoryRecommendationMeta>

    public static let path = "recommendations/project-categories"

    /**
        Initiates a similar products search.

        - parameter productId:                Specific product ID to be used for searching for the best-fitting categories.
        - parameter staged:                   Flag to target either the staged or the current version of a product.
        - parameter confidenceMin:            An Optional min value for confidence bounds on the returned predictions.
        - parameter confidenceMax:            An Optional max value for confidence bounds on the returned predictions.
        - parameter limit:                    An optional parameter to limit the number of returned results.
        - parameter offset:                   An optional parameter to set the offset of the first returned result.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func query(productId: String, staged: Bool? = nil, confidenceMin: Double? = nil, confidenceMax: Double? = nil, limit: Int? = nil, offset: Int? = nil, result: @escaping (Result<ResponseType>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            var urlParameters = [String: String]()

            if let staged = staged {
                urlParameters["staged"] = staged ? "true" : "false"
            }
            if let confidenceMin = confidenceMin {
                urlParameters["confidenceMin"] = "\(confidenceMin)"
            }
            if let confidenceMax = confidenceMax {
                urlParameters["confidenceMax"] = "\(confidenceMax)"
            }
            if let limit = limit {
                urlParameters["limit"] = "\(limit)"
            }
            if let offset = offset {
                urlParameters["offset"] = "\(offset)"
            }

            let request = self.request(url: path + productId, urlParameters: urlParameters, headers: self.headers(token))

            perform(request: request) { (response: Result<ResponseType>) in
                result(response)
            }
        })
    }
}