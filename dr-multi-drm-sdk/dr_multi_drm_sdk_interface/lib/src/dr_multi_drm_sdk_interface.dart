import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'implementations/dr_multi_drm_sdk_method_channel.dart';
import 'enums/dr_download_state.dart';
import 'models/models.dart';

abstract class DrMultiDrmSdkPlatform extends PlatformInterface {
  /// Constructs a DrMultiDrmSdkPlatform.
  DrMultiDrmSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static DrMultiDrmSdkPlatform _instance = MethodChannelPallyConDrmSdk();

  /// The default instance of [DrMultiDrmSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelPallyConDrmSdk].
  static DrMultiDrmSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DrMultiDrmSdkPlatform] when
  /// they register themselves.
  static set instance(DrMultiDrmSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Delegate
  Stream<DrEvent> get onDrEvent {
    throw UnimplementedError('onPallyConEvent() has not been implemented.');
  }

  Stream<DrDownload> get onDownloadProgress {
    throw UnimplementedError('onDownloadProgress() has not been implemented.');
  }

  Future<void> initialize(String siteId) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  void release() {
    throw UnimplementedError('release() has not been implemented.');
  }

  Future<String> getObjectForContent(DrContentConfiguration config) {
    throw UnimplementedError('getObjectForContent() has not been implemented.');
  }

  Future<DrDownloadState> getDownloadState(DrContentConfiguration config) {
    throw UnimplementedError('getDownloadState() has not been implemented.');
  }

  Future<String> getLicenseInformation(DrContentConfiguration config) {
    throw UnimplementedError(
        'getLicenseInformation() has not been implemented.');
  }

  // Download
  void addStartDownload(DrContentConfiguration config) {
    throw UnimplementedError('addStartDownload() has not been implemented.');
  }

  void stopDownload(DrContentConfiguration config) {
    throw UnimplementedError('stopDownload() has not been implemented.');
  }

  void resumeDownloads() {
    throw UnimplementedError('resumeDownloads() has not been implemented.');
  }

  void cancelDownloads() {
    throw UnimplementedError('cancelDownload() has not been implemented.');
  }

  void pauseDownloads() {
    throw UnimplementedError('pauseDownloads() has not been implemented.');
  }

  void removeDownload(DrContentConfiguration config) {
    throw UnimplementedError('removeDownload() has not been implemented.');
  }

  void removeLicense(DrContentConfiguration config) {
    throw UnimplementedError('removeLicense() has not been implemented.');
  }

  Future<bool> needsMigrateDatabase(DrContentConfiguration config) {
    throw UnimplementedError(
        'needsMigrateDatabase() has not been implemented.');
  }

  Future<bool> migrateDatabase(DrContentConfiguration config) {
    throw UnimplementedError('migrateDatabase() has not been implemented.');
  }

  Future<bool> reDownloadCertification(DrContentConfiguration config) {
    throw UnimplementedError(
        'reDownloadCertification() has not been implemented.');
  }

  Future<bool> updateSecureTime() {
    throw UnimplementedError('updateSecureTime() has not been implemented.');
  }
}
