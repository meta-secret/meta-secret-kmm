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
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.MaterialTheme
import androidx.compose.material.ModalBottomSheetState
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
import com.example.metasecret.android.R
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import scenes.common.ActionButton
import scenes.common.TipTextField

@OptIn(ExperimentalMaterialApi::class, ExperimentalAnimationApi::class)
@Composable
fun AddDeviceScreen(
    coroutineScope: CoroutineScope,
    modalSheetState: ModalBottomSheetState,
    showQr: Boolean = false
) {
    var showAddDeviceQr by remember { mutableStateOf(showQr) }

    val getLocationOnClick: () -> Unit = {
        coroutineScope.launch {
            modalSheetState.hide()
            showAddDeviceQr = true
            modalSheetState.show()
        }
    }

    if (showAddDeviceQr) {
        SecondStep()
    } else {
        FirstStep(onClick = getLocationOnClick)
    }
}

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun FirstStep(onClick: () -> Unit){
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .background(AppColors.blackPopUps, shape = RoundedCornerShape(12.dp))
            .height(590.0.dp)
            .clip(shape = RoundedCornerShape(12.dp))
    ) {
        Text(
            modifier = Modifier
                .padding(top = 30.dp)
                .padding(horizontal = 16.dp)
                .fillMaxWidth(),
            text = stringResource(id = R.string.addDevice),
            color = AppColors.whiteMain,
            style = CustomTypography.h3,
            textAlign = TextAlign.Start
        )

        Spacer(modifier = Modifier.height(24.dp))
        Text(
            modifier = Modifier
                .padding(horizontal = 16.dp)
                .fillMaxWidth(),
            text = stringResource(id = R.string.threeDevicesNeeded),
            color = AppColors.white75,
            style = CustomTypography.body2,
            textAlign = TextAlign.Start
        )

        Spacer(modifier = Modifier.height(24.dp))
        Row(modifier = Modifier
            .height(258.0.dp)
            .fillMaxWidth()
            .padding(horizontal = 16.dp)) {
            Box(modifier = Modifier
                .height(258.0.dp)
                .fillMaxWidth()
                .background(AppColors.white5, shape = RoundedCornerShape(12.dp))
                .clip(RoundedCornerShape(12.0.dp)),
                contentAlignment = Alignment.Center) {
                Column(modifier = Modifier
                    .fillMaxSize()) {
                    Row(modifier = Modifier
                        .height(38.dp)
                        .fillMaxWidth()
                        .padding(top = 10.dp)
                        .padding(end = 10.dp),
                        horizontalArrangement = Arrangement.End
                    ) {
                        Box(modifier = Modifier
                            .fillMaxHeight()
                            .width(57.dp)
                            .background(AppColors.blackLabel, shape = RoundedCornerShape(8.dp))
                            .clip(RoundedCornerShape(8.0.dp)),
                            contentAlignment = Alignment.Center) {
                            Text(
                                modifier = Modifier
                                    .padding(top = 3.dp)
                                    .fillMaxSize(),
                                text = stringResource(id = R.string.soon),
                                color = Color.White,
                                fontSize = MaterialTheme.typography.subtitle2.fontSize,
                                fontWeight = FontWeight.Medium,
                                textAlign = TextAlign.Center
                            )
                        }
                    }

                    Row(modifier = Modifier
                        .height(60.dp)
                        .fillMaxWidth()
                        .padding(top = 15.dp)
                        .padding(start = 33.dp),
                        horizontalArrangement = Arrangement.Start,
                        verticalAlignment = Alignment.CenterVertically,
                    ) {
                        Image(
                            painter = painterResource(id = R.drawable.cloud_key),
                            contentDescription = "",
                            modifier = Modifier
                                .height(60.dp)
                                .width(85.dp))
                        Image(
                            painter = painterResource(id = R.drawable.cloud_device),
                            contentDescription = "",
                            modifier = Modifier
                                .padding(start = 25.dp)
                                .height(35.dp)
                                .width(117.dp))
                    }

                    Row(modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 16.dp)
                        .padding(top = 57.dp),
                        horizontalArrangement = Arrangement.Start,
                    ) {
                        Column(modifier = Modifier
                            .fillMaxSize()) {
                            Text(
                                modifier = Modifier
                                    .fillMaxWidth(),
                                text = stringResource(id = R.string.notEnoughtDevices),
                                color = AppColors.whiteMain,
                                style = CustomTypography.h5,
                                textAlign = TextAlign.Start
                            )

                            Text(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(top = 12.dp),
                                text = stringResource(id = R.string.metaSecretCloud),
                                color = AppColors.white75,
                                style = CustomTypography.body2,
                                textAlign = TextAlign.Start
                            )
                        }
                    }
                }
            }
        }

        Spacer(modifier = Modifier.height(24.dp))
        ActionButton(
            modifier = Modifier
                .padding(horizontal = 8.0.dp), title = stringResource(id = R.string.plusaddDevice),
            onClick = onClick
        )
        Spacer(modifier = Modifier.height(30.dp))
    }
}

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun SecondStep(){
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .background(AppColors.blackPopUps, shape = RoundedCornerShape(12.dp))
            .height(600.0.dp)
            .clip(shape = RoundedCornerShape(12.dp))
    ) {
        Text(
            modifier = Modifier
                .padding(top = 30.dp)
                .padding(horizontal = 16.dp)
                .fillMaxWidth(),
            text = stringResource(id = R.string.addDevice),
            color = AppColors.whiteMain,
            style = CustomTypography.h3,
            textAlign = TextAlign.Start
        )

        Spacer(modifier = Modifier.height(24.dp))
        Row(modifier = Modifier
            .height(259.0.dp)
            .fillMaxWidth()
            .padding(horizontal = 16.dp)) {
            Box(modifier = Modifier
                .fillMaxSize()
                .background(AppColors.white5, shape = RoundedCornerShape(12.dp))
                .clip(RoundedCornerShape(12.0.dp)),
                contentAlignment = Alignment.Center)
            {}
        }

        Spacer(modifier = Modifier.height(24.dp))
        Row(modifier = Modifier
            .height(1.0.dp)
            .fillMaxWidth()
            .padding(horizontal = 16.dp)) {
            Box(modifier = Modifier
                .fillMaxSize()
                .background(AppColors.white5),
                contentAlignment = Alignment.Center)
            { }
        }

        Spacer(modifier = Modifier.height(10.dp))
        Text(
            modifier = Modifier
                .fillMaxWidth(),
            text = stringResource(id = R.string.useQR),
            color = AppColors.white75,
            style = CustomTypography.body2,
            textAlign = TextAlign.Center
        )

        Spacer(modifier = Modifier.height(24.dp))
        Row(modifier = Modifier
            .height(106.5.dp)
            .fillMaxWidth(),
            horizontalArrangement = Arrangement.Center,
        ) {
            Image(
                painter = painterResource(id = R.drawable.qr_code),
                contentDescription = "",
                modifier = Modifier
                    .height(106.5.dp)
                    .width(106.5.dp)
            )
        }

    }
}