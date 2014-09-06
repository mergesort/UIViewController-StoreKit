Pod::Spec.new do |spec|
#Information
  spec.name         = 'UIViewController+StoreKit'
  spec.version      = '1.0.2'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/mergesort/UIViewController-StoreKit'
  spec.author       =  { 'Joe Fabisevich' => 'github@fabisevi.ch' }
  spec.summary      = 'A category on UIViewController allowing you to pull up an iTunes item with just one method.'
  spec.source       =  { :git => 'https://github.com/mergesort/UIViewController-StoreKit.git', :tag => "#{spec.version}" }
  spec.source_files = '*.{h,m}'
  spec.framework    = 'Foundation'
  spec.requires_arc = true
  spec.social_media_url = 'https://twitter.com/mergesort'
  spec.ios.deployment_target = '7.0'

#Depdencies
  spec.dependency 'NSString+Validation'
end
