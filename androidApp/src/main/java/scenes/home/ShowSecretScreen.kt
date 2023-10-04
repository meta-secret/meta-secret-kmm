package scenes.home

import AppColors
import CustomTypography
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import data.ProtectionType
import data.getDevicesCountText
import scenes.common.ActionButton

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun ShowSecretScreen(
    title: String,
    onClose: () -> Unit
) {
    var showSecret by remember { mutableStateOf(false) }

    Dialog(
        onDismissRequest = { onClose() },
        properties = DialogProperties(dismissOnClickOutside = true)
    ) {
        Column(
            modifier = Modifier
                .padding(16.dp)
                .background(AppColors.blackPopUps, shape = RoundedCornerShape(12.dp))
                .height(366.0.dp)
                .clip(shape = RoundedCornerShape(12.dp))
        ) {
            Text(modifier = Modifier
                .padding(top = 30.dp)
                .fillMaxWidth(),
                text = stringResource(id = R.string.showSecret),
                color = AppColors.whiteMain,
                style = CustomTypography.h3,
                textAlign = TextAlign.Center
            )
            Spacer(modifier = Modifier.height(24.dp))
            Row(modifier = Modifier
                .fillMaxWidth()
                .height(48.dp)
                .padding(horizontal = 16.dp)) {
                Box(modifier = Modifier
                    .background(AppColors.blackBg, shape = RoundedCornerShape(8.dp))
                    .fillMaxSize()
                    .clip(RoundedCornerShape(8.0.dp)),
                    contentAlignment = Alignment.Center) {
                    Text( modifier = Modifier
                        .fillMaxWidth(),
                        text = title,
                        color = AppColors.whiteMain,
                        style = CustomTypography.body1,
                        textAlign = TextAlign.Center
                    )
                }
            }

            Spacer(modifier = Modifier.height(14.dp))
            Row(modifier = Modifier
                .fillMaxWidth()
                .height(48.dp)
                .padding(horizontal = 16.dp)) {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(AppColors.blackBg, shape = RoundedCornerShape(8.dp))
                        .padding(horizontal = 16.dp)
                        .clip(RoundedCornerShape(8.0.dp)),
                    contentAlignment = Alignment.Center
                ) {
                    var secret = ""
                    secret = if (showSecret) {
                        title
                    } else {
                        "*****"
                    }
                    Text(
                        modifier = Modifier
                            .fillMaxWidth(),
                        text = secret,
                        color = AppColors.whiteMain,
                        style = CustomTypography.body1,
                        textAlign = TextAlign.Center
                    )
                }
            }
            Spacer(modifier = Modifier.height(14.dp))
            Row(modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.0.dp),
                horizontalArrangement = Arrangement.Center
            ) {
                Image(
                    painter = painterResource(id = R.drawable.all_devices_ico),
                    contentDescription = "",
                    modifier = Modifier
                        .height(24.0.dp)
                        .width(24.0.dp)
                        .padding(end = 4.dp))

                Text(
                    text = getDevicesCountText(ProtectionType.Strong),
                    color = AppColors.white75,
                    style = CustomTypography.body2,
                    textAlign = TextAlign.Start
                )
            }

            ActionButton(modifier = Modifier
                .padding(horizontal = 16.0.dp), title = stringResource(id = R.string.show)) {
                showSecret = !showSecret
            }
            Spacer(modifier = Modifier.height(30.dp))
        }
    }
}
