//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

enum TransactionType: String {

    case authorization = "Authorization"
    case cancelAuthorization = "CancelAuthorization"
    case charge =  "Charge"
    case refund = "Refund"
    case chargeback = "Chargeback"

}
