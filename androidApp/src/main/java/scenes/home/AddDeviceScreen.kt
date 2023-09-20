package scenes.home

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.MaterialTheme
import androidx.compose.material.ModalBottomSheetState
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import scenes.common.ActionButton
import scenes.common.TipTextField

@OptIn(ExperimentalMaterialApi::class, ExperimentalAnimationApi::class)
@Composable
fun AddDeviceScreen(
    coroutineScope: CoroutineScope,
    modalSheetState: ModalBottomSheetState
) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color.DarkGray, shape = RoundedCornerShape(12.dp))
            .height(590.0.dp)
            .clip(shape = RoundedCornerShape(12.dp))
    ) {
        Text(
            modifier = Modifier
                .padding(top = 30.dp)
                .padding(horizontal = 16.dp)
                .fillMaxWidth(),
            text = "Добавить устройство",
            color = Color.White,
            fontSize = MaterialTheme.typography.h5.fontSize,
            fontWeight = FontWeight.Medium,
            textAlign = TextAlign.Start
        )

        Spacer(modifier = Modifier.height(24.dp))
        Text(
            modifier = Modifier
                .padding(horizontal = 16.dp)
                .fillMaxWidth(),
            text = "Для стабильной безопасности ваших паролей вам нужно иметь более 3ех устройств",
            color = Color.White,
            fontSize = MaterialTheme.typography.subtitle1.fontSize,
            fontWeight = FontWeight.Normal,
            textAlign = TextAlign.Start
        )

        Spacer(modifier = Modifier.height(24.dp))
        Box(modifier = Modifier
            .height(258.0.dp)
            .fillMaxWidth()
            .background(Color.Gray, shape = RoundedCornerShape(12.dp))
            .padding(horizontal = 16.dp)
            .clip(RoundedCornerShape(12.0.dp)),
            contentAlignment = Alignment.Center) {
        }

        Spacer(modifier = Modifier.height(24.dp))
        ActionButton(
            modifier = Modifier
                .padding(horizontal = 16.0.dp), title = "+ Добавить устройство"
        ) {
            coroutineScope.launch {
                modalSheetState.hide()
            }
        }
        Spacer(modifier = Modifier.height(30.dp))
    }
}
