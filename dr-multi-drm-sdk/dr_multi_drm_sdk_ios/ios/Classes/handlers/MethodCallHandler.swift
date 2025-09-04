import Flutter
import Foundation

public class MethodCallHandler: NSObject {
    public func onInitialize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let siteId = arguments["siteId"] as? String else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "require arguments siteId", details: nil))
            return
        }

        DrMultiSdk.shared.initialize(siteId: siteId)
    }

    public func onRelease() {
        DrMultiSdk.shared.release()
    }

    public func onGetObjectForContent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let url = arguments["url"] as? String,
            let contentId = arguments["contentId"] as? String,
            !(arguments["token"] == nil && arguments["customData"] == nil) else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "required argument", details: nil))
            return
        }

        let token = arguments["token"] as? String
        let customData = arguments["customData"] as? String
        let cookie = arguments["cookie"] as? String
        let httpHeaders = arguments["licenseHttpHeaders"] as? Dictionary<String, String>
        let licenseUrl = arguments["licenseUrl"] as? String
        let appleCertUrl = arguments["certificateUrl"] as? String
        //let drmType = arguments["drmType"] as? String

        let object = DrMultiSdk.shared.getObjectForContent(
            url: url,
            contentId: contentId,
            token: token,
            customData: customData,
            httpHeaders: httpHeaders,
            cookie: cookie,
            drmLicenseUrl: licenseUrl,
            appleCertUrl: appleCertUrl
        )
        result(object)
    }

    public func onGetDownloadState(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let url = arguments["url"] as? String else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "url is null", details: nil))
            return
        }

        let state = DrMultiSdk.shared.getDownloadState(url: url)
        result(state)
//         let state = drmSdk?.getDownloadState(contentUrl)
//         result.success(state)
    }

    public func onAddDownload(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let url = arguments["url"] as? String,
            let contentId = arguments["contentId"] as? String,
            !(arguments["token"] == nil && arguments["customData"] == nil) else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "required argument", details: nil))
            return
        }

        let token = arguments["token"] as? String
        let customData = arguments["customData"] as? String
        let cookie = arguments["cookie"] as? String
        let httpHeaders = arguments["licenseHttpHeaders"] as? Dictionary<String, String>
        let licenseUrl = arguments["licenseUrl"] as? String
        let appleCertUrl = arguments["certificateUrl"] as? String
        //let drmType = arguments["drmType"] as? String

        DrMultiSdk.shared.addStartDownload(
            url: url,
            contentId: contentId,
            token: token,
            customData: customData,
            httpHeaders: httpHeaders,
            cookie: cookie,
            drmLicenseUrl: licenseUrl,
            appleCertUrl: appleCertUrl
        )

//         drmSdk?.addStartDownload(contentUrl!!, token, customData, httpHeaders, cookie, licenseUrl!!)
    }

    public func onStopDownload(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
              let url = arguments["url"] as? String,
              let contentId = arguments["contentId"] as? String,
              !(arguments["token"] == nil && arguments["customData"] == nil) else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "required argument", details: nil))
            return
        }
        
        let token = arguments["token"] as? String
        let customData = arguments["customData"] as? String
        let cookie = arguments["cookie"] as? String
        let httpHeaders = arguments["licenseHttpHeaders"] as? Dictionary<String, String>
        let licenseUrl = arguments["licenseUrl"] as? String
        let appleCertUrl = arguments["certificateUrl"] as? String
        //let drmType = arguments["drmType"] as? String
        
        //            DrMultiSdk.shared.stopDownload(
        //                url: url,
        //                contentId: contentId,
        //                token: token,
        //                customData: customData,
        //                httpHeaders: httpHeaders,
        //                cookie: cookie,
        //                drmLicenseUrl: licenseUrl,
        //                appleCertUrl: appleCertUrl
        //            )
        DrMultiSdk.shared.cancelDownloadTask(contentId)
    }

    public func onResumeDownloads() {
        DrMultiSdk.shared.resumeAll()
    }

    public func onCancelDownloads() {
        DrMultiSdk.shared.cancelAll()
    }

    public func onPauseDownloads() {
        DrMultiSdk.shared.pauseAll()
    }

    public func onResumeDownloadTask(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
              let url = arguments["url"] as? String,
              let contentId = arguments["contentId"] as? String else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "required argument", details: nil))
            return
        }

        if url.hasPrefix("http") {
            DrMultiSdk.shared.resumeDownloadTask(contentId)
        }
    }

    public func onCancelDownloadTask(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
              let url = arguments["url"] as? String,
              let contentId = arguments["contentId"] as? String else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "required argument", details: nil))
            return
        }

        if url.hasPrefix("http") {
            DrMultiSdk.shared.cancelDownloadTask(contentId)
        }
    }

    public func onRemoveDownload(_ call: FlutterMethodCall) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let url = arguments["url"] as? String else {
            return
        }

        DrMultiSdk.shared.removeDownload(url: url)
    }

    public func onRemoveLicense(_ call: FlutterMethodCall) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let url = arguments["url"] as? String else {
            return
        }

        DrMultiSdk.shared.removeLicense(url: url)
    }

    public func onNeedsMigrateDatabase(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let url = arguments["url"] as? String else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "url is null", details: nil))
            return
        }

        result(false)
    }

    public func onMigrateDatabase(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let url = arguments["url"] as? String else {
            result(FlutterError(code: "ILLEGAL_ARGUMENT", message: "url is null", details: nil))
            return
        }
        result(true)
    }

    public func onReDownloadCertification() {

    }

    public func onUpdateSecureTime() {

    }
}
