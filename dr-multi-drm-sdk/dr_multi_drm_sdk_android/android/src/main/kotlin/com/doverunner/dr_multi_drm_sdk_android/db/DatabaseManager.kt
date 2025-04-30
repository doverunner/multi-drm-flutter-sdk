package com.doverunner.dr_multi_drm_sdk_android.db

import android.content.Context
import android.content.SharedPreferences
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import com.doverunner.widevine.model.ContentData
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

class DatabaseManager {
    private fun getMasterKey(): MasterKey {
        return MasterKey.Builder(context)
            .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
            .build()
    }

    fun setContents(siteId: String, list: List<ContentData>) {
        preferences?.edit()?.putString(siteId, gson.toJson(list))?.apply()
    }

    fun getContents(siteId: String): List<ContentData> {
        val string = preferences?.getString(siteId, "")
        if (string == null || string.isEmpty()) {
            return ArrayList<ContentData>().toList()
        }

        return gson.fromJson(string, object : TypeToken<List<ContentData>>() {}.type)
    }

    companion object {
        private const val APP_FILE_NAME = "pallycon_downloaded_configs"

        private var instance: DatabaseManager? = null
        private lateinit var context: Context
        private var preferences: SharedPreferences? = null
        private lateinit var gson: Gson

        fun getInstance(_context: Context): DatabaseManager {
            return instance ?: synchronized(this) {
                instance ?: DatabaseManager().also {
                    context = _context
                    instance = it
                    gson = Gson()
                    preferences = EncryptedSharedPreferences.create(
                        context,
                        APP_FILE_NAME,
                        it.getMasterKey(),
                        EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
                        EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
                    )
                }
            }
        }
    }
}
