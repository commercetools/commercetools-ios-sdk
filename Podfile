use_frameworks!
platform :ios, '9.3'

def common_pods
  pod 'Alamofire', '~> 4.0'
  pod 'ObjectMapper', '~> 2.2'
end

target 'Commercetools iOS' do
  common_pods
end

target 'Commercetools watchOS' do
  platform :watchos, '2.2'
  common_pods
end

target 'Commercetools tvOS' do
  platform :tvos, '9.0'
  common_pods
end

target 'Commercetools macOS' do
  platform :osx, '10.10'
  common_pods
end

target 'Commercetools iOS Tests' do
  common_pods
end