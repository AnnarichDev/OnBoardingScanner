#
# Be sure to run `pod lib lint OnBoardingScanner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'OnBoardingScanner'
    s.version          = '0.1.0'
    s.summary          = 'A short description of OnBoardingScanner.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/AnnarichDev/OnBoardingScanner'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'AnnarichDev' => 'annarich.dev@gmail.com' }
    s.source           = { :git => 'https://github.com/AnnarichDev/OnBoardingScanner.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '12.0'
    
    s.source_files = 'OnBoardingScanner/**/*.{swift}'
    s.resources = 'OnBoardingScanner/**/*.{xcassets,storyboard,xib,xcdatamodeld,lproj,Strings,ttf}'

#    s.resources = 'OnBoardingScanner/Resources/**/*'
    
    s.resource_bundles = {
        'OnBoardingScanner' => ['OnBoardingScanner/Resources/**/*.pdf']
    }
    
#    s.public_header_files = 'OnBoardingScanner/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    
    s.dependency 'SnapKit', '~> 5.6.0'
    s.dependency 'BSImagePicker'
    
end
