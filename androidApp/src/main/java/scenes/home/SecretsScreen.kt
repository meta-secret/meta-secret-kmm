package scenes.home

import AppColors
import CustomTypography
import androidx.activity.compose.BackHandler
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
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.Button
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
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import data.ProtectionType
import data.SecretModel
import kotlinx.coroutines.launch
import scenes.common.AlertBubble
import scenes.common.BottomTabBar
import scenes.common.PlusButton

@OptIn(ExperimentalMaterialApi::class)
@ExperimentalAnimationApi
@Composable
fun SecretsScreen(navController: NavHostController) {
    val coroutineScope = rememberCoroutineScope()
    val modalSheetState = rememberModalBottomSheetState(
        initialValue = ModalBottomSheetValue.Hidden,
        confirmStateChange = { it != ModalBottomSheetValue.HalfExpanded },
        skipHalfExpanded = true
    )

    var showDialog by remember { mutableStateOf(false) }
    var showAddscreen by remember { mutableStateOf(false) }
    var currentSecret: String? = "Secret"

    val secrets = listOf<SecretModel>(
        SecretModel(description = "1234567890",
            strenghtType = ProtectionType.Max,
            secret = "Bitcoin wallet"
        )
    )


    ModalBottomSheetLayout(
        sheetState = modalSheetState,
        sheetContent = {
            AddSecretScreen(
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
                    .padding(top = 24.dp)
                    .padding(horizontal = 16.dp)
                    .fillMaxSize()
            )
            {
                //Title
                Row(
                    modifier = Modifier
                        .height(92.dp)
                        .fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        modifier = Modifier
                            .fillMaxWidth(),
                        text = stringResource(id = R.string.secrets),
                        color = AppColors.whiteMain,
                        style = CustomTypography.h1,
                        textAlign = TextAlign.Start
                    )
                }

//                if (secrets.isNotEmpty()) {
//                    AlertBubble(counter = 3) {}
//                }

                if (secrets.isEmpty()) {
                    Column(
                        modifier = Modifier
                            .fillMaxSize()
                    ) {
                        Row(
                            modifier = Modifier
                                .padding(top = 90.dp)
                                .padding(start = 30.dp)
                                .padding(bottom = 24.dp)
                                .background(color = Color.DarkGray.copy(alpha = 0f))
                                .fillMaxHeight(fraction = 0.4f)
                                .fillMaxWidth(),
                            horizontalArrangement = Arrangement.Center,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            EmptySecretsView()
                        }

                        Text(
                            modifier = Modifier
                                .fillMaxWidth(),
                            text = stringResource(id = R.string.noSecrets) ,
                            color = AppColors.whiteMain,
                            style = CustomTypography.h3,
                            textAlign = TextAlign.Center
                        )

                        Text(
                            modifier = Modifier
                                .padding(horizontal = 40.dp)
                                .padding(top = 14.dp)
                                .fillMaxWidth(),
                            text = stringResource(id = R.string.youHaveNoSecrets),
                            color = AppColors.white75,
                            style = CustomTypography.body2,
                            textAlign = TextAlign.Center
                        )
                    }
                } else {
                    Row(modifier = Modifier
                        .padding(top = 16.0.dp))
                    {
                        LazyColumn {
                            items(secrets) { secret ->
                                SecretCell(cellModel = secret) {
                                    showDialog = true
                                    currentSecret = secret.secret
                                }
                                Spacer(modifier = Modifier.height(14.dp))
                            }
                        }
                        if (showDialog && currentSecret != null) {
                            ShowSecretScreen(
                                title = currentSecret!!,
                                onClose = { showDialog = false }
                            )
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
                        if (modalSheetState.isVisible)
                            modalSheetState.hide()
                        else
                            modalSheetState.show()
                        //animateTo(ModalBottomSheetValue.Expanded)
                    }
                }
            }

            Column(modifier = Modifier
                .fillMaxSize()
                .padding(bottom = 22.dp),
                verticalArrangement = Arrangement.Bottom) {
                BottomTabBar(navController = navController)
            }

            if (showDialog || showAddscreen) {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(Color.Black.copy(alpha = 0.5f))
                )
            }








        }
    }
}