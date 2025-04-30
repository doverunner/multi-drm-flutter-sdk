package com.doverunner.dr_multi_drm_sdk_android.models

import EventType
import com.google.gson.Gson
import java.util.HashMap

data class EventMessage(
    val eventType: EventType,
    val contentId: String,
    val url: String,
    val message: String = "",
    val errorCode: String = ""
) {
    fun toJson(): String {
        return Gson().toJson(this)
    }

    fun toMap(): MutableMap<String, Any> {
        val event: MutableMap<String, Any> = HashMap()
        event["eventType"] = eventType.toString()
        event["contentId"] = contentId
        event["url"] = url

        if (errorCode.isNotEmpty()) {
            event["errorCode"] = errorCode
        }

        if (message.isNotEmpty()) {
            event["message"] = message
        }

        return event
    }
}
