package com.doverunner.dr_multi_drm_sdk_android.event

import com.doverunner.widevine.model.ContentData

interface DownloadProgressEvent {
    fun sendProgressEvent(contentData: ContentData, percent: Float, downloadedBytes: Long)
}