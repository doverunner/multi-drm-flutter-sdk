import 'package:flutter/services.dart';

import '../models/models.dart';
import '../dr_multi_drm_sdk_interface.dart';
import '../enums/dr_download_state.dart';

/// An implementation of [DrMultiDrmSdkPlatform] that uses method channels.
class MethodChannelPallyConDrmSdk extends DrMultiDrmSdkPlatform {
  static const _methodChannel = MethodChannel('com.doverunner.drmsdk');

  static const _drEventChannel = EventChannel('com.doverunner.drmsdk/dr_event');

  static const _downloadProgressChannel =
      EventChannel('com.doverunner.drmsdk/download_progress');

  Stream<DrEvent>? _drEventStream;
  Stream<DrDownload>? _downloadProgressStream;

  @override
  Future<void> initialize(String siteId) async {
    await _methodChannel.invokeMethod('initialize', {'siteId': siteId});
  }

  @override
  void release() {
    _methodChannel.invokeMethod('release');
  }

  @override
  Future<String> getObjectForContent(DrContentConfiguration config) async {
    return await _methodChannel.invokeMethod(
        'getObjectForContent', _configToDynamicList(config));
  }

  @override
  Future<DrDownloadState> getDownloadState(
      DrContentConfiguration config) async {
    final String state = await _methodChannel.invokeMethod(
        'getDownloadState', _configToDynamicList(config));

    var pallyConDownloadState = DrDownloadState.NOT;
    switch (state) {
      case "DOWNLOADING":
        {
          pallyConDownloadState = DrDownloadState.DOWNLOADING;
        }
        break;
      case "COMPLETED":
        {
          pallyConDownloadState = DrDownloadState.COMPLETED;
        }
        break;
      case "PAUSED":
        {
          pallyConDownloadState = DrDownloadState.PAUSED;
        }
        break;
      default:
        {
          pallyConDownloadState = DrDownloadState.NOT;
        }
        break;
    }

    return pallyConDownloadState;
  }

  // Delegate
  @override
  Stream<DrEvent> get onPallyConEvent {
    if (_drEventStream != null) {
      return _drEventStream!;
    }
    var pallyConEventStream = _drEventChannel.receiveBroadcastStream();

    _drEventStream = pallyConEventStream
        .where((pallyConEvent) => pallyConEvent != null)
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
        .where((pallyConDownload) => pallyConDownload != null)
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
    _methodChannel.invokeMethod(
        'addStartDownload', _configToDynamicList(config));
  }

  @override
  void stopDownload(DrContentConfiguration config) {
    _methodChannel.invokeMethod('stopDownload', _configToDynamicList(config));
  }

  @override
  void resumeDownloads() {
    _methodChannel.invokeMethod('resumeDownloads');
  }

  @override
  void cancelDownloads() {
    _methodChannel.invokeMethod('cancelDownloads');
  }

  @override
  void pauseDownloads() {
    _methodChannel.invokeMethod('pauseDownloads');
  }

  @override
  void removeDownload(DrContentConfiguration config) {
    _methodChannel.invokeMethod('removeDownload', _configToDynamicList(config));
  }

  @override
  void removeLicense(DrContentConfiguration config) {
    _methodChannel.invokeMethod('removeLicense', _configToDynamicList(config));
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
  Future<bool> reDownloadCertification(DrContentConfiguration config) async {
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

  dynamic _configToDynamicList(DrContentConfiguration config) {
    return {
      'contentId': config.contentId,
      'url': config.contentUrl,
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
      case 'Message':
      default:
        return exception;
    }
  }
}
