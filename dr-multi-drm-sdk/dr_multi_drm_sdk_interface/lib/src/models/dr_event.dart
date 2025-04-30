import '../enums/enums.dart';

class DrEvent {
  /// Creates an instance of [DrEvent].
  ///
  /// The [eventType] and [url] arguments is required.
  ///
  /// arguments can be null.
  DrEvent(
      {required this.eventType,
      required this.contentId,
      required this.url,
      this.errorCode,
      this.message});

  /// The type of the event.
  final DrEventType eventType;

  final String contentId;

  final String url;

  final String? errorCode;

  final String? message;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DrEvent &&
            runtimeType == other.runtimeType &&
            contentId == other.contentId &&
            url == other.url &&
            eventType == other.eventType &&
            errorCode == other.errorCode &&
            message == other.message;
  }

  @override
  int get hashCode =>
      eventType.hashCode ^
      contentId.hashCode ^
      url.hashCode ^
      errorCode.hashCode ^
      message.hashCode;

  static DrEvent fromMap(dynamic message) {
    final Map<dynamic, dynamic> pallyConEvent = message;

    if (!pallyConEvent.containsKey('contentId')) {
      throw ArgumentError.value(pallyConEvent, 'contentId',
          'The supplied map doesn\'t contain the mandatory key `contentId`.');
    }

    if (!pallyConEvent.containsKey('url')) {
      throw ArgumentError.value(pallyConEvent, 'url',
          'The supplied map doesn\'t contain the mandatory key `url`.');
    }

    if (!pallyConEvent.containsKey('eventType')) {
      throw ArgumentError.value(pallyConEvent, 'eventType',
          'The supplied map doesn\'t contain the mandatory key `eventType`.');
    }

    final String? eventType = pallyConEvent['eventType'] as String?;
    switch (eventType) {
      case 'prepare':
        return DrEvent(
            eventType: DrEventType.prepare,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'complete':
        return DrEvent(
            eventType: DrEventType.complete,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'pause':
        return DrEvent(
            eventType: DrEventType.pause,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'remove':
        return DrEvent(
            eventType: DrEventType.remove,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'stop':
        return DrEvent(
            eventType: DrEventType.stop,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'contentDataError':
        return DrEvent(
            eventType: DrEventType.contentDataError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'drmError':
        return DrEvent(
            eventType: DrEventType.drmError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'licenseServerError':
        return DrEvent(
            eventType: DrEventType.licenseServerError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            errorCode: pallyConEvent['errorCode'],
            message: pallyConEvent['message']);
      case 'downloadError':
        return DrEvent(
            eventType: DrEventType.downloadError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'networkConnectedError':
        return DrEvent(
            eventType: DrEventType.networkConnectedError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'detectedDeviceTimeModifiedError':
        return DrEvent(
            eventType: DrEventType.detectedDeviceTimeModifiedError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'migrationError':
        return DrEvent(
            eventType: DrEventType.migrationError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      case 'licenseCipherError':
        return DrEvent(
            eventType: DrEventType.licenseCipherError,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
      default:
        return DrEvent(
            eventType: DrEventType.unknown,
            contentId: pallyConEvent['contentId'],
            url: pallyConEvent['url'],
            message: pallyConEvent['message']);
    }
  }
}
