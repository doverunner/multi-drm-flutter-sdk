package com.doverunner.dr_multi_drm_sdk_android.sdk

import android.content.Context
import androidx.media3.common.C
import com.doverunner.dr_multi_drm_sdk_android.db.DatabaseManager
import com.doverunner.dr_multi_drm_sdk_android.event.DownloadProgressEvent
import com.doverunner.dr_multi_drm_sdk_android.event.DrEvent
import com.google.gson.Gson
import com.doverunner.dr_multi_drm_sdk_android.models.*
import com.doverunner.widevine.exception.WvException
import com.doverunner.widevine.exception.WvLicenseServerException
import com.doverunner.widevine.model.ContentData
import com.doverunner.widevine.model.DownloadState
import com.doverunner.widevine.model.DrmConfigration
import com.doverunner.widevine.model.WvEventListener
import com.doverunner.widevine.sdk.DrWvSDK
import com.doverunner.widevine.track.DownloaderTracks
import kotlinx.coroutines.*


class WvSdk(private val context: Context) {
    companion object {
        @Volatile
        private var instance: WvSdk? = null

        fun getInstance(context: Context): WvSdk {
            return instance ?: synchronized(this) {
                instance ?: WvSdk(context.applicationContext).also { instance = it }
            }
        }
    }

    private var drEvent: DrEvent? = null
    private var progressEvent: DownloadProgressEvent? = null

    private var siteId: String? = null
    private val wvSDKList = mutableMapOf<String, DrWvSDK>()
    private val contentDataList = mutableListOf<ContentData>()

    private val listener: WvEventListener = object : WvEventListener {
        override fun onCompleted(contentData: com.doverunner.widevine.model.ContentData) {
            instance?.drEvent?.sendDrEvent(
                contentData,
                EventType.Completed,
                "download completed"
            )
        }

        override fun onProgress(
            contentData: com.doverunner.widevine.model.ContentData,
            percent: Float,
            downloadedBytes: Long,
        ) {
            instance?.progressEvent?.sendProgressEvent(contentData, percent, downloadedBytes)
        }

        override fun onStopped(contentData: com.doverunner.widevine.model.ContentData) {
            instance?.drEvent?.sendDrEvent(contentData, EventType.Stop, "download stop")
        }

        override fun onRestarting(contentData: com.doverunner.widevine.model.ContentData) {
            print("onRestarting")
        }

        override fun onRemoved(contentData: com.doverunner.widevine.model.ContentData) {
            instance?.drEvent?.sendDrEvent(
                contentData,
                EventType.Removed,
                "downloaded content is removed"
            )
        }

        override fun onPaused(contentData: com.doverunner.widevine.model.ContentData) {
            contentDataList.forEach { content ->
                instance?.drEvent?.sendDrEvent(
                    content,
                    EventType.Paused,
                    "download paused"
                )
            }
        }

        override fun onFailed(
            contentData: com.doverunner.widevine.model.ContentData,
            e: WvException?,
        ) {
            when (e) {
                is WvException.ContentDataException ->
                    instance?.drEvent?.sendDrEvent(
                        contentData,
                        EventType.ContentDataError,
                        e.msg
                    )

                is WvException.DrmException ->
                    instance?.drEvent?.sendDrEvent(contentData, EventType.DrmError, e.msg)

                is WvException.DownloadException ->
                    instance?.drEvent?.sendDrEvent(
                        contentData,
                        EventType.DownloadError,
                        e.msg
                    )

                is WvException.NetworkConnectedException ->
                    instance?.drEvent?.sendDrEvent(
                        contentData,
                        EventType.NetworkConnectedError,
                        e.msg
                    )

                is WvException.DetectedDeviceTimeModifiedException ->
                    instance?.drEvent?.sendDrEvent(
                        contentData,
                        EventType.DetectedDeviceTimeModifiedError,
                        e.msg
                    )

                is WvException.MigrationException ->
                    instance?.drEvent?.sendDrEvent(
                        contentData,
                        EventType.MigrationError,
                        e.msg
                    )

                is WvException.WvLicenseCipherException ->
                    instance?.drEvent?.sendDrEvent(
                        contentData,
                        EventType.LicenseCipherError,
                        e.msg
                    )

                else ->
                    instance?.drEvent?.sendDrEvent(
                        contentData, EventType.UnknownError,
                        e?.msg ?: "unknown error"
                    )
            }
        }

        override fun onFailed(
            contentData: com.doverunner.widevine.model.ContentData,
            e: WvLicenseServerException?,
        ) {
            e?.let {
                instance?.drEvent?.sendDrEvent(
                    contentData, EventType.LicenseServerError,
                    it.message(), it.errorCode().toString()
                )
            }
        }
    }

    fun setDrEvent(drEvent: DrEvent?) {
        this.drEvent = drEvent
        DrWvSDK.removeWvEventListener(listener)
        DrWvSDK.addWvEventListener(listener)
//        wvSDKList.entries.firstOrNull()?.let { (_, sdk) ->
//            sdk.setPallyConEventListener(listener)
//        }
    }

    fun setDownloadProgressEvent(downloadProgressEvent: DownloadProgressEvent?) {
        this.progressEvent = downloadProgressEvent
    }

    fun initialize(siteId: String) {
        this.siteId = siteId

        DrWvSDK.addWvEventListener(listener)
        loadDownloaded()
    }

    fun release() {
        DrWvSDK.removeWvEventListener(listener)
        wvSDKList.forEach { sdk ->
            sdk.value.release()
        }
        contentDataList.clear()
    }

    private fun loadDownloaded() {
        if (contentDataList.isEmpty()) {
            if (siteId == null) {
                return
            }
            val db = DatabaseManager.getInstance(context)
            contentDataList.addAll(db.getContents(siteId!!))
            contentDataList.forEach() { contentData ->
                contentData.contentId?.let {
                    wvSDKList[it] = DrWvSDK.createWvSDK(
                        context,
                        contentData
                    )
                }
            }
        }
    }

    fun saveDownloadedContent() {
        siteId?.let {
            DatabaseManager.getInstance(context).setContents(it, contentDataList)
        }
    }

    suspend fun getObjectForContent(config: DrContentConfiguration): String {
        return suspendCancellableCoroutine<String> { continuation ->
            if (wvSDKList[config.contentId] != null && config.contentUrl != null) {
                wvSDKList[config.contentId]!!.updateSecure({
                    print("update secure time")
                    val index =
                        contentDataList.indices.find { contentDataList[it].url == config.contentUrl }
                    if (index != null) {
                        val gson = Gson().toJson(contentDataList[index])
                        continuation.resume(gson, null)
                    } else {
                        continuation.resume(config.contentUrl!!, null)
                    }
                }, { e ->
                    drEvent?.sendDrEvent(
                        config.contentId,
                        config.contentUrl,
                        EventType.DetectedDeviceTimeModifiedError,
                        e.msg
                    )
                    continuation.resume("", null)
                })
            } else {
                // streaming
                val contentData = createContentData(config)
                val gson = Gson().toJson(contentData)
                continuation.resume(gson, null)
            }
        }
    }

    fun getDownloadState(config: DrContentConfiguration): String {
        var stateString = "NOT"
        wvSDKList[config.contentId]?.let {
            val state = it.getDownloadState()
            stateString = when (state) {
                DownloadState.DOWNLOADING, DownloadState.RESTARTING -> DownloadState.DOWNLOADING.toString()
                DownloadState.COMPLETED -> DownloadState.COMPLETED.toString()
                DownloadState.PAUSED, DownloadState.STOPPED -> DownloadState.PAUSED.toString()
                else -> DownloadState.NOT.toString()
            }
        }

        return stateString
    }

    fun addStartDownload(config: DrContentConfiguration) {
        val data = createContentData(config)

        if (!contentDataList.contains(data)) {
            contentDataList.add(data)
        }

        wvSDKList[config.contentId!!] = DrWvSDK.createWvSDK(
            context,
            data
        )

        wvSDKList[config.contentId]?.also { sdk ->
            sdk.updateSecure({
                print("update secure time")
            }, {
                print("failed update secure time. ${it.msg}")
            })

            sdk.getContentTrackInfo({ tracks ->
                saveDownloadedContent()
                downloadContent(config, tracks)
            }, { e ->
                when (e) {
                    is WvException.NetworkConnectedException ->
                        drEvent?.sendDrEvent(
                            config.contentId,
                            config.contentUrl,
                            EventType.NetworkConnectedError,
                            e.msg
                        )

                    is WvException.ContentDataException ->
                        drEvent?.sendDrEvent(
                            config.contentId,
                            config.contentUrl,
                            EventType.ContentDataError,
                            e.msg
                        )

                    else ->
                        drEvent?.sendDrEvent(
                            config.contentId,
                            config.contentUrl,
                            EventType.DownloadError,
                            e.msg
                        )
                }
            })
        }
    }

    fun downloadContent(config: DrContentConfiguration, tracks: DownloaderTracks) {
        wvSDKList[config.contentId]?.also { sdk ->
            for (i in tracks.audio.indices) {
                tracks.audio[i].isDownload = true
            }
            for (i in tracks.text.indices) {
                tracks.text[i].isDownload = true
            }

            try {
                sdk.download(tracks)
            } catch (e: WvException.ContentDataException) {
                drEvent?.sendDrEvent(
                    config.contentId,
                    config.contentUrl,
                    EventType.ContentDataError,
                    e.msg
                )
            } catch (e: WvException.DownloadException) {
                drEvent?.sendDrEvent(
                    config.contentId, config.contentUrl,
                    EventType.DownloadError, e.msg
                )
            }
        }
    }

    fun stopDownload(config: DrContentConfiguration) {
        val data = createContentData(config)

        wvSDKList[config.contentId]?.also { sdk ->
            sdk.stop()
        }
    }

    fun resumeAll() {
        for (sdk in wvSDKList.entries.iterator()) {
            sdk.value.resumeAll()
            break
        }
    }

    fun cancelAll() {
        pauseAll()
        for (sdk in wvSDKList.entries.iterator()) {
            val contentData = contentDataList.find { it.contentId == sdk.key }
            contentData?.url?.let {
                removeDownload(it, sdk.key)
            }
        }
    }

    fun pauseAll() {
        for (sdk in wvSDKList.entries.iterator()) {
            sdk.value.pauseAll()
            break
        }
    }

    fun removeDownload(url: String, contentId: String): Boolean {
        return if (wvSDKList.containsKey(contentId)) {
            try {
                wvSDKList[contentId]!!.remove()
                true
            } catch (e: WvException.ContentDataException) {
                drEvent?.sendDrEvent(contentId, url, EventType.ContentDataError, e.msg)
                false
            } catch (e: WvException.DownloadException) {
                drEvent?.sendDrEvent(contentId, url, EventType.DownloadError, e.msg)
                false
            }
        } else {
            false
        }
    }

    fun removeLicense(url: String, contentId: String): Boolean {
        return if (wvSDKList.containsKey(contentId)) {
            try {
                wvSDKList[contentId]!!.removeLicense()
                true
            } catch (e: WvException.ContentDataException) {
                drEvent?.sendDrEvent(contentId, url, EventType.ContentDataError, e.msg)
                false
            } catch (e: WvException.DownloadException) {
                drEvent?.sendDrEvent(contentId, url, EventType.DownloadError, e.msg)
                false
            }
        } else {
            false
        }
    }

    suspend fun needsMigrateDatabase(config: DrContentConfiguration): Boolean {
        if (siteId == null) {
            print("initialize function must be executed first.")
            return false
        }

        if (wvSDKList.size != contentDataList.size) {
            return true
        }

        wvSDKList[config.contentId]?.let {
            return it.needsMigrateDownloadedContent()
        }

        return false
    }

    suspend fun migrateDatabase(config: DrContentConfiguration): Boolean {
        if (siteId == null) {
            print("initialize function must be executed first.")
            return false
        }

        if (contentDataList.size != wvSDKList.size) {
            for (i in 0..contentDataList.lastIndex) {
                if (contentDataList[i].contentId == null &&
                    contentDataList[i].url == config.contentUrl
                ) {
                    contentDataList[i].contentId = config.contentId
                }
            }
            saveDownloadedContent()
            release()
            loadDownloaded()
        }

        var isOK = true
        if (config.contentId == null) {
            return false
        }

        wvSDKList[config.contentId]?.let {
            isOK = it.migrateDownloadedContent(config.contentId!!, null)
        }

        return isOK
    }

    suspend fun reDownloadCertification(): Boolean {
        return suspendCancellableCoroutine<Boolean> { continuation ->
            if (wvSDKList.isNotEmpty()) {
                wvSDKList.entries.first().value.reProvisionRequest({
                    continuation.resume(true, null)
                }, { e ->
                    drEvent?.sendDrEvent(
                        "",
                        wvSDKList.entries.first().key,
                        EventType.DrmError,
                        e.msg
                    )
                    continuation.resume(false, null)
                })
            } else {
                drEvent?.sendDrEvent(
                    "",
                    "",
                    EventType.ContentDataError,
                    "No content has been downloaded."
                )
                continuation.resume(false, null)
            }
        }
    }

    suspend fun updateSecureTime(): Boolean {
        return suspendCancellableCoroutine<Boolean> { continuation ->
            if (wvSDKList.isNotEmpty()) {
                wvSDKList.entries.first().value.updateSecure({
                    continuation.resume(true, null)
                }, { e ->
                    drEvent?.sendDrEvent(
                        wvSDKList.entries.first().key,
                        "",
                        EventType.DrmError,
                        e.msg
                    )
                    continuation.resume(false, null)
                })
            } else {
                drEvent?.sendDrEvent(
                    "",
                    "",
                    EventType.ContentDataError,
                    "No content has been downloaded."
                )
                continuation.resume(false, null)
            }
        }
    }

    fun createContentData(config: DrContentConfiguration): ContentData {
        if (siteId == null) {
            print("initialize function must be executed first.")
            return ContentData(
                contentId = config.contentId,
                url = config.contentUrl,
                cookie = config.contentCookie,
            )
        }

        var contentHeaders: MutableMap<String?, String?>? = null
        if (config.contentHttpHeaders != null) {
            contentHeaders = config.contentHttpHeaders!!.toMutableMap()
        }

        var licenseHeaders: MutableMap<String?, String?>? = null
        if (config.licenseHttpHeaders != null) {
            licenseHeaders = config.licenseHttpHeaders!!.toMutableMap()
        }

        val cipherPath = if (config.licenseCipherTablePath != null &&
            config.licenseCipherTablePath!!.isNotEmpty()
        ) {
            config.licenseCipherTablePath
        } else {
            null
        }

        val drmConfig = DrmConfigration(
            siteId = siteId!!,
            siteKey = null,
            token = config.token,
            customData = config.customData,
            httpHeaders = licenseHeaders,
            cookie = config.licenseCookie,
            licenseCipherPath = cipherPath,
            drmLicenseUrl = config.licenseUrl
                ?: "https://drm-license.doverunner.com/ri/licenseManager.do",
            C.WIDEVINE_UUID
        )

        return ContentData(
            contentId = config.contentId,
            url = config.contentUrl,
            drmConfig = drmConfig,
            cookie = config.contentCookie,
            httpHeaders = contentHeaders
        )
    }
}
