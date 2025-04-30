## **DOVERUNNER MULTI DRM SDK** for Flutter Development Guide

[![pub package](https://img.shields.io/badge/puv-1.1.5-orange)](https://pub.dartlang.org/packages/)

A Flutter dr_multi_drm_sdk plugin which provides easy to apply Multi-DRM(Android: Widevine, iOS: FairPlay) when developing media service apps for Android and iOS. Please refer to the links below for detailed information.

## **support environment**

- Android 5.0 (Lolipop) & Android targetSdkVersion 34 or higher
- iOS 12.0 higher
- This SDK supports media3 version 1.5.1 on Android.

## **Important**

- To develop using the SDK, you must first sign up for the DOVERUNNER Admin Site and obtain a Site ID.

## **SDK usage**

To add DrMultiDrmSdk to your Flutter app, read the [Installation](https://pub.dev/packages/) instructions. Below are the Android and iOS properties required for DrMultiDrmSdk to work properly.

<details>
<summary>Android</summary>

**compileSdkVersion**

Make sure you set `compileSdkVersion` in "android/app/build.gradle".

```
android {
  compileSdkVersion 34

  ...
}
```

**Permissions**

Inside the SDK, the following 4 items are used in relation to user permission.

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
```

You can add the Maven repository configuration to the repositories block in your android/build.gradle file as follows:

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://maven.pkg.github.com/doverunner/widevine-android-sdk")
            credentials {
                username = project.findProperty("gpr.user") ?: ""
                password = project.findProperty("gpr.token") ?: ""
            }
        }
    }
}
```

In the gradle.properties file in the android directory of your project, add the GitHub user (e-mail) and the generated GitHub access token as shown below.

```gradle
gpr.user = GITHUB_USER
gpr.token = GITHUB_ACCESS_TOKEN
```

</details>

<details>
<summary>iOS</summary>

`DOVERUNNER DRM SDK Flutter` uses `PallyConFPSSDK`. `PallyConFPSSDK` is supposed to be downloaded as `cocoapods`.

### SDK requirements

- Minimum supported version: 14.0

</details>

### **Initialize**

```dart
DrMultiDrmSdk.initialize(siteId);
```

### **Set Event**

Register events that occur inside the SDK.

```dart
DrMultiDrmSdk.onDrEvent.listen((event) {
    var downloadState = DownloadStatus.pending;
    switch (event.eventType) {
        case DrEventType.prepare:
          //
          break;
        case DrEventType.complete:
          // Called when download is complete
          break;
        case DrEventType.pause:
          // Called when downloading is stopped during download
          break;
        case DrEventType.download:
          // Called when download starts
          break;
        case DrEventType.contentDataError:
          // Called when an error occurs in the parameters passed to the sdk
          break;
        case DrEventType.drmError:
          // Called when a license error occurs
          break;
        case DrEventType.licenseServerError:
          // Called when an error comes down from the license server
          break;
        case DrEventType.downloadError:
          // Called when an error occurs during download
          break;
        case DrEventType.networkConnectedError:
          // Called in case of network error
          break;
        case DrEventType.detectedDeviceTimeModifiedError:
          // Called when device time is forcibly manipulated
          break;
        case DrEventType.migrationError:
          // Called when sdk migration fails
          break;
        case DrEventType.unknown:
          // Internally called when an unknown error occurs
          break;
  }
  // content state
}).onError((error) {
  //
});
```

When downloading, register a listener to know the size of the currently downloaded data.

```dart
DrMultiDrmSdk.onDownloadProgress.listen((event) {
    // event.url is url
    // event.percent is downloaded percent
});
```

### **Get content download status**

Get the current download status of the content.

```dart
DrDownloadState downloadState =
        await DrMultiDrmSdk.getDownloadState(DrContentConfiguration);
    switch (downloadState) {
      case DrDownloadState.DOWNLOADING:
        break;
      case DrDownloadState.PAUSED:
        break;
      case DrDownloadState.COMPLETED:
        break;
      default:
        break;
    }
```

### **Download**

Describes the API required for the content download process.

```dart
// start download
DrMultiDrmSdk.addStartDownload(DrContentConfiguration);

// stop download
DrMultiDrmSdk.stopDownload(DrContentConfiguration);

// cancel downloads
DrMultiDrmSdk.cancelDownloads();

// pause downloads
DrMultiDrmSdk.pauseDownloads();

// resume downloads
DrMultiDrmSdk.resumeDownloads();
```

### **Remove License or Contents**

Remove the downloaded license and content.

```dart
// remove downloaded content
DrMultiDrmSdk.removeDownload(DrContentConfiguration);

// remove license for content
DrMultiDrmSdk.removeLicense(DrContentConfiguration);
```

### **Release**

Called when you end using the SDK.

```dart
DrMultiDrmSdk.release();
```
