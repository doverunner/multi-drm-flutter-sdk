package com.doverunner.dr_multi_drm_sdk_android

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import com.doverunner.dr_multi_drm_sdk_android.models.DrContentConfiguration
import com.doverunner.dr_multi_drm_sdk_android.sdk.WvSdk
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.CancellableContinuation
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import java.util.concurrent.atomic.AtomicInteger
import kotlin.coroutines.resume

class MethodCallHandlerImpl : MethodChannel.MethodCallHandler,
    PluginRegistry.RequestPermissionsResultListener {

    private var channel: MethodChannel? = null
    private var context: Context? = null
    private var activity: Activity? = null
    private var drmSdk: WvSdk? = null
    private var isInitialized: Boolean = false

    private val permissionRequestCounter = AtomicInteger(0)
    private val uid: Int
        get() = permissionRequestCounter.getAndIncrement()
    private val permissionListeners: MutableMap<Int, CancellableContinuation<Boolean>> =
        mutableMapOf()

    private val mainScope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    private val requiredPermissions = arrayOf(
        Manifest.permission.ACCESS_NETWORK_STATE,
        Manifest.permission.INTERNET,
        Manifest.permission.FOREGROUND_SERVICE
    )

    fun startListening(context: Context, messenger: BinaryMessenger) {
        if (channel != null) {
            stopListening()
        }

        channel = MethodChannel(messenger, "com.doverunner.drmsdk/android")
        channel?.setMethodCallHandler(this)
        this.context = context
        drmSdk = WvSdk.getInstance(context)
    }

    fun stopListening() {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> {
                onInitialize(call, result)
            }
            "release" -> {
                drmSdk?.release()
            }
            "getObjectForContent" -> {
                onGetObjectForContent(call, result)
            }
            "getDownloadState" -> {
                onGetDownloadState(call, result)
            }
            "addStartDownload" -> {
                onAddDownload(call, result)
            }
            "stopDownload" -> {
                onStopDownload(call, result)
            }
            "resumeDownloads" -> {
                drmSdk?.resumeAll()
            }
            "cancelDownloads" -> {
                drmSdk?.cancelAll()
            }
            "pauseDownloads" -> {
                drmSdk?.pauseAll()
            }
            "removeDownload" -> {
                onRemoveDownload(call, result)
            }
            "removeLicense" -> {
                onRemoveLicense(call, result)
            }
            "needsMigrateDatabase" -> {
                onNeedsMigrateDatabase(call, result)
            }
            "migrateDatabase" -> {
                onMigrateDatabase(call, result)
            }
            "reDownloadCertification" -> {
                onReDownloadCertification(call, result)
            }
            "updateSecureTime" -> {
                onUpdateSecureTime(call, result)
            }
        }
    }

    private suspend fun requestPermissions(vararg permissions: String): Boolean =
        suspendCancellableCoroutine { continuation ->
            requestPermissions(*permissions, continuation = continuation)
        }

    private fun requestPermissions(
        vararg permissions: String,
        continuation: CancellableContinuation<Boolean>
    ) {
        if (context == null || activity == null) {
            continuation.resume(false)
            return
        }

        val isRequestRequired =
            permissions
                .map { ActivityCompat.checkSelfPermission(context!!, it) }
                .any { result -> result == PackageManager.PERMISSION_DENIED }

        if (isRequestRequired) {
            val id = uid
            permissionListeners[id] = continuation
            ActivityCompat.requestPermissions(activity!!, permissions, id)
        } else {
            continuation.resume(true)
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ): Boolean {
        val isGranted =
            grantResults?.all { result -> result == PackageManager.PERMISSION_GRANTED } ?: false
        permissionListeners
            .remove(requestCode)
            ?.resume(isGranted)
        return isGranted
    }

    private fun onInitialize(call: MethodCall, result: MethodChannel.Result) {
        val siteId = call.argument<String>("siteId")
        val siteKey = call.argument<String>("siteKey") ?: ""
        if (siteId == null || context == null) {
            result.error("ILLEGAL_ARGUMENT", "require arguments siteId", null)
            return
        }

        mainScope.launch {
            val hasPermissions = requestPermissions(*requiredPermissions)
            if (hasPermissions) {
                drmSdk?.initialize(siteId)
                isInitialized = true
                result.success(null)
            } else {
                isInitialized = false
                result.error(
                    "PERMISSIONS_REQUIRED",          "required permissions are not granted by user",
                    null
                )
            }
        }
    }

    private fun onGetObjectForContent(call: MethodCall, result: MethodChannel.Result) {
        if (!isInitialized) {
            result.error(
                "UNINITIALIZED",
                "must be initialized before calling onGetObjectForContent()",
                null
            )
            return
        }

        val config = DrContentConfiguration.invoke(call)
        if (config == null) {
            result.error("ILLEGAL_ARGUMENT", "required argument", null)
            return
        }

        GlobalScope.launch {
            val gson = drmSdk?.getObjectForContent(config)
            result.success(gson)
        }
    }

    private fun onGetDownloadState(call: MethodCall, result: MethodChannel.Result) {
        if (!isInitialized) {
            result.error(
                "UNINITIALIZED",
                "must be initialized before calling onGetObjectForContent()",
                null
            )
            return
        }

        val config = DrContentConfiguration.invoke(call)
        if (config == null) {
            result.error("ILLEGAL_ARGUMENT", "required argument", null)
            return
        }

        val state = drmSdk?.getDownloadState(config)
        result.success(state)
    }

    private fun onAddDownload(call: MethodCall, result: MethodChannel.Result) {
        if (!isInitialized) {
            result.error(
                "UNINITIALIZED",
                "must be initialized before calling onGetObjectForContent()",
                null
            )
            return
        }

        val config = DrContentConfiguration.invoke(call)
        if (config == null) {
            result.error("ILLEGAL_ARGUMENT", "required argument", null)
            return
        }

        drmSdk?.addStartDownload(config)
    }

    private fun onStopDownload(call: MethodCall, result: MethodChannel.Result) {
        if (!isInitialized) {
            result.error(
                "UNINITIALIZED",
                "must be initialized before calling onGetObjectForContent()",
                null
            )
            return
        }

        val config = DrContentConfiguration.invoke(call)
        if (config == null) {
            result.error("ILLEGAL_ARGUMENT", "required argument", null)
            return
        }

        drmSdk?.stopDownload(config)
    }

    private fun onNeedsMigrateDatabase(call: MethodCall, result: MethodChannel.Result) {
        if (!isInitialized) {
            result.error(
                "UNINITIALIZED",
                "must be initialized before calling onGetObjectForContent()",
                null
            )
            return
        }

        val config = DrContentConfiguration.invoke(call)
        if (config == null) {
            result.error("ILLEGAL_ARGUMENT", "required argument", null)
            return
        }

        GlobalScope.launch {
            val needsMigrate = drmSdk?.needsMigrateDatabase(config)
            result.success(needsMigrate)
        }
    }

    private fun onMigrateDatabase(call: MethodCall, result: MethodChannel.Result) {
        if (!isInitialized) {
            result.error(
                "UNINITIALIZED",
                "must be initialized before calling onGetObjectForContent()",
                null
            )
            return
        }

        val config = DrContentConfiguration.invoke(call)
        if (config == null) {
            result.error("ILLEGAL_ARGUMENT", "required argument", null)
            return
        }

        GlobalScope.launch {
            val isOk = drmSdk?.migrateDatabase(config)
            result.success(isOk)
        }
    }

    private fun onReDownloadCertification(call: MethodCall, result: MethodChannel.Result) {
        if (!isInitialized) {
            result.error(
                "UNINITIALIZED",
                "must be initialized before calling onGetObjectForContent()",
                null
            )
            return
        }

        GlobalScope.launch {
            val isOk = drmSdk?.reDownloadCertification()
            result.success(isOk)
        }
    }

    private fun onRemoveDownload(call: MethodCall, result: MethodChannel.Result) {
        val config = DrContentConfiguration.invoke(call)
        if (config == null) {
            result.error("ILLEGAL_ARGUMENT", "required argument", null)
            return
        }

        val isOK = drmSdk?.removeDownload(config.contentUrl, config.contentId)
        if (isOK == null || isOK == false) {
            result.error("ILLEGAL_ARGUMENT", "check argument", null)
        }
    }

    private fun onRemoveLicense(call: MethodCall, result: MethodChannel.Result) {
        val config = DrContentConfiguration.invoke(call)
        if (config == null) {
            result.error("ILLEGAL_ARGUMENT", "required argument", null)
            return
        }

        val isOK = drmSdk?.removeLicense(config.contentUrl, config.contentId)
        if (isOK == null || isOK == false) {
            result.error("ILLEGAL_ARGUMENT", "check argument", null)
        }
    }

    private fun onUpdateSecureTime(call: MethodCall, result: MethodChannel.Result) {
        GlobalScope.launch {
            val isOk = drmSdk?.updateSecureTime()
            result.success(isOk)
        }
    }
}
