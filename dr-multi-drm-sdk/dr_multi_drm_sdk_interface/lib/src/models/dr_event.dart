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
    final Map<dynamic, dynamic> drEvent = message;

    if (!drEvent.containsKey('contentId')) {
      throw ArgumentError.value(drEvent, 'contentId',
          'The supplied map doesn\'t contain the mandatory key `contentId`.');
    }

    if (!drEvent.containsKey('url')) {
      throw ArgumentError.value(drEvent, 'url',
          'The supplied map doesn\'t contain the mandatory key `url`.');
    }

    if (!drEvent.containsKey('eventType')) {
      throw ArgumentError.value(drEvent, 'eventType',
          'The supplied map doesn\'t contain the mandatory key `eventType`.');
    }

    final String? eventType = drEvent['eventType'] as String?;
    switch (eventType) {
      case 'prepare':
        return DrEvent(
            eventType: DrEventType.prepare,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'complete':
        return DrEvent(
            eventType: DrEventType.complete,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'pause':
        return DrEvent(
            eventType: DrEventType.pause,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'remove':
        return DrEvent(
            eventType: DrEventType.remove,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'stop':
        return DrEvent(
            eventType: DrEventType.stop,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'contentDataError':
        return DrEvent(
            eventType: DrEventType.contentDataError,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'drmError':
        return DrEvent(
            eventType: DrEventType.drmError,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'licenseServerError':
        return DrEvent(
            eventType: DrEventType.licenseServerError,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            errorCode: drEvent['errorCode'],
            message: drEvent['message']);
      case 'downloadError':
        return DrEvent(
            eventType: DrEventType.downloadError,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'networkConnectedError':
        return DrEvent(
            eventType: DrEventType.networkConnectedError,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'detectedDeviceTimeModifiedError':
        return DrEvent(
            eventType: DrEventType.detectedDeviceTimeModifiedError,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'migrationError':
        return DrEvent(
            eventType: DrEventType.migrationError,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      case 'licenseCipherError':
        return DrEvent(
            eventType: DrEventType.licenseCipherError,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
      default:
        return DrEvent(
            eventType: DrEventType.unknown,
            contentId: drEvent['contentId'],
            url: drEvent['url'],
            message: drEvent['message']);
    }
  }
}
