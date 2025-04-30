//
//  DownloadState.swift
//  pallycon_drm_sdk_ios
//
//  Created by sungju Yun on 2023/01/05.
//

import Foundation

enum DownloadState {
    case downloading
    case completed
    case pause
    case not
}

extension DownloadState {
    var name: String {
        switch self {
        case .downloading: return "DOWNLOADING"
        case .completed: return "COMPLETED"
        case .pause: return "PAUSED"
        case .not: return "NOT"
        }
    }
}
