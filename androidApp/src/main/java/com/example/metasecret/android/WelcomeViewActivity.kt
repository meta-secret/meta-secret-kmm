package com.example.metasecret.android

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.activity.ComponentActivity

class WelcomeViewActivity: ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.onboarding_welcome)

        val nextAction = findViewById<Button>(R.id.nextWelcome)
        nextAction.setOnClickListener {
            startActivity(
                Intent(this, RegisterViewActivity::class.java)
            )
        }

        val qrAction = findViewById<Button>(R.id.qrButton)
        qrAction.setOnClickListener {
            startActivity(
                Intent(this, WelcomeScannerViewActivity::class.java)
            )
        }
    }
}