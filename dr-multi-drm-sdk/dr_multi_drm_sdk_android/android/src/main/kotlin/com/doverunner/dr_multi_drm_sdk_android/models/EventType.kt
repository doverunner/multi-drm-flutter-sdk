enum class EventType(private var type: String) {
    Prepared("prepare"),
    Completed("complete"),
    Paused("pause"),
    Removed("remove"),
    Stop("stop"),
    ContentDataError("contentDataError"),
    DrmError("drmError"),
    LicenseServerError("licenseServerError"),
    DownloadError("downloadError"),
    NetworkConnectedError("networkConnectedError"),
    DetectedDeviceTimeModifiedError("detectedDeviceTimeModifiedError"),
    MigrationError("migrationError"),
    LicenseCipherError("licenseCipherError"),
    UnknownError("unknownError");

    override fun toString(): String {
        return type
    }
}
