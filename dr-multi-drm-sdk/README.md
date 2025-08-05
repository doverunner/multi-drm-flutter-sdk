# DoveRunner Multi DRM SDK for flutter

**`DoveRunner Multi DRM SDK for flutter`** follows a federated architecture, which includes the following packages.
> In the trial account, you can freely test SDK products within the trial limit on the number of licenses issued. However, in order to apply the SDK to commercial services, you must apply for a plan that includes SDK usage rights when subscribing to DoveRunner commercial plans.

This document describes the usage and API of **`dr_multi_drm_sdk`**.
The example of **`dr_multi_drm_sdk`** is available on [player-sample][9].

## **important**

> To develop using the SDK, you must first sign up for the [DoveRunner Site][10] and obtain a **`Site ID`**.

## Packages

```
// flutter plugin for DoveRunner Multi-DRM SDK
dr-multi-drm-sdk
    |
    ├─ dr_multi_drm_sdk
    ├─ dr_multi_drm_sdk_android
    ├─ dr_multi_drm_sdk_ios
    └─ dr_multi_drm_sdk_interface
```

### 1. [`dr_multi_drm_sdk`][1]
 - The package that faces the app. 
 - It's what users rely on to use the plugin in their projects. 
 - For usage details, refer to its [README.md][2] file.

### 2. [`dr_multi_drm_sdk_android`][3]
 - This package holds the official Android implementation of the [dr_multi_drm_sdk_interface][7] and adds Android support to the [dr_multi_drm_sdk][1] package.
 - More information can be found in its [README.md][4] file.

### 3. [`dr_multi_drm_sdk_ios`][5]
 - This package holds the official iOS implementation of the [dr_multi_drm_sdk_interface][7] and adds iOS support to the [dr_multi_drm_sdk][1] package.
 - More information can be found in its [README.md][6] file.

### 4. [`dr_multi_drm_sdk_interface`][7]
 - This package defines the interface that all platform packages must implement to support the app-facing package.
 - Instructions on how to implement a platform package can be found in the [README.md][8] of the [dr_multi_drm_sdk_interface][7] package.


## **support environment**

- Android 6.0 (API 23) & Android targetSdkVersion 34 or higher
- iOS 14.0 higher

Below are the Android and iOS properties required for **`dr_multi_drm_sdk`** to work properly.

#### **Android**

- **compileSdkVersion**

  Make sure you set `compileSdkVersion` in "android/app/build.gradle".

  ```
  android {
    compileSdkVersion 34

    ...
  }
  ```

- **Permissions**

  Inside the SDK, the following 4 items are used in relation to user permission.

  ``` xml
  <!-- AndroidManifest.xml -->
  <uses-permission android:name="android.permission.INTERNET" />
  <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
  <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
  ```


#### **iOS**

- [cocoapods][11] is used as a library dependency manager in the Xcode project, so it must be installed on macOS.
  - cocoapods installation and usage are available on this [link][12].
  
- `dr_multi_drm_sdk` does not support simulators on iOS. Please test on a real device.



[1]: ./dr_multi_drm_sdk
[2]: dr_multi_drm_sdk/README.md
[3]: ./dr_multi_drm_sdk_android
[4]: dr_multi_drm_sdk_android/README.md
[5]: ./dr_multi_drm_sdk_ios
[6]: dr_multi_drm_sdk_ios/README.md
[7]: ./dr_multi_drm_sdk_interface
[8]: dr_multi_drm_sdk_interface/README.md
[9]: ../player-samples
[10]: https://console.doverunner.com/
[11]: https://cocoapods.org/
[12]: https://guides.cocoapods.org/using/getting-started.html
