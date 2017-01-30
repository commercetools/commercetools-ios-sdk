//
// Copyright (c) 2016 Commercetools. All rights reserved.
//

import PackageDescription

let package = Package(
name: "Commercetools",
        dependencies: [
                .Package(url: "https://github.com/Alamofire/Alamofire.git", majorVersion: 4),
                .Package(url: "https://github.com/Hearst-DD/ObjectMapper.git", majorVersion: 2),
        ]
)