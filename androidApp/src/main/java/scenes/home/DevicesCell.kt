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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.example.metasecret.android.R
import data.DeviceModel
import data.getDeviceTypeImage

@Composable
fun DevicesCell(
    cellModel: DeviceModel,
    height: Dp = 92.dp
) {

    Row(
        modifier = Modifier
            .height(height)
            .fillMaxWidth()
            .clip(RoundedCornerShape(12.dp))
            .background(Color.White.copy(alpha = 0.05f)),
    ) {
        Row(modifier = Modifier
            .fillMaxSize()
            .padding(vertical = 12.dp)
            .padding(horizontal = 16.dp))
        {
            Column(modifier = Modifier
                .width(60.0.dp)
                .fillMaxHeight(),
                verticalArrangement = Arrangement.Center)
            {
                Image(
                    painter = painterResource(id = getDeviceTypeImage(deviceType = cellModel.deviceType)),
                    contentDescription = "",
                    modifier = Modifier
                        .fillMaxHeight()
                        .width(60.0.dp)
                )
            }
            Box(modifier = Modifier
                .fillMaxHeight()
                .width(20.0.dp)
            )
            Column(modifier = Modifier
                .weight(1f)
                .fillMaxHeight())
            {
                Text(
                    text = cellModel.name,
                    color = Color.White,
                    fontSize = MaterialTheme.typography.h6.fontSize,
                    fontWeight = FontWeight.Medium,
                    textAlign = TextAlign.Start
                )
                Text(
                    text = cellModel.deviceId,
                    color = Color.White.copy(alpha = 0.3f),
                    fontSize = MaterialTheme.typography.subtitle2.fontSize,
                    fontWeight = FontWeight.Normal,
                    textAlign = TextAlign.Start
                )
                Text(
                    text = cellModel.secretsCount,
                    color = Color.White.copy(alpha = 0.75f),
                    fontSize = MaterialTheme.typography.subtitle1.fontSize,
                    fontWeight = FontWeight.Normal,
                    textAlign = TextAlign.Start
                )
            }
            Box(modifier = Modifier
                .fillMaxHeight()
                .width(20.0.dp)
            )
            Column(modifier = Modifier
                .width(24.0.dp)
                .fillMaxHeight(),
                verticalArrangement = Arrangement.Center)
            {
                Image(
                    painter = painterResource(id = R.drawable.right_chevrone),
                    contentDescription = "",
                    modifier = Modifier
                        .height(24.0.dp)
                        .width(24.0.dp))
            }
        }
    }
}