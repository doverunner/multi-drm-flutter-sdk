import 'package:flutter/services.dart';

import 'package:dr_multi_drm_sdk_interface/dr_multi_drm_sdk_interface.dart';

/// An implementation of [DrMultiDrmSdkPlatform] that uses method channels.
class DrMultiDrmSdkIos extends DrMultiDrmSdkPlatform {
  /// The method channel used to interact with the native platform.
  static const _methodChannel =
  MethodChannel('com.doverunner.drmsdk/ios');

  static const _drEventChannel =
  EventChannel('com.doverunner.drmsdk/dr_event');

  static const _downloadProgressChannel =
  EventChannel('com.doverunner.drmsdk/download_progress');

  static void registerWith() {
    DrMultiDrmSdkPlatform.instance = DrMultiDrmSdkIos._privateConstructor();
  }

  DrMultiDrmSdkIos._privateConstructor();

  static final DrMultiDrmSdkIos shared = DrMultiDrmSdkIos._privateConstructor();

  Stream<DrEvent>? _drEventStream;
  Stream<DrDownload>? _downloadProgressStream;

  @override
  Future<void> initialize(String siteId) async {
    try {
      await _methodChannel
          .invokeMethod('initialize', {'siteId': siteId});
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void release() {
    try {
      _methodChannel.invokeMethod('release');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<String> getObjectForContent(
      DrContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'getObjectForContent', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<DrDownloadState> getDownloadState(
      DrContentConfiguration config) async {
    try {
      final String state = await _methodChannel
          .invokeMethod('getDownloadState', _configToDynamicList(config));

      var downloadState = DrDownloadState.NOT;
      switch (state) {
        case "DOWNLOADING":
          {
            downloadState = DrDownloadState.DOWNLOADING;
          }
          break;
        case "COMPLETED":
          {
            downloadState = DrDownloadState.COMPLETED;
          }
          break;
        case "PAUSED":
          {
            downloadState = DrDownloadState.PAUSED;
          }
          break;
        default:
          {
            downloadState = DrDownloadState.NOT;
          }
          break;
      }

      return downloadState;
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  // Delegate
  @override
  Stream<DrEvent> get onDrEvent {
    if (_drEventStream != null) {
      return _drEventStream!;
    }
    var drEventStream = _drEventChannel.receiveBroadcastStream();

    _drEventStream = drEventStream
        .where((drEvent) => drEvent != null)
        .map((dynamic element) =>
        DrEvent.fromMap(element.cast<String, dynamic>()))
        .handleError((error) {
      _drEventStream = null;
      if (error is PlatformException) {
        error = _handlePlatformException(error);
      }
      throw error;
    });

    return _drEventStream!;
  }

  @override
  Stream<DrDownload> get onDownloadProgress {
    if (_downloadProgressStream != null) {
      return _downloadProgressStream!;
    }

    var downloadProgressStream =
    _downloadProgressChannel.receiveBroadcastStream();

    _downloadProgressStream = downloadProgressStream
        .where((drDownload) => drDownload != null)
        .map((dynamic element) =>
        DrDownload.fromMap(element.cast<String, dynamic>()))
        .handleError((error) {
      _downloadProgressStream = null;
      if (error is PlatformException) {
        error = _handlePlatformException(error);
      }
      throw error;
    });

    return _downloadProgressStream!;
  }

  // Download
  @override
  void addStartDownload(DrContentConfiguration config) {
    try {
      _methodChannel.invokeMethod('addStartDownload', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void stopDownload(DrContentConfiguration config) {
    try {
      _methodChannel.invokeMethod('stopDownload', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void resumeDownloads() {
    try {
      _methodChannel.invokeMethod('resumeDownloads');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void cancelDownloads() {
    try {
      _methodChannel.invokeMethod('cancelDownloads');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void pauseDownloads() {
    try {
      _methodChannel.invokeMethod('pauseDownloads');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void removeDownload(DrContentConfiguration config) {
    try {
      _methodChannel.invokeMethod('removeDownload', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void removeLicense(DrContentConfiguration config) {
    try {
      _methodChannel.invokeMethod('removeLicense', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> needsMigrateDatabase(DrContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'needsMigrateDatabase', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> migrateDatabase(DrContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'migrateDatabase', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> reDownloadCertification(
      DrContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'reDownloadCertification', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> updateSecureTime() async {
    try {
      return await _methodChannel.invokeMethod('updateSecureTime');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  dynamic _configToDynamicList(
      DrContentConfiguration config) {
    return {
      'url': config.contentUrl,
      'contentId': config.contentId,
      'drmType': config.drmType,
      'token': config.token,
      'customData': config.customData,
      'contentCookie': config.contentCookie,
      'contentHttpHeaders': config.contentHttpHeaders,
      'licenseCookie': config.licenseCookie,
      'licenseHttpHeaders': config.licenseHttpHeaders,
      'licenseUrl': config.licenseUrl,
      'certificateUrl': config.certificateUrl,
      'licenseCipherTablePath': config.licenseCipherTablePath
    };
  }

  Exception _handlePlatformException(PlatformException exception) {
    switch (exception.code) {
      case 'ILLEGAL_ARGUMENT':
        return IllegalArgumentException(exception.message);
      default:
        return exception;
    }
  }
}
