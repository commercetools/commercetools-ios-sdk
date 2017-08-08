//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Used to represent whether a result from an endpoint operation was successful or not.

    - Success: The result from the Commercetools endpoint and all post processing operations were successful
               resulting in the serialization of the returned data.
    - Failure: The result from the Commercetools endpoint encountered an error resulting in a failure. Provided status
               code and an array of errors should be used to examine the origin of the problem.
*/
public enum Result<T> {
    case success(Data)
    case failure(Int?, [Error])

    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }

    /// Returns the associated array of error values if the result is a failure, `nil` otherwise.
    public var errors: [Error]? {
        switch self {
        case .success:
            return nil
        case .failure(_, let errors):
            return errors
        }
    }

    /**
        Returns the status code from the failed response. In case the result was successful,
        or if the operation failed without performing a network request, no status code will be available.
    */
    public var statusCode: Int? {
        switch self {
        case .success:
            return nil
        case .failure(let statusCode, _):
            return statusCode
        }
    }
}

// MARK: - CustomStringConvertible

extension Result: CustomStringConvertible {
    /// The textual representation used when written to an output stream, which includes whether the result was a 
    /// success or failure.
    public var description: String {
        switch self {
        case .success:
            return "SUCCESS"
        case .failure:
            return "FAILURE"
        }
    }
}

// MARK: - CustomDebugStringConvertible

extension Result: CustomDebugStringConvertible {
    /// The debug textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure in addition to the response or errors.
    public var debugDescription: String {
        switch self {
        case .success(let value):
            return "SUCCESS: \(value)"
        case .failure(let statusCode, let errors):
            return "FAILURE: StatusCode: \(statusCode ?? -1), Errors: \(errors)"
        }
    }
}

extension Result {
    /// Returns the associated JSON response in dictionary format, if the result is a success, `nil` otherwise.
    public var json: [String: Any]? {
        if case .success(let data) = self, let response = try? JSONSerialization.jsonObject(with: data, options: []),
           let dict = response as? [String: Any] {
            return dict
        }
        return nil
    }
}

extension Result where T: Decodable {
    /// Returns the associated response, if the result is a success, `nil` otherwise.
    public var model: T? {
        if case .success(let data) = self {
            do {
                let model = try jsonDecoder.decode(T.self, from: data)
                return model
            } catch {
                Log.error("\(error)")
                return nil
            }
        }
        return nil
    }
}

public protocol ArrayResponse {
    associatedtype ArrayElement: Codable
}

extension Result where T: ArrayResponse {
    /// Returns the associated JSON response in dictionary format, if the result is a success, `nil` otherwise.
    public var json: [[String: Any]]? {
        if case .success(let data) = self, let response = try? JSONSerialization.jsonObject(with: data, options: []),
            let array = response as? [[String: Any]] {
            return array
        }
        return nil
    }

    /// Returns the associated array, if the result is a success, `nil` otherwise.
    public var model: [T.ArrayElement]? {
        if case .success(let data) = self {
            do {
                let model = try jsonDecoder.decode(Array<T.ArrayElement>.self, from: data)
                return model
            } catch {
                Log.error("\(error)")
                return nil
            }
        }
        return nil
    }
}
