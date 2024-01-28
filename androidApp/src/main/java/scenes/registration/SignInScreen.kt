package scenes.registration

import AppColors
import CustomTypography
import android.content.Context
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.BorderStroke
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
import androidx.compose.material.AlertDialog
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import com.example.metasecret.android.screen.Screen
import com.jetbrains.handson.kmm.shared.cache.AuthState
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import scenes.common.ActionButton
import scenes.common.TipTextField
import scenes.splashscreen.SplashScreenViewModel

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun SignInScreen(
    navController: NavHostController,
    viewModel: SignInScreenViewModel = hiltViewModel(),
    context: Context
) {
    var showAlert by remember { mutableStateOf(false) }
    val scope = rememberCoroutineScope()

    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        contentScale = ContentScale.FillBounds,
        modifier = Modifier
            .background(Color.Red)
            .fillMaxSize())

    if (showAlert) {
        AlertDialog(
            onDismissRequest = {
            },
            title = {
                Text(text = "Confirmation needed")
            },
            text = {
                Text("This name is already taken. Is it yours? Please confirm on another device.")
            },
            confirmButton = {
                Button(
                    onClick = {
                    }) {
                    Text("Ok")
                }
            }
        )
        LaunchedEffect(key1 = Unit){
            delay(10000)

            showAlert = false
            navController.popBackStack()
            navController.navigate(Screen.AddSecret.route)
        }
    }

    // Top logo
    Box(modifier = Modifier
        .padding(top = 0.dp)
        .height(196.0.dp)
        .fillMaxWidth(),
        contentAlignment = Alignment.Center)
    {
        Image(
            painter = painterResource(id = R.drawable.top_logo),
            contentDescription = "",
            contentScale = ContentScale.FillBounds,
            modifier = Modifier
                .width(68.0.dp)
                .height(68.0.dp))
        Image(
            painter = painterResource(id = R.drawable.top_logo_bg),
            contentDescription = "",
            contentScale = ContentScale.FillBounds,
            modifier = Modifier
                .width(196.0.dp)
                .height(196.0.dp))
    }

    Column(
        Modifier
            .padding(horizontal = 16.dp)
            .padding(top = 169.dp)
            .fillMaxWidth()
    ) {
        //Title
        Row {
            Text(
                modifier = Modifier
                    .padding(top = 0.dp)
                    .fillMaxWidth(),
                text = stringResource(id = R.string.letsStart),
                color = AppColors.whiteMain,
                style = CustomTypography.h3,
                textAlign = TextAlign.Left
            )
        }

        //Description
        Row {
            Text(
                modifier = Modifier
                    .padding(top = 14.dp)
                    .fillMaxWidth(),
                text = stringResource(id = R.string.chooseName),
                color = AppColors.white75,
                style = CustomTypography.body2,
                textAlign = TextAlign.Left
            )
        }

        //Scan QR button
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 26.dp)
        ) {
            Button(
                modifier = Modifier
                    .height(48.dp)
                    .clip(RoundedCornerShape(8.dp)),
                onClick = {

                },
                border = BorderStroke(width = 1.dp, color = AppColors.white50),
                shape = RoundedCornerShape(8.dp),
                colors = ButtonDefaults.buttonColors(
                    contentColor = AppColors.whiteMain,
                    backgroundColor = Color.Transparent
                ),
                elevation = null
            ) {
                Text(
                    modifier = Modifier
                        .fillMaxWidth(),
                    text = stringResource(id = R.string.scanQR),
                    color = AppColors.whiteMain,
                    style = CustomTypography.button,
                    textAlign = TextAlign.Center
                )
            }
        }

        //TextField
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 14.dp)
            ) {
                //            var text by remember { mutableStateOf(TextFieldValue("")) }
                TipTextField(modifier = Modifier
                    .fillMaxWidth()
                    .height(52.dp),
                    placeHolder = stringResource(id = R.string.chooseNamePlaceHolder),
                    errorText = stringResource(id = R.string.nameIsChosen))
            }

        // Button
        ActionButton(modifier = Modifier, title = stringResource(id = R.string.moveNext)) {
            scope.launch {
                viewModel.check()
//                showAlert = true
//                if (viewModel.checkAndSaveName(name = "", context = context)) {
//                    navController.popBackStack()
//                    navController.navigate(Screen.AddSecret.route)
//                }
            }
        }

    }
}