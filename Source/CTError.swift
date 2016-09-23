//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/// `CTError` is the error type returned by Commercetools SDK. It includes a few different error cases, each with
/// descriptive failure reason.
///
/// - configurationValidationFailed:    Returned if the Commercetools SDK configuration hasn't been properly set.
/// - accessTokenRetrievalFailed:       Returned when there is an issue obtaining the access token.
/// - invalidJsonInputError:            Returned in case of badly formed request.
/// - resourceNotFoundError:            Returned when a requested object was not found.
/// - concurrentModificationError:      Returned in case when the incorrect version is passed to either `create`, `update`, or `delete` method.
/// - insufficientTokenGrantTypeError:  Returned when an operation for which your project credentials do not have permission is performed.
/// - generalError:                     The default error case, containing optional failure reason.
public enum CTError: Error {

    /// Used to store error information returned from Commercetools platform.
    public struct FailureReason {

        /// The error message returned by the API.
        let message: String?

        /// The detailed description when returned as a value of the `detailedErrorMessage` response field.
        let details: String?
    }
    
    case configurationValidationFailed
    case accessTokenRetrievalFailed(reason: FailureReason)
    case invalidJsonInputError(reason: FailureReason)
    case resourceNotFoundError(reason: FailureReason)
    case concurrentModificationError(reason: FailureReason, currentVersion: UInt?)
    case insufficientTokenGrantTypeError(reason: FailureReason)
    case generalError(reason: FailureReason?)

    // MARK: - Lifecycle

    init(code: String, failureMessage: String?, failureDetails: String?, currentVersion: UInt?) {
        let reason = FailureReason(message: failureMessage, details: failureDetails)

        switch code {
        case "ConfigurationValidationFailed":
            self = .configurationValidationFailed
        case "AccessTokenRetrievalFailed":
            self = .accessTokenRetrievalFailed(reason: reason)
        case "InvalidJsonInput":
            self = .invalidJsonInputError(reason: reason)
        case "ResourceNotFound":
            self = .resourceNotFoundError(reason: reason)
        case "ConcurrentModification":
            self = .concurrentModificationError(reason: reason, currentVersion: currentVersion)
        case "insufficient_token_grant_type":
            self = .insufficientTokenGrantTypeError(reason: reason)
        default:
            self = .generalError(reason: reason)
        }
    }
}

extension CTError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .configurationValidationFailed:
            return "There is an error in the Commercetools SDK configuration - validation failed"
        case .accessTokenRetrievalFailed(let reason):
            return "Could not retrieve access token\n\(reason.localizedDescription)\n" +
                    "Make sure you have proper project client ID and secret set in your config file."
        case .invalidJsonInputError(let reason):
            return "Invalid json input occurred\n\(reason.localizedDescription)\n" +
                    "It's very likely due to invalid 'create' or 'update' dictionary. Have a look at the API documentation."
        case .resourceNotFoundError(let reason):
            return "The requested resource could not be found\n\(reason.localizedDescription)"
        case .concurrentModificationError(let reason, let currentVersion):
            return "Concurrent modification error\n\(reason.localizedDescription)\n" +
                    "Make sure you're setting the most recent object version." +
                    (currentVersion == nil ? "" : "\nThe current version seems to be \(currentVersion!)")
        case .insufficientTokenGrantTypeError(let reason):
            return "\(reason.localizedDescription)\nAccess token obtained using client ID and secret from your config " +
                    "file does not have sufficient privileges for the operation you tried to perform."
        case .generalError(let reason):
            return reason?.localizedDescription ?? "No failure reason available"
        }
    }

}

extension CTError.FailureReason {
    var localizedDescription: String {
        if let message = message, details == nil {
            return message
        } else if let message = message, let details = details {
            return "\(message): \(details)"
        } else {
            return details ?? "No failure reason available"
        }
    }
}
