Pod::Spec.new do |s|

  s.name         = "Commercetools"
  s.version      = "0.0.3"
  s.summary      = "The e-commerce iOS SDK from commercetools"
  s.homepage     = "https://github.com/sphereio/commercetools-ios-sdk"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author       = { "Commercetools GmbH" => "support@commercetools.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/sphereio/commercetools-ios-sdk.git", :tag => s.version.to_s }
  s.source_files = 'Source/**/*.swift'

  s.dependency 'Alamofire', '~> 3.3'

end
