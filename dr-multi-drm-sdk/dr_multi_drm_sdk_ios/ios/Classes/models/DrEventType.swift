//
//  EventType.swift
//  connectivity_plus
//
//  Created by sungju Yun on 2023/01/04.
//

import Foundation

enum DrEventType {
    case prepare
    case complete
    case pause
    case remove
    case stop
    case contentDataError
    case drmError
    case licenseServerError
    case downloadError
    case networkConnectedError
    case detectedDeviceTimeModifiedError
    case migrationError
    case unknownError
}

extension DrEventType {
    var name: String {
        switch self {
        case .prepare: return "prepare"
        case .complete: return "complete"
        case .pause: return "pause"
        case .remove: return "remove"
        case .stop: return "stop"
        case .contentDataError: return "contentDataError"
        case .drmError: return "drmError"
        case .licenseServerError: return "licenseServerError"
        case .downloadError: return "downloadError"
        case .networkConnectedError: return "networkConnectedError"
        case .detectedDeviceTimeModifiedError: return "detectedDeviceTimeModifiedError"
        case .migrationError: return "migrationError"
        case .unknownError: return "unknownError"
        }
    }
}
