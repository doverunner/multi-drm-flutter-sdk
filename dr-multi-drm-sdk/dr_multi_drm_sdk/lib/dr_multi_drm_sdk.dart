import 'package:dr_multi_drm_sdk_interface/dr_multi_drm_sdk_interface.dart';

import 'package:dr_multi_drm_sdk_android/dr_multi_drm_sdk_android.dart';
import 'package:dr_multi_drm_sdk_ios/dr_multi_drm_sdk_ios.dart';

export 'package:dr_multi_drm_sdk_android/dr_multi_drm_sdk_android.dart';
export 'package:dr_multi_drm_sdk_ios/dr_multi_drm_sdk_ios.dart';
export 'package:dr_multi_drm_sdk_interface/dr_multi_drm_sdk_interface.dart';

/// DoveRunner Multi DRM SDK for using Multi-DRM.
class DrMultiDrmSdk {
  /// Notifications of events occurring in the SDK.
  static Stream<DrEvent> get onDrEvent =>
      DrMultiDrmSdkPlatform.instance.onDrEvent;

  /// Notification that informs the percentage of content currently being downloaded.
  static Stream<DrDownload> get onDownloadProgress =>
      DrMultiDrmSdkPlatform.instance.onDownloadProgress;

  /// Initialize the [DrMultiDrmSdk]
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<void> initialize(String siteId) async {
    await DrMultiDrmSdkPlatform.instance.initialize(siteId);
  }

  /// Release the [DrMultiDrmSdk]
  /// The [DrMultiDrmSdk] must not be used after calling this method.
  static void release() {
    DrMultiDrmSdkPlatform.instance.release();
  }

  /// function that creates the objects needed to play the player.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  /// Throws a [PermissionRequiredException] when there is no permission in the android project
  static Future<String> getObjectForContent(
      DrContentConfiguration config) async {
    return await DrMultiDrmSdkPlatform.instance.getObjectForContent(config);
  }

  /// Get a [DrDownloadState]
  ///
  /// A [DrDownloadState] is state of download for content
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<DrDownloadState> getDownloadState(
          DrContentConfiguration config) async =>
      await DrMultiDrmSdkPlatform.instance.getDownloadState(config);

  /// Starts the service if not started already and adds a new download.
  /// If an error occurs during DRM download, [DrEventType.downloadError] called.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static void addStartDownload(DrContentConfiguration config) {
    DrMultiDrmSdkPlatform.instance.addStartDownload(config);
  }

  /// Starts the service in not started already and stop download.
  static void stopDownload(DrContentConfiguration config) {
    DrMultiDrmSdkPlatform.instance.stopDownload(config);
  }

  /// Starts the service if not started already and resumes all downloads.
  static void resumeDownloads() {
    DrMultiDrmSdkPlatform.instance.resumeDownloads();
  }

  /// Starts the service in not started already and cancels all downloads.
  static void cancelDownloads() {
    DrMultiDrmSdkPlatform.instance.cancelDownloads();
  }

  /// Starts the service in not started already and pauses all downloads.
  static void pauseDownloads() {
    DrMultiDrmSdkPlatform.instance.pauseDownloads();
  }

  /// Remove the content already downloaded.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static void removeDownload(DrContentConfiguration config) {
    DrMultiDrmSdkPlatform.instance.removeDownload(config);
  }

  /// Remove offline licenses already downloaded.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static void removeLicense(DrContentConfiguration config) {
    DrMultiDrmSdkPlatform.instance.removeLicense(config);
  }

  /// As each patch progresses, you can check to see if you need to migrate.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<bool> needsMigrateDatabase(
      DrContentConfiguration config) async {
    return await DrMultiDrmSdkPlatform.instance.needsMigrateDatabase(config);
  }

  /// Migrate past downloaded content
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<bool> migrateDatabase(DrContentConfiguration config) async {
    return await DrMultiDrmSdkPlatform.instance.migrateDatabase(config);
  }

  /// for android
  /// Try when all Widevine DRM(Android) content suddenly fails to play on the device and there is an error like the one below.
  ///  Failed to restore keys: General DRM error (-2000)
  ///  This error can occur when there is a problem with provisioning and can be reset.
  ///  You must be connected to the network when using the function.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<bool> reDownloadCertification(
      DrContentConfiguration config) async {
    return await DrMultiDrmSdkPlatform.instance.reDownloadCertification(config);
  }

  /// for android
  /// Called for playback when 'detectedDeviceTimeModifiedError' in android
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<bool> updateSecureTime() async {
    return await DrMultiDrmSdkPlatform.instance.updateSecureTime();
  }
}
