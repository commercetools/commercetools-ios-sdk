Pod::Spec.new do |s|

  s.name         = "Commercetools"
  s.version      = "0.0.1"
  s.summary      = "Commercetools iOS Swift SDK"

  s.description  = <<-DESC
                    The e-commerce SDK from commercetools running on iOS clients
                   DESC

  s.homepage     = "https://github.com/sphereio/commercetools-ios-sdk"
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author       = { "Commercetools GmbH" => "support@commercetools.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/sphereio/commercetools-ios-sdk.git", :tag => s.version.to_s }
  s.source_files = 'Source/*.swift'

  s.dependency 'Alamofire', '~> 3.3'

end
