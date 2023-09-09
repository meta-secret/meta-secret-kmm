package scenes.common

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.example.metasecret.android.R

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun AlertBubble(
    height: Dp = 92.dp,
    onClick: () -> Unit
) {

    Button(
        modifier = Modifier
            .height(height)
            .fillMaxWidth(),
        shape = RoundedCornerShape(12.dp),
        colors = ButtonDefaults.buttonColors(
            backgroundColor = Color.White.copy(alpha = 0.05F)
        ),
        elevation = null,
        onClick = {}
    ) {
        Row(modifier = Modifier
            .fillMaxSize()
            .padding(top = 16.dp)
            .padding(bottom = 8.dp))
        {
            Column(modifier = Modifier
                .width(24.0.dp)
                .fillMaxHeight(),
                verticalArrangement = Arrangement.Top)
            {
                Image(
                    painter = painterResource(id = R.drawable.warning_sign),
                    contentDescription = "",
                    modifier = Modifier
                        .height(24.0.dp)
                        .width(24.0.dp)
                )
            }
            Box(modifier = Modifier
                .fillMaxHeight()
                .width(14.0.dp)
            )
            Column(modifier = Modifier
                .weight(1f)
                .fillMaxHeight())
            {
                Text(
                    text = "Не хватает 2ух утройств чтобы ваши секреты были в безопастности +Добавить",
                    color = Color.White.copy(alpha = 0.75f)
                )
            }
            Box(modifier = Modifier
                .fillMaxHeight()
                .width(14.0.dp)
            )
            Column(modifier = Modifier
                .width(24.0.dp)
                .fillMaxHeight(),
                verticalArrangement = Arrangement.Top)
            {
                Image(
                    painter = painterResource(id = R.drawable.close),
                    contentDescription = "",
                    modifier = Modifier
                        .height(24.0.dp)
                        .width(24.0.dp)
                )
            }
        }
    }
}