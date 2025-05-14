#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dr_multi_drm_sdk_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dr_multi_drm_sdk_ios'
  s.version          = '1.2.0'
  s.summary          = 'DOVERUNNER DRM Flutter SDK for iOS.'
  s.description      = <<-DESC
A new Flutter DOVERUNNER FairPlay Streaming(FPS) SDK plugin project.
                       DESC
  s.homepage         = 'http://www.doverunner.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'DOVERUNNER' => 'contentsecurity@doverunner.co.kr' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'DOVERUNNERFairPlay'
#   s.subspec "PallyConFPSSDK" do |sp|
#     sp.framework   = 'CoreFoundation'
#     sp.dependency   'PallyConFPSSDK', :path => "./PallyConFPSSDK/"
#   end
  s.platform = :ios, '14.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
