package com.doverunner.dr_multi_drm_sdk_android.models

import com.google.gson.Gson
import java.util.HashMap

data class ProgressMessage(
    val contentId: String,
    val url: String,
    val percent: Float,
    val downloadedBytes: Long
) {
    fun toJson(): String {
        return Gson().toJson(this)
    }

    fun toMap(): MutableMap<String, Any> {
        val event: MutableMap<String, Any> = HashMap()
        event["contentId"] = contentId
        event["url"] = url
        event["percent"] = percent
        event["downloadedBytes"] = downloadedBytes

        return event
    }
}