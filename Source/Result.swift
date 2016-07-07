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
public enum Result<Response, Error: ErrorType> {
    case Success(Response)
    case Failure(Int?, [Error])

    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }

    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }

    /// Returns the associated response if the result is a success, `nil` otherwise.
    public var response: Response? {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }

    /// Returns the associated array of error values if the result is a failure, `nil` otherwise.
    public var errors: [Error]? {
        switch self {
        case .Success:
            return nil
        case .Failure(_, let errors):
            return errors
        }
    }

    /**
        Returns the status code from the failed response. In case the result was successful,
        or if the operation failed without performing a network request, no status code will be available.
    */
    public var statusCode: Int? {
        switch self {
        case .Success:
            return nil
        case .Failure(let statusCode, _):
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
        case .Success:
            return "SUCCESS"
        case .Failure:
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
        case .Success(let value):
            return "SUCCESS: \(value)"
        case .Failure(let statusCode, let errors):
            return "FAILURE: StatusCode: \(statusCode ?? -1), Errors: \(errors)"
        }
    }
}
