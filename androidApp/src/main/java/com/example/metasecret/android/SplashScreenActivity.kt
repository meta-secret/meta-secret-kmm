package com.example.metasecret.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import android.content.Intent
import java.util.*
import kotlin.concurrent.timerTask

class SplashScreenActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        System.loadLibrary("libmeta_secret_core");

        setContentView(R.layout.activity_splash_screen)

        Timer().schedule(timerTask {
            goNext()
        }, 2000)
    }

    private fun goNext() {
        startActivity(
            Intent(this, WelcomeViewActivity::class.java)
        )
    }
}