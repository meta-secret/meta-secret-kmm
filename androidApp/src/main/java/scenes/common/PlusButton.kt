package scenes.common

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Stable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.example.metasecret.android.R

@ExperimentalAnimationApi
@Stable
@Composable
fun PlusButton(
    modifier: Modifier,
    onClick: () -> Unit
) {
    Row(
        modifier = modifier
            .size(80.dp),
    ) {
        Button(
            modifier = modifier
                .size(80.dp)
                .clip(RoundedCornerShape(40.dp))
                .border(
                    6.dp,
                    shape = RoundedCornerShape(80.dp),
                    color = Color.White.copy(alpha = 0.25f)
                ),
            onClick = onClick,
            colors = ButtonDefaults.buttonColors(
                backgroundColor = Color.Blue,
                contentColor = Color.White
            ),
            elevation = null
        ) {
            Image(
                painter = painterResource(id = R.drawable.plus_button),
                contentDescription = "",
                modifier = Modifier
                    .height(30.0.dp)
                    .width(30.0.dp)
            )
        }
    }
}