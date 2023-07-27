package com.example.metasecret.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.paint
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp

private const val titleTopPadding = 220.0
private const val imageBottomPadding = 63.0
private const val delay = 2.0

class SplashActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MainViews()
        }
    }
}

@Composable
fun MainViews(){
    //BG
    Box(
        modifier = with (Modifier){
            fillMaxSize()
                .paint(
                    // Replace with your image id
                    painterResource(id = R.drawable.bg_main),
                    contentScale = ContentScale.FillBounds)

        })

    // Center Logo
    Column(modifier = Modifier
        .fillMaxHeight(),
        verticalArrangement = Arrangement.Center) {

        Row(
            modifier = Modifier
                .fillMaxWidth(),
            horizontalArrangement = Arrangement.Center,
        ) {
            Image(
                modifier = Modifier
                    .size(420.dp),
                painter = painterResource(id = R.drawable.main_logo),
                contentDescription = null,
                contentScale = ContentScale.FillBounds,
            )
        }
    }

    //Title MetaSecret
    Column(modifier = Modifier
        .padding(top = titleTopPadding.dp)
        .fillMaxHeight(),
        verticalArrangement = Arrangement.Center) {
        Row(
            modifier = Modifier
                .fillMaxWidth(),
            horizontalArrangement = Arrangement.Center,
        ) {
            Image(
                painter = painterResource(id = R.drawable.metasecret_title_logo),
                contentDescription = null,
                contentScale = ContentScale.FillBounds
            )
        }
    }
}