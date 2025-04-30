#import "DrMultiDrmSdkIosPlugin.h"
#if __has_include(<dr_multi_drm_sdk_ios/dr_multi_drm_sdk_ios-Swift.h>)
#import <dr_multi_drm_sdk_ios/dr_multi_drm_sdk_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dr_multi_drm_sdk_ios-Swift.h"
#endif

@implementation DrMultiDrmSdkIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDrMultiDrmSdkIosPlugin registerWithRegistrar:registrar];
}
@end
