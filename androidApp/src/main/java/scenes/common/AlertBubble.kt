package scenes.common

import AppColors
import CustomTypography
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.defaultMinSize
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
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.example.metasecret.android.R

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun AlertBubble(
    counter: Int,
    height: Dp = 92.dp,
    onClick: () -> Unit
) {
    Button(
        modifier = Modifier
            .height(height)
            .defaultMinSize(minWidth = 1.dp, minHeight = 1.dp)
            .fillMaxWidth(),
        contentPadding = PaddingValues(),
        shape = RoundedCornerShape(12.dp),
        colors = ButtonDefaults.buttonColors(
            backgroundColor = AppColors.white5
        ),
        elevation = null,
        onClick = {}
    ) {
        Row(modifier = Modifier
            .padding(start = 16.dp, end = 6.dp)
            .fillMaxSize())
        {
            Column(modifier = Modifier
                .padding(top = 20.dp)
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
                .width(12.0.dp)
            )
            Column(modifier = Modifier
                .weight(1f)
                .padding(top = 16.dp, bottom = 16.dp, end = 30.dp)
                .fillMaxHeight())
            {
                var text = stringResource(id = R.string.needDevices)
                if (counter == 1) {
                    stringResource(id = R.string.needDevices2)
                }
                MultiStyleText(text1 = text,
                    color1 = AppColors.white75,
                    text2 = stringResource(id = R.string.plusadd),
                    color2 = AppColors.actionLinkBlue)
            }

            Column(modifier = Modifier
                .width(24.0.dp)
                .padding(top = 10.dp)
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

@Composable
fun MultiStyleText(text1: String, color1: Color, text2: String, color2: Color) {
    Text(buildAnnotatedString {
        withStyle(style = SpanStyle(fontStyle = CustomTypography.body2.fontStyle, fontSize = CustomTypography.body2.fontSize, color = color1)) {
            append(text1)
        }
        withStyle(style = SpanStyle(fontStyle = CustomTypography.body2.fontStyle, fontSize = CustomTypography.body2.fontSize, color = color2)) {
            append(text2)
        }
    })
}