package com.doverunner.dr_multi_drm_sdk_android

import com.doverunner.dr_multi_drm_sdk_android.sdk.WvSdk
import android.content.Context
import com.doverunner.dr_multi_drm_sdk_android.event.DownloadProgressEventImpl
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class DownloadContentHandler: EventChannel.StreamHandler {
    private var channel: EventChannel? = null
    private var context: Context? = null

    fun startListening(context: Context, messenger: BinaryMessenger) {
        if (channel != null) {
            stopListening()
        }

        channel = EventChannel(messenger, "com.doverunner.drmsdk/download_progress")
        channel?.setStreamHandler(this)
        this.context = context

//        try {
//            DownloadService.start(context, DownloadContentService::class.java)
//        } catch (e: IllegalStateException) {
//            DownloadService.startForeground(context, DownloadContentService::class.java)
//        }
    }

    fun stopListening() {
        channel?.setStreamHandler(null)
        channel = null
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        context?.let {
//            PallyConSdk.getInstance(it).setDownloadProgress(events)
            WvSdk.getInstance(it).setDownloadProgressEvent(DownloadProgressEventImpl(events))
        }

    }

    override fun onCancel(arguments: Any?) {
        context?.let {
            WvSdk.getInstance(it).setDownloadProgressEvent(null)
        }
    }
}
