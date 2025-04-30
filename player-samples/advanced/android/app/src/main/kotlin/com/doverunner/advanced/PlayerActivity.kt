package com.doverunner.advanced

import android.app.Activity
import android.os.Bundle
import android.view.SurfaceView
import android.widget.Toast
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.common.PlaybackException
import androidx.media3.common.Player
import androidx.media3.common.util.Util
import androidx.media3.exoplayer.source.MediaSource
import androidx.media3.ui.PlayerView
import com.doverunner.widevine.exception.WvException
import com.doverunner.widevine.exception.WvLicenseServerException
import com.doverunner.widevine.model.ContentData
import com.doverunner.widevine.model.DownloadState
import com.doverunner.widevine.model.WvEventListener
import com.doverunner.widevine.sdk.DrWvSDK
import com.google.gson.Gson

class PlayerActivity : Activity() {

    private var exoPlayer: ExoPlayer? = null
    private var wvSDK: DrWvSDK? = null
    private var playerView: PlayerView? = null

    companion object {
        const val CONTENT_DATA = "CONTENT_DATA"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_player)

        playerView = findViewById(R.id.exoplayer_view)

        // TODO : Set Sercurity API to protect media recording by screen recorder
        val view = playerView!!.videoSurfaceView as SurfaceView
//        val view = binding.surfaceView
        view.setSecure(true)
    }

    fun initializePlayer() {
        if (intent.hasExtra(CONTENT_DATA) &&
            wvSDK == null) {
            val contentDataJson: String = intent.getStringExtra(CONTENT_DATA)!!
            val contentData = Gson().fromJson(contentDataJson, ContentData::class.java)
            wvSDK = DrWvSDK.createWvSDK(
                this,
                contentData
            )

            DrWvSDK.addWvEventListener(object : WvEventListener {
                override fun onCompleted(contentData: ContentData) {
                    print("onComplete : ${contentData.contentId}")
                }

                override fun onFailed(
                    contentData: ContentData,
                    e: WvLicenseServerException?
                ) {
                    print("code:${e?.errorCode()}, message:${e?.message()}")
                }

                override fun onFailed(contentData: ContentData, e: WvException?) {
                    print(e?.msg)
                }

                override fun onRestarting(contentData: ContentData) {
                    print("onRestarting : ${contentData.contentId}")
                }

                override fun onStopped(contentData: ContentData) {
                    print("onStopped : ${contentData.contentId}")
                }

                override fun onPaused(contentData: ContentData) {
                    print("onPaused : ${contentData.contentId}")
                }

                override fun onRemoved(contentData: ContentData) {
                    print("onRemoved : ${contentData.contentId}")
                }
            })
        }

        checkLicense();
    }

    fun checkLicense() {
        try {
            val drmInfo = wvSDK?.getDrmInformation()
            drmInfo?.let {
                if ((it.licenseDuration <= 0 || it.playbackDuration <= 0) &&
                    wvSDK?.getDownloadState() == DownloadState.COMPLETED) {
                    Toast.makeText(applicationContext, "Expired license", Toast.LENGTH_LONG)
                        .show()
                }
                wvSDK?.getMediaSource()?.let { media ->
                    playContent(media)
                }
            }
        } catch (e: WvException.DrmException) {
            print(e)
            wvSDK?.downloadLicense(null, onSuccess = {
                Toast.makeText(applicationContext, "download license", Toast.LENGTH_LONG)
                    .show()
                checkLicense();
            }, onFailed = { e ->
                Toast.makeText(applicationContext, "${e.msg}", Toast.LENGTH_LONG)
                    .show()
            })
        } catch (e: WvException.DetectedDeviceTimeModifiedException) {
            print(e)
            Toast.makeText(applicationContext, "DeviceTimeModified", Toast.LENGTH_LONG)
                .show()
        } catch (e: Exception) {
            print(e)
            Toast.makeText(applicationContext, "Exception", Toast.LENGTH_LONG)
                .show()
        }
    }

    fun playContent(mediaSource: MediaSource) {
        ExoPlayer.Builder(this).build()
            .also { player ->
                exoPlayer = player
                playerView?.player = player
                exoPlayer?.setMediaSource(mediaSource)
                exoPlayer?.prepare()
                exoPlayer?.playWhenReady = true
                exoPlayer?.addListener(object : Player.Listener {
                    override fun onPlayerError(error: PlaybackException) {
                        super.onPlayerError(error)
                        if (error.errorCode ==
                            PlaybackException.ERROR_CODE_DRM_LICENSE_EXPIRED) {
                            Toast.makeText(applicationContext, "License Expired", Toast.LENGTH_SHORT).show()
                        } else {
                            Toast.makeText(applicationContext, error.message, Toast.LENGTH_SHORT).show()
                        }
                    }

                    override fun onIsPlayingChanged(isPlaying: Boolean) {
                        super.onIsPlayingChanged(isPlaying)
                        if (isPlaying && exoPlayer != null) {
//                            viewModel.setDuration(exoPlayer!!.duration)
                        }
                    }
                })
            }
    }

    override fun onStart() {
        super.onStart()
        if (Util.SDK_INT > 24 || exoPlayer != null) {
            exoPlayer?.playWhenReady = true
        }
    }

    override fun onResume() {
        super.onResume()
        exoPlayer?.playWhenReady = true
        initializePlayer()
    }

    override fun onStop() {
        super.onStop()
        exoPlayer?.playWhenReady = false
        if (isFinishing) {
            releasePlayer()
        }
    }

    private fun releasePlayer() {
        exoPlayer?.release()
    }
}
