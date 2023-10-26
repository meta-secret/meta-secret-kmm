package scenes.home

import AppColors
import CustomTypography
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
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
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
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
import data.DeviceModel
import data.SecretModel
import data.getDeviceTypeImage
import data.getDevicesCountText
import data.getProtectionTypeImage
import data.getProtectionTypeText

@Composable
fun SecretCell(
    cellModel: SecretModel,
    height: Dp = 92.dp,
    onClick: () -> Unit
) {

    Row(
        modifier = Modifier
            .height(height)
            .fillMaxWidth()
            .clip(RoundedCornerShape(12.dp))
            .background(AppColors.white5),
    ) {
        Row(modifier = Modifier
            .clickable {
                onClick()
            }
            .fillMaxSize()
            .padding(vertical = 20.dp)
            .padding(horizontal = 16.dp),
            verticalAlignment = Alignment.CenterVertically)
        {
            Column(modifier = Modifier
                .weight(1f)
                .fillMaxHeight())
            {
                Text(
                    text = cellModel.secret,
                    color = AppColors.whiteMain,
                    style = CustomTypography.h5,
                    textAlign = TextAlign.Start
                )

                Row(
                    modifier = Modifier.padding(top = 4.dp)
                ) {
                    Image(
                        painter = painterResource(id = R.drawable.all_devices_ico),
                        contentDescription = "",
                        modifier = Modifier
                            .height(24.0.dp)
                            .width(24.0.dp)
                            .padding(end = 4.dp))

                    Text(
                        text = getDevicesCountText(cellModel.strenghtType),
                        color = AppColors.white75,
                        style = CustomTypography.body2,
                        textAlign = TextAlign.Start
                    )
                }
            }
            Box(modifier = Modifier
                .fillMaxHeight()
                .width(20.0.dp)
            )
            Column(modifier = Modifier
                .width(70.0.dp)
                .fillMaxHeight(),
                verticalArrangement = Arrangement.Center,
                horizontalAlignment = Alignment.CenterHorizontally)
            {
                Image(
                    painter = painterResource(id = getProtectionTypeImage(protectionType = cellModel.strenghtType)),
                    contentDescription = "",
                    modifier = Modifier
                        .height(26.0.dp)
                        .width(20.0.dp))

                Text(
                    text = getProtectionTypeText(cellModel.strenghtType),
                    color = AppColors.white75,
                    style = CustomTypography.body2,
                    textAlign = TextAlign.Start
                )
            }
        }
    }
}