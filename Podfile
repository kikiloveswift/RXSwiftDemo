source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

def rx
  pod 'RxSwift', :git => 'git@github.com:kingleekong/RxSwift.git', :commit => '12cccb17', :inhibit_warnings => true
    #pod 'RxSwift', :path => '/Users/kong/Desktop/STCode/RxSwift/', :inhibit_warnings => true
end

target 'RXSwiftDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx

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


