import Flutter
import UIKit

public class SwiftDrMultiDrmSdkIosPlugin: NSObject, FlutterPlugin {
    private var methodCallHandler: MethodCallHandler?
    private var downloadContentHandler: DownloadContentHandler?
    private var drEventHandier: DrEventHandler?

    init(_ messenger: FlutterBinaryMessenger, _ registrar: FlutterPluginRegistrar) {
        super.init()
        let methodChannel = FlutterMethodChannel(name: "com.doverunner.drmsdk/ios", binaryMessenger: registrar.messenger())

        let drEventChannel = FlutterEventChannel(name: "com.doverunner.drmsdk/dr_event", binaryMessenger: messenger)

        let downloadProgressChannel = FlutterEventChannel(name: "com.doverunner.drmsdk/download_progress", binaryMessenger: messenger)
        registrar.addMethodCallDelegate(self, channel: methodChannel)

        methodCallHandler = MethodCallHandler()

        self.drEventHandier = DrEventHandler()
        drEventChannel.setStreamHandler(self.drEventHandier)

        self.downloadContentHandler = DownloadContentHandler()
        downloadProgressChannel.setStreamHandler(downloadContentHandler)
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        //     let channel = FlutterMethodChannel(name: "com.pallycon.drmsdk/ios", binaryMessenger: registrar.messenger())
        //     let drmMessageEventChannel = FlutterEventChannel(name: "com.pallycon.drmsdk/drm_message_ios", binaryMessenger: registrar.messenger())
        //     let downloadChangeEventChannel = FlutterEventChannel(name: "com.pallycon.drmsdk/download_change_ios", binaryMessenger: registrar.messenger())
        //
        //     let instance = SwiftPallyconDrmSdkIosPlugin()
        //     instance.channel = channel
        //     registrar.addMethodCallDelegate(instance, channel: channel)
        //     drmMessageEventSink.setStreamHandler(instance)
        //     downloadChangeEventSink.setStreamHandler(instance)
        //      methodCallHandler = MethodCallHandler()

        //      methodCallHandler?.startListening(applicationContext, binding.binaryMessenger)

        //      drEventHandier = PallyConEventHandler()
        //      drEventHandier?.startListening(applicationContext, binding.binaryMessenger)

        //      downloadContentHandler = DownloadContentHandler()
        //      downloadContentHandler?.startListening(applicationContext, binding.binaryMessenger)
        let messenger: FlutterBinaryMessenger = registrar.messenger()
        let instance = SwiftDrMultiDrmSdkIosPlugin.init(messenger, registrar)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize" :
            methodCallHandler?.onInitialize(call, result: result)
        case "release" :
            methodCallHandler?.onRelease()
        case "getObjectForContent" :
            methodCallHandler?.onGetObjectForContent(call, result: result)
        case "getDownloadState" :
            methodCallHandler?.onGetDownloadState(call, result: result)
        case "addStartDownload" :
            methodCallHandler?.onAddDownload(call, result: result)
        case "stopDownload" :
            methodCallHandler?.onStopDownload(call, result: result)
        case "resumeDownloads" :
            methodCallHandler?.onResumeDownloads()
        case "cancelDownloads" :
            methodCallHandler?.onCancelDownloads()
        case "pauseDownloads" :
            methodCallHandler?.onPauseDownloads()
        case "resumeDownloadTask" :
            methodCallHandler?.onResumeDownloadTask(call, result: result)
        case "cancelDownloadTask" :
            methodCallHandler?.onCancelDownloadTask(call, result: result)
        case "removeDownload" :
            methodCallHandler?.onRemoveDownload(call)
        case "removeLicense" :
            methodCallHandler?.onRemoveLicense(call)
        case "needsMigrateDatabase":
            methodCallHandler?.onNeedsMigrateDatabase(call, result: result)
        case "migrateDatabase":
            methodCallHandler?.onMigrateDatabase(call, result: result)
        case "reDownloadCertification":
            methodCallHandler?.onReDownloadCertification()
        case "updateSecureTime":
            methodCallHandler?.onUpdateSecureTime()
        default:
            print("not define handle = " + call.method)
        }
    }

}
