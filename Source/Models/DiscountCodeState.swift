//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import Foundation

public enum DiscountCodeState: String {
    
    case notActive = "NotActive"
    case doesNotMatchCart = "DoesNotMatchCart"
    case matchesCart = "MatchesCart"
    case maxApplicationReached = "MaxApplicationReached"
    
}
