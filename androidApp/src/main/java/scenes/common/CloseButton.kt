package scenes.common

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Stable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.semantics.Role.Companion.Image
import androidx.compose.ui.unit.dp
import com.example.metasecret.android.R

@ExperimentalAnimationApi
@Stable
@Composable
fun CloseButton(
    onClick: () -> Unit
) {
    Row(modifier = Modifier
        .fillMaxWidth(),
        verticalAlignment = Alignment.Top,
        horizontalArrangement = Arrangement.Center) {
        Button(
            modifier = Modifier
                .height(24.0.dp)
                .width(24.0.dp)
                .clip(RoundedCornerShape(12.0.dp)
                ),
            onClick = onClick,
            colors = ButtonDefaults.buttonColors(
                backgroundColor = Color.White.copy(alpha = 10.0f),
            )
        ) {
            Image(
                painter = painterResource(id = R.drawable.close),
                contentDescription = "",
                modifier = Modifier
                    .fillMaxSize())
        }
    }
}