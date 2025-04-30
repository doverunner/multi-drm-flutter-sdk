package com.doverunner.dr_multi_drm_sdk_android.event

import EventType
import com.doverunner.widevine.model.ContentData

interface DrEvent {
    fun sendDrEvent(
        contentData: ContentData,
        eventType: EventType,
        message: String,
        errorCode: String = "",
    )

    fun sendDrEvent(
        contentId: String,
        url: String,
        eventType: EventType,
        message: String,
        errorCode: String = "",
    )
}