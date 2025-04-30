//
//  EventMessage.swift
//  connectivity_plus
//
//  Created by sungju Yun on 2023/01/04.
//

import Foundation

class EventMessage {
    var contentId: String
    var url: String
    var eventType: DrEventType
    var message: String
    var errorCode: String
    
    init(contentId: String, url: String, eventType: DrEventType, message: String, errorCode: String) {
        self.contentId = contentId
        self.url = url
        self.eventType = eventType
        self.message = message
        self.errorCode = errorCode
    }
    
    public func toMap() -> Dictionary<String, String> {
        var event = [String: String]()
        
        event["eventType"] = eventType.name
        event["contentId"] = contentId
        event["url"] = url

        if (!errorCode.isEmpty) {
            event["errorCode"] = errorCode
        }

        if (!message.isEmpty) {
            event["message"] = message
        }
        
        return event
    }
}
