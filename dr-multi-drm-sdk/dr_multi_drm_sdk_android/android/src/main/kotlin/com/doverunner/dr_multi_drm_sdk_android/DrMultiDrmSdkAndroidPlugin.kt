package com.doverunner.dr_multi_drm_sdk_android

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class DrMultiDrmSdkAndroidPlugin: FlutterPlugin, ActivityAware {

//    private lateinit var channel : MethodChannel
    private lateinit var applicationContext: Context

    private var methodCallHandler: MethodCallHandlerImpl? = null
    private var downloadChangeHandler: DownloadContentHandler? = null
    private var drmMessageHandler: DrEventHandler? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("DrWvSdk", "onAttached")

        applicationContext = binding.applicationContext

        methodCallHandler = MethodCallHandlerImpl()
        methodCallHandler?.startListening(applicationContext, binding.binaryMessenger)

        drmMessageHandler = DrEventHandler()
        drmMessageHandler?.startListening(applicationContext, binding.binaryMessenger)

        downloadChangeHandler = DownloadContentHandler()
        downloadChangeHandler?.startListening(applicationContext, binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//        binding.applicationContext.unbindService()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        methodCallHandler?.let {
            it.setActivity(binding.activity)
            binding.addRequestPermissionsResultListener(it)
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        methodCallHandler?.setActivity(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        methodCallHandler?.let {
            it.setActivity(binding.activity)
            binding.addRequestPermissionsResultListener(it)
        }
    }

    override fun onDetachedFromActivity() {
        methodCallHandler?.setActivity(null)
    }
}
