package com.doverunner.dr_multi_drm_sdk_android

import android.content.Context
import com.doverunner.dr_multi_drm_sdk_android.event.DrEventImpl
import com.doverunner.dr_multi_drm_sdk_android.sdk.WvSdk
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class DrEventHandler: EventChannel.StreamHandler {
    private var channel: EventChannel? = null
    private var context: Context? = null

    fun startListening(context: Context, messenger: BinaryMessenger) {
        if (channel != null) {
            stopListening()
        }

        print("DrmSdkHandler startListening")
        channel = EventChannel(messenger, "com.doverunner.drmsdk/dr_event")
        channel?.setStreamHandler(this)
        this.context = context
    }

    fun stopListening() {
        channel?.setStreamHandler(null)
        channel = null
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        context?.let {
            WvSdk.getInstance(it).setDrEvent(DrEventImpl(events))
        }

    }

    override fun onCancel(arguments: Any?) {
        context?.let {
            WvSdk.getInstance(it).setDrEvent(null)
        }
    }

}