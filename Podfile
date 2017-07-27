use_frameworks!
platform :ios, '9.3'

def common_pods
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

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end
