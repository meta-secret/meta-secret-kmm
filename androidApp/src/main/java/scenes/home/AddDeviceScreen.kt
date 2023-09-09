package scenes.home

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import scenes.common.AlertBubble
import scenes.common.BottomTabBar
import scenes.common.PlusButton

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun AddDeviceScreen(navController: NavHostController) {
    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        modifier = Modifier
            .fillMaxSize()
    )
    Column(
        modifier = Modifier
            .padding(horizontal = 16.dp)
            .fillMaxSize()
    )
    {
        //Title
        Row(
            modifier = Modifier
                .padding(top = 24.dp)
                .height(92.dp)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                modifier = Modifier
                    .fillMaxWidth(),
                text = "Устройства",
                color = Color.White,
                fontSize = MaterialTheme.typography.h4.fontSize,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Start
            )
        }

        AlertBubble() {}
    }

    Column(modifier = Modifier
        .fillMaxSize()
        .padding(bottom = 142.dp)
        .padding(end = 24.dp),
        horizontalAlignment = Alignment.End,
        verticalArrangement = Arrangement.Bottom)
    {
        PlusButton(modifier = Modifier) {
            println("TUT")
        }
    }

    Column(modifier = Modifier
        .fillMaxSize()
        .padding(bottom = 50.dp),
        verticalArrangement = Arrangement.Bottom) {
        BottomTabBar(navController = navController)
    }
}