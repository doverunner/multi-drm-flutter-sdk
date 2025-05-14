import Flutter
import Foundation

public class DrEventHandler: NSObject, FlutterStreamHandler {
    private var events: FlutterEventSink?

    public func startListening() {
        
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        // event 연결
        DrMultiSdk.shared.setMultiDrmEventSink(eventSink: events)
        self.events = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        // event 연결 해제
        DrMultiSdk.shared.setMultiDrmEventSink(eventSink: nil)
        events = nil
        return nil
    }
}
