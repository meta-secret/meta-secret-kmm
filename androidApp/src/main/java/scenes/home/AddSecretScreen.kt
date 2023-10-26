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
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.MaterialTheme
import androidx.compose.material.ModalBottomSheetState
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
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
import data.ProtectionType
import data.getDevicesCountText
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import scenes.common.ActionButton
import scenes.common.TipTextField


@OptIn(ExperimentalMaterialApi::class, ExperimentalAnimationApi::class)
@Composable
fun AddSecretScreen(
    coroutineScope: CoroutineScope,
    modalSheetState: ModalBottomSheetState
) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .background(AppColors.blackPopUps, shape = RoundedCornerShape(12.dp))
                .height(366.0.dp)
                .clip(shape = RoundedCornerShape(12.dp))
        ) {
            Text(modifier = Modifier
                .padding(top = 30.dp)
                .fillMaxWidth(),
                text = stringResource(id = R.string.addSecret),
                color = AppColors.whiteMain,
                style = CustomTypography.h3,
                textAlign = TextAlign.Center
            )
            Spacer(modifier = Modifier.height(20.dp))
            Row(modifier = Modifier
                .height(48.dp)
                .padding(horizontal = 16.dp)
            ) {
                TipTextField(modifier = Modifier.fillMaxWidth(),
                            placeHolder = stringResource(id = R.string.secretName),
                            errorText = stringResource(id = R.string.secretNameNeeded))
            }


            Spacer(modifier = Modifier.height(20.dp))
            Row(modifier = Modifier
                .height(48.dp)
                .padding(horizontal = 16.dp)
            ) {
                TipTextField(modifier = Modifier.fillMaxWidth(),
                            placeHolder = stringResource(id = R.string.secret),
                            errorText = stringResource(id = R.string.secretNeeded))
            }

            Spacer(modifier = Modifier.height(20.dp))

            ActionButton(modifier = Modifier
                .padding(horizontal = 16.0.dp), title = stringResource(id = R.string.addSecret)) {
                coroutineScope.launch {
                    modalSheetState.hide()
                }
            }
            Spacer(modifier = Modifier.height(30.dp))
        }
}