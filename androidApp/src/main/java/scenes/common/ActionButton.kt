package scenes.common

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
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
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

@ExperimentalAnimationApi
@Stable
@Composable
public fun ActionButton(
    modifier: Modifier,
    color: Color = Color.Blue,
    paddingTop: Dp = 24.dp,
    paddingBottom: Dp = 26.dp,
    height: Dp = 63.dp,
    title: String,
    onClick: () -> Unit
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .padding(top = paddingTop)
            .padding(bottom = paddingBottom),
        verticalAlignment = Alignment.Top,
        horizontalArrangement = Arrangement.Center
    ) {
        Button(
            modifier = modifier
                .height(height)
                .fillMaxWidth()
                .fillMaxHeight()
                .clip(RoundedCornerShape(8.dp)),
            onClick = onClick,
            colors = ButtonDefaults.buttonColors(
                backgroundColor = color,
                contentColor = Color.White
            )
        ) {
            Text(text = title)
        }
    }
}