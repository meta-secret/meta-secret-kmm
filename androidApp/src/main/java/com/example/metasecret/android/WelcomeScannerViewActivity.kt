package com.example.metasecret.android

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.activity.ComponentActivity

class WelcomeScannerViewActivity: ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.onboarding_qr_scaner)
    }
}