Pod::Spec.new do |s|

  s.name         = "Commercetools"
  s.version      = "0.3.0"
  s.summary      = "The e-commerce iOS SDK from commercetools"
  s.homepage     = "https://github.com/commercetools/commercetools-ios-sdk"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author       = { "Commercetools GmbH" => "support@commercetools.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/commercetools/commercetools-ios-sdk.git", :tag => s.version.to_s }
  s.source_files = 'Source/**/*.swift'

  s.dependency 'Alamofire', '~> 4.0'
  s.dependency 'ObjectMapper', '~> 2.0'

end
