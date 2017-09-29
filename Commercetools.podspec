Pod::Spec.new do |s|

  s.name         = "Commercetools"
  s.version      = "0.7.2"
  s.summary      = "The e-commerce Swift SDK from commercetools"
  s.homepage     = "https://github.com/commercetools/commercetools-ios-sdk"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author       = { "Commercetools GmbH" => "support@commercetools.com" }
  s.source       = { :git => "https://github.com/commercetools/commercetools-ios-sdk.git", :tag => s.version.to_s }
  s.source_files = 'Source/*.swift'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.2'

end
