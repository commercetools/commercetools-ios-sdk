//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

/**
    Used to specify desired log output level for Commercetools library.

    - Error: Log only errors.
    - Debug: Log both errors and other important messages for development and debugging purposes.
*/
public enum LogLevel: Int {
    case error
    case debug
}

/**
    Responsible for logging errors and debug messages originated from Commercetools SDK.
*/
class Log {

    /**
        Debug logging method outputs messages in case there is a valid `Config` present, and the log level is
        debug `.Debug`, and also in case there is no valid `Config` present.

        - parameter message:                  The message to be logged.
    */
    class func debug(_ message: @autoclosure () -> String?) {
        guard let text = message() else {
            return
        }

        let config = Config.currentConfig

        if config == nil || (config!.loggingEnabled && config!.logLevel == .debug) {
            NSLog("Commercetools SDK DEBUG - \(text)")
        }
    }

    /**
        Error logging method outputs messages always, except when the logging is explicitly disabled
        by the current `Config`.

        - parameter message:                  The message to be logged.
    */
    class func error(_ message: @autoclosure () -> String?) {
        guard let text = message() else {
            return
        }

        let config = Config.currentConfig

        if config == nil || config!.loggingEnabled {
            NSLog("Commercetools SDK ERROR - \(text)")
        }
    }

}
