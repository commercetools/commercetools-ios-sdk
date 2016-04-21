//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

// MARK: - Configuration

/**
    Provides access to the current `Config` instance.
*/
public var config: Config? {
    get {
        return Config.currentConfig
    }
    set(newConfig) {
        Config.currentConfig = newConfig
        // After setting new configuration, we try to obtain the access token
        AuthManager.sharedInstance.token { token, error in
            if let error = error {
                Log.error("Could not obtain auth token \(error.userInfo[NSLocalizedFailureReasonErrorKey] ?? nil)")
            }
        }
    }
}

//
//protocol Endpoint {
//
//    var path: String { get }
//    func headers(token: String) -> [String: String]
//}
//
//extension Endpoint {
//
//    func headers(token: String) -> [String: String] {
//        var headers = Manager.defaultHTTPHeaders
//        headers["Authorization"] = "Bearer \(token)"
//        return headers
//    }
//}
//
//protocol CreatableEndpoint: Endpoint {
//
//    func create(object: [String: AnyObject], completionHandler: ([String: AnyObject]?, NSError?) -> Void)
//
//}
//
//extension CreatableEndpoint {
//
//    func create(object: [String: AnyObject], completionHandler: ([String: AnyObject]?, NSError?) -> Void) {
//        AuthManager.sharedInstance.token { token, error in
//            guard let token = token else {
//                completionHandler(nil, error)
//                return
//            }
//
//            Alamofire.request(.POST, path, parameters: object, encoding: .JSON, headers: headers(token))
//            .responseJSON(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), completionHandler: { response in
//                print(response)
//            })
//        }
//    }
//
//}
//
//class Cart: CreatableEndpoint {
//
//    let path: String
//
//    init() {
//        path =
//    }
//
//
//}
//
//extension Resource: CreatableEndpoint {
//
//
//
//}