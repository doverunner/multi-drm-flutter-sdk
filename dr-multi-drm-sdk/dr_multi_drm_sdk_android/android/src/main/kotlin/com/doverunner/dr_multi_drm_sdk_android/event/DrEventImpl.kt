package com.doverunner.dr_multi_drm_sdk_android.event

import EventType
import android.os.Looper
import com.doverunner.dr_multi_drm_sdk_android.models.EventMessage
import com.doverunner.widevine.model.ContentData
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class DrEventImpl(
    private var drEvent: EventChannel.EventSink?
): DrEvent {

    override fun sendDrEvent(
        contentData: ContentData,
        eventType: EventType,
        message: String,
        errorCode: String
    ) {
        sendDrEvent(contentData.contentId ?: "",
            contentData.url ?: "",
            eventType,
            message,
            errorCode)
    }

    override fun sendDrEvent(
        contentId: String,
        url: String,
        eventType: EventType,
        message: String,
        errorCode: String
    ) {
        if (Looper.getMainLooper().thread == Thread.currentThread()) {
            drEvent?.success(
                EventMessage(
                    eventType,
                    contentId ?: "",
                    url ?: "",
                    message,
                    errorCode
                ).toMap()
            )
        } else {
            GlobalScope.launch(Dispatchers.Main) {
                drEvent?.success(
                    EventMessage(
                        eventType,
                        contentId ?: "",
                        url ?: "",
                        message,
                        errorCode
                    ).toMap()
                )
            }
        }
    }
}
