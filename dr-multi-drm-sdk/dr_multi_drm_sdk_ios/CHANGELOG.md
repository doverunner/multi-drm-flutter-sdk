# Version 1.2.5

> - Version alignment for the v1.2.5 release

# Version 1.2.4

> - Pass contentHttpHeaders/contentCookie to DoveRunnerFairPlay's HLS playlist requests during download, so offline (persistable) licenses are stored correctly for contents served from CDNs that require HTTP headers
> - Requires DoveRunnerFairPlay 2.7.0 or later

# Version 1.2.3

> - Fixed licenseHttpHeaders, licenseCookie not being applied to FairPlay license requests on iOS
> - Fixed contentHttpHeaders, contentCookie not being applied to content download requests on iOS
> - Applied certificateUrl from DrContentConfiguration (falls back to the default fpsKeyManager URL when empty)
> - Included content/license headers and cookies in the playback JSON returned by getObjectForContent

# Version 1.2.2

> - Update dr_multi_drm_sdk_interface

# Version 1.2.0

> - Rebranded from PallyCon to DoveRunner

# Version 1.1.3

> - added stopDownload method to stop downloading content
> - PallyCon widevine sdk has been updated to version 4.3.2
> - gradle version has been updated to 8.9

# Version 1.1.2

> - bug fix. build error

# Version 1.1.1

> - bug fixed for android

# Version 1.1.0

> - fixed issue with content playback crashes

# Version 1.0.0

> - PallyConSDK-iOS has been released to version 1.0.0 
> - Based on PallyConWvSDK v3.1.0

