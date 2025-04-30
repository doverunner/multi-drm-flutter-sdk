package com.doverunner.basic

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val channel = MethodChannel(flutterEngine.getDartExecutor(), "com.doverunner/startActivity")
        channel.setMethodCallHandler(handler)
    }

    private val handler: MethodChannel.MethodCallHandler = MethodChannel.MethodCallHandler { methodCall, result ->
        if (methodCall.method.equals("StartSecondActivity")) {
            val intent = Intent(this, PlayerActivity::class.java)
            val contentData = methodCall.arguments as? String
            intent.apply {
                contentData?.let {
                    this.putExtra(PlayerActivity.CONTENT_DATA, it)
                }
            }
            startActivity(intent)
            result.success("ActivityStarted")
        } else {
            result.notImplemented()
        }
    }
}
