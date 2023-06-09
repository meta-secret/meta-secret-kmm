package com.example.metasecret.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.example.metasecret.Greeting

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_main)
    }
}

@Composable
private fun GreetingView(text: String) {
    Text(text = text)
}

@Preview
@Composable
private fun DefaultPreview() {
//    MyApplicationTheme {
//        GreetingView("Hello, Android!")
//    }
}
