package com.example.metasecret.android

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class MyApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        loadJNILibraries()
    }

    private fun loadJNILibraries() {
        /**
         * Loads the Crypto C++/Rust (via JNI) Library.
         *
         * IMPORTANT:
         * The name passed as argument () maps to the
         * original library name in our Rust project.
         */
        System.loadLibrary("meta_secret_core_jni")
    }
}