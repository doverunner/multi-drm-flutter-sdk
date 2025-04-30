package com.doverunner.dr_multi_drm_sdk_android.models

import io.flutter.plugin.common.MethodCall

data class DrContentConfiguration(
    var contentUrl: String,
    var contentId: String,
    var token: String?,
    var customData: String?,
    var contentCookie: String?,
    var contentHttpHeaders: Map<String, String>?,
    var licenseCookie: String?,
    var licenseHttpHeaders: Map<String, String>?,
    var licenseUrl: String,
    var licenseCipherTablePath: String?
) {
    companion object {
        operator fun invoke(call: MethodCall): DrContentConfiguration? {
            val contentUrl = call.argument<String>("url")
            val contentId = call.argument<String>("contentId")
            val token = call.argument<String>("token")
            val customData = call.argument<String>("customData")
            val contentCookie = call.argument<String>("contentCookie")
            val contentHttpHeaders = call.argument<Map<String, String>>("contentHttpHeaders")
            val licenseCookie = call.argument<String>("licenseCookie")
            val licenseHttpHeaders = call.argument<Map<String, String>>("licenseHttpHeaders")
            val licenseUrl = call.argument<String>("licenseUrl")
            val licenseCipherTablePath = call.argument<String>("licenseCipherTablePath")
            if (contentUrl == null || contentId == null || licenseUrl == null || (token == null && customData == null)) {
                return null
            }

            return DrContentConfiguration(
                contentUrl,
                contentId,
                token,
                customData,
                contentCookie,
                contentHttpHeaders,
                licenseCookie,
                licenseHttpHeaders,
                licenseUrl,
                licenseCipherTablePath
            )
        }
    }
}