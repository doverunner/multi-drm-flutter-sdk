import Flutter
import Foundation

public class DownloadContentHandler: NSObject, FlutterStreamHandler {
    private var events: FlutterEventSink?

    public func startListening() {
        
    }

    public func stopListening() {
//        events?.setStreamHandler(null)
//        events = null
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        // event 연결
        self.events = events
        DrMultiSdk.shared.setDownloadProgress(eventSink: events)
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        // event 연결 해제
        DrMultiSdk.shared.setDownloadProgress(eventSink: nil)
        events = nil
        return nil
    }
}

