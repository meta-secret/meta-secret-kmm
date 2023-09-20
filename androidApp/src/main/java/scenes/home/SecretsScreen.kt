package scenes.home

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
import androidx.compose.ui.res.painterResource
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

    var isEmpty = false
    val secrets = listOf(
        SecretModel(secret = "Yandex", strenghtType = ProtectionType.Max ),
        SecretModel(secret = "Госуслуги", strenghtType = ProtectionType.Strong ),
        SecretModel(secret = "Mail", strenghtType = ProtectionType.Strong ),
        SecretModel(secret = "FaceBoock", strenghtType = ProtectionType.Weak )
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
                modifier = Modifier
                    .fillMaxSize()
            )

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
                        text = "Секреты",
                        color = Color.White,
                        fontSize = MaterialTheme.typography.h4.fontSize,
                        fontWeight = FontWeight.Bold,
                        textAlign = TextAlign.Start
                    )
                }

                AlertBubble() {}
                if (isEmpty) {
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
                            text = "Нет секретов",
                            color = Color.White,
                            fontSize = MaterialTheme.typography.h5.fontSize,
                            fontWeight = FontWeight.Bold,
                            textAlign = TextAlign.Center
                        )

                        Text(
                            modifier = Modifier
                                .padding(horizontal = 40.dp)
                                .padding(top = 14.dp)
                                .fillMaxWidth(),
                            text = "У вас пока нет добавленых секретов. Добавьте первый секрет",
                            color = Color.White.copy(alpha = 0.7f),
                            fontSize = MaterialTheme.typography.subtitle2.fontSize,
                            fontWeight = FontWeight.Normal,
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
                .padding(bottom = 142.dp)
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
                .padding(bottom = 50.dp),
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