import 'package:dr_multi_drm_sdk_interface/dr_multi_drm_sdk_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDrMultiDrmSdkPlatform
    with MockPlatformInterfaceMixin
    implements DrMultiDrmSdkPlatform {

  @override
  void addStartDownload(DrContentConfiguration config) {
    // TODO: implement addStartDownload
  }

  @override
  void stopDownload(DrContentConfiguration config) {
    // TODO: implement stopDownload
  }

  @override
  Future<String> getObjectForContent(DrContentConfiguration config) {
    // TODO: implement getObjectForContent
    throw UnimplementedError();
  }

  @override
  Future<void> initialize(String siteId) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  void pauseDownloads() {
    // TODO: implement pauseDownloads
  }

  @override
  void removeDownload(DrContentConfiguration config) {
    // TODO: implement removeDownload
  }

  @override
  void resumeDownloads() {
    // TODO: implement resumeDownloads
  }

  @override
  void cancelDownloads() {
    // TODO: implement cancelDownloads
  }

  @override
  Future<DrDownloadState> getDownloadState(DrContentConfiguration config) {
    // TODO: implement getDownloadState
    throw UnimplementedError();
  }

  @override
  Future<String> getLicenseInformation(DrContentConfiguration config) {
    // TODO: implement getLicenseInformation
    throw UnimplementedError();
  }

  @override
  // TODO: implement onDownloadProgress
  Stream<DrDownload> get onDownloadProgress => throw UnimplementedError();

  @override
  // TODO: implement onDrEvent
  Stream<DrEvent> get onDrEvent => throw UnimplementedError();

  @override
  void release() {
    // TODO: implement release
  }

  @override
  void removeLicense(DrContentConfiguration config) {
    // TODO: implement removeLicense
  }

  @override
  Future<bool> migrateDatabase(DrContentConfiguration config) {
    // TODO: implement migrateDatabase
    throw UnimplementedError();
  }

  @override
  Future<bool> needsMigrateDatabase(DrContentConfiguration config) {
    // TODO: implement needsMigrateDatabase
    throw UnimplementedError();
  }

  @override
  Future<bool> reDownloadCertification(DrContentConfiguration config) {
    // TODO: implement reDownloadCertification
    throw UnimplementedError();
  }

  @override
  Future<bool> updateSecureTime() {
    // TODO: implement updateSecureTime
    throw UnimplementedError();
  }
}

void main() {
  // final PallyConDrmSdkPlatform initialPlatform = PallyConDrmSdkPlatform.instance;

  test('getPlatformVersion', () async {
  });
}
