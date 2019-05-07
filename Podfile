source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

def rx
  pod 'RxSwift', :git => 'git@github.com:kingleekong/RxSwift.git', :commit => '12cccb17', :inhibit_warnings => true
    #pod 'RxSwift', :path => '/Users/kong/Desktop/STCode/RxSwift/', :inhibit_warnings => true
end

def thirdPart
  pod 'SDWebImage', '~> 4.0'
  pod 'SwiftyJSON', '~> 4.0'
end

target 'RXSwiftDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx
  thirdPart

  # Pods for RXSwiftDemo

  target 'RXSwiftDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RXSwiftDemoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'RxSwift'
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
        end
      end
    end
  end
end

