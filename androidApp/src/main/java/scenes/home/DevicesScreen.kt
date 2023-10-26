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
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.MaterialTheme
import androidx.compose.material.ModalBottomSheetLayout
import androidx.compose.material.ModalBottomSheetValue
import androidx.compose.material.Scaffold
import androidx.compose.material.Text
import androidx.compose.material.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import data.DeviceModel
import data.DeviceType
import kotlinx.coroutines.launch
import scenes.common.AlertBubble
import scenes.common.BottomTabBar
import scenes.common.DevicesCell
import scenes.common.PlusButton

@OptIn(ExperimentalAnimationApi::class, ExperimentalMaterialApi::class)
@Composable
fun DeviceScreen(navController: NavHostController,
                 viewModel: DevicesScreenViewModel = hiltViewModel(),) {
    val coroutineScope = rememberCoroutineScope()
    val modalSheetState = rememberModalBottomSheetState(
        initialValue = ModalBottomSheetValue.Hidden,
        confirmStateChange = { it != ModalBottomSheetValue.HalfExpanded },
        skipHalfExpanded = true
    )

    var counter = 3
    val devices = viewModel.getDevices(counter = counter)

    ModalBottomSheetLayout(
        sheetState = modalSheetState,
        sheetContent = {
            AddDeviceScreen(
                coroutineScope = coroutineScope,
                modalSheetState = modalSheetState
            )
        },
        sheetBackgroundColor = Color.Transparent
    ) {
        Scaffold { innerPadding ->

            println(innerPadding)
            Image(
                painter = painterResource(id = R.drawable.bg_main),
                contentDescription = "",
                contentScale = ContentScale.FillBounds,
                modifier = Modifier
                    .background(Color.Red)
                    .fillMaxSize())
            Column(
                modifier = Modifier
                    .padding(horizontal = 16.dp)
                    .fillMaxSize()
            )
            {
                //Title
                Row(
                    modifier = Modifier
                        .padding(top = 24.dp)
                        .height(92.dp)
                        .fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        modifier = Modifier
                            .fillMaxWidth(),
                        text = stringResource(id = R.string.devices),
                        color = AppColors.whiteMain,
                        style = CustomTypography.h1,
                        textAlign = TextAlign.Start
                    )
                }

                if (devices.count() < 3) {
                    AlertBubble(counter = counter) {}
                }

                Row(modifier = Modifier
                    .padding(top = 16.0.dp))
                {
                    LazyColumn {
                        items(devices) { device ->
                            DevicesCell(cellModel = device)
                            Spacer(modifier = Modifier.height(14.dp))
                        }
                    }
                }
            }

            Column(modifier = Modifier
                .fillMaxSize()
                .padding(bottom = 114.dp)
                .padding(end = 24.dp),
                horizontalAlignment = Alignment.End,
                verticalArrangement = Arrangement.Bottom)
            {
                PlusButton(modifier = Modifier) {
                    coroutineScope.launch {
                        if (modalSheetState.isVisible) {
                            modalSheetState.hide()
                        } else {
                            modalSheetState.show()
                        }
                    }
                }
            }

            Column(modifier = Modifier
                .fillMaxSize()
                .padding(bottom = 22.dp),
                verticalArrangement = Arrangement.Bottom) {
                BottomTabBar(navController = navController)
            }
        }
    }
}