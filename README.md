# DOVERUNNER Multi-DRM Flutter SDK

`DOVERUNNER Multi-DRM Flutter SDK` (`Flutter SDK` for short) is a product that makes it easy to apply Widevine and FairPlay DRM when developing media service apps in a Flutter-based cross-platform application development environment. 
It supports streaming and downloading scenarios of content encrypted with Widevine and FairPlay DRM on Android and iOS apps developed with Flutter.

## Packages
```
DoveRunner DRM Flutter SDK
    |
    ├─ dr-multi-drm-sdk     // DOVERUNNER DRM Flutter SDK
    |    ├─ dr_multi_drm_sdk
    |    ├─ dr_multi_drm_sdk_android
    |    ├─ dr_multi_drm_sdk_interface
    |    └─ dr_multi_drm_sdk_ios
    |
    └─ player-samples       // sample project
         ├─ advanced
         └─ basic
``` 


### dr-multi-drm-sdk
- `dr-multi-drm-sdk` is a SDK that provides an interface to use DOVERUNNER services in flutter.
  - Provides download and streaming playback functions on Android through `DOVERUNNER Widevine Android SDK`.
  - Provides download and streaming playback functions on iOS through `DOVERUNNER FPS iOS SDK`.
- For more details about `dr-multi-drm-sdk`, please refer to the [README.md][1] file.


### player-samples
- `player-samples` is a sample project that allows you to learn how to use `dr_multi_drm_sdk`.
  - advanced
    - Provides download and streaming playback functions
  - basic
    - Provides streaming playback functions

- For more details about `player-samples`, please refer to the [README.md][2] file in the advanced and basic folders.


[1]: dr-multi-drm-sdk/README.md
[2]: ./player-samples/advanced/README.md
