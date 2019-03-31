//
// Copyright (c) 2018 Commercetools. All rights reserved.
//

import Foundation

/**
    Provides a set of methods used for similar products machine learning endpoint.
*/
public struct SimilarProducts: MLEndpoint, Codable {

    public typealias ResponseType = TaskToken

    public static let path = "similarities/products"

    /**
        Initiates a similar products search.

        - parameter request:                  A `SimilarProductSearchRequest` specifying search parameters.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func initiateSearch(request: SimilarProductSearchRequest, result: @escaping (Result<ResponseType>) -> Void) {
        do {
            let data = try jsonEncoder.encode(request)
            requestWithTokenAndPath(result, { token, path in
                let request = self.request(url: path, method: .post, queryItems: [], json: data, headers: self.headers(token))

                perform(request: request) { (response: Result<ResponseType>) in
                    result(response)
                }
            })
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    /**
        Retrieves a status for a previously initiated similar products search. The status response can contain results if the task status state is `.success`.

        - parameter taskId:                   A `taskId` from a previously initiated similar products search.
        - parameter result:                   The code to be executed after processing the response.
    */
    public static func status(for taskId: String, result: @escaping (Result<TaskStatus<PagedQueryResult<SimilarProductPair, SimilarProductSearchRequestMeta>>>) -> Void) {
        requestWithTokenAndPath(result, { token, path in
            let request = self.request(url: "\(path)/status/\(taskId)", headers: self.headers(token))

            perform(request: request) { (response: Result<TaskStatus<PagedQueryResult<SimilarProductPair, SimilarProductSearchRequestMeta>>>) in
                result(response)
            }
        })
    }
}