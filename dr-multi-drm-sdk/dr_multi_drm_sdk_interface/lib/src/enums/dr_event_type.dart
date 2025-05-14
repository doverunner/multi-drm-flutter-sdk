/// Event type of SDK Event
enum DrEventType {
  /// Download preparation completed
  prepare,

  /// The download completed
  complete,

  /// The download paused
  pause,

  /// The download is removed
  remove,

  /// The download is stop
  stop,

  /// The download is start
  download,

  /// Error when the content information to be downloaded is incorrect
  /// It mainly occurs when the value of the function parameter [DrContentConfiguration] is incorrect.
  contentDataError,

  /// License error
  drmError,

  /// Server error when issuing license
  licenseServerError,

  /// Error during download
  downloadError,

  /// Error when there is no network connection
  networkConnectedError,

  /// Error that occurs when the time is forcibly manipulated on an Android device
  detectedDeviceTimeModifiedError,

  /// Error that occurs when migrating from SDK
  migrationError,

  /// Error that occurs when a license cipher from SDK
  licenseCipherError,

  /// Unknown error type
  unknown
}
