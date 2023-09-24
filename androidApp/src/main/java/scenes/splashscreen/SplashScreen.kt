package scenes.splashscreen

import android.content.Context
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.example.metasecret.android.R
import com.example.metasecret.android.screen.Screen
import kotlinx.coroutines.delay
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.jetbrains.handson.kmm.shared.cache.AuthState

@Composable
fun SplashScreen(
    navController: NavHostController,
    viewModel: SplashScreenViewModel = hiltViewModel(),
    context: Context
) {
    LaunchedEffect(key1 = Unit){
        delay(2000)

        if (viewModel.readOnboardingKey(context = context)) {
            if (viewModel.checkAuth(context = context) == AuthState.ALREADY_REGISTERED) {
                navController.navigate(Screen.AddSecret.route)
            } else {
                navController.navigate(Screen.SignIn.route)
            }
        } else {
            navController.navigate(Screen.Welcome.route)
        }
    }

    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        contentScale = ContentScale.FillBounds,
        modifier = Modifier
            .background(Color.Red)
            .fillMaxSize())


        Image(
            modifier = Modifier
                .fillMaxSize(),
            painter = painterResource(id = R.drawable.main_logo),
            contentDescription = "")

    Row(
        modifier = Modifier
            .fillMaxSize(),
        horizontalArrangement = Arrangement.Center,
        verticalAlignment = Alignment.CenterVertically) {
        Image(modifier = Modifier
            .padding(top = 200.dp),
            painter = painterResource(id = R.drawable.metasecret_title_logo),
            contentDescription = "")
    }



}