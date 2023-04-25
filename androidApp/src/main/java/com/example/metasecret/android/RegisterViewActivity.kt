package com.example.metasecret.android

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.activity.ComponentActivity

class RegisterViewActivity: ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.onboarding_register)

        val nextAction = findViewById<Button>(R.id.nextRegister)
        nextAction.setOnClickListener {
            startActivity(
                Intent(this, WelcomeDBViewActivity::class.java)
            )
        }
    }
}