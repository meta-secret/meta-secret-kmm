package com.example.metasecret.android

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.activity.ComponentActivity

class WelcomeDBViewActivity: ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.onboarding_db)

        val nextAction = findViewById<Button>(R.id.nextDb)
        nextAction.setOnClickListener {
            startActivity(
                Intent(this, WelcomeQRViewActivity::class.java)
            )
        }
    }
}