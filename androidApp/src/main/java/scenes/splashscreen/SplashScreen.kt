package scenes.splashscreen

import androidx.compose.foundation.Image
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
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController

@Composable
fun SplashScreen(
    navController: NavHostController,
    viewModel: SplashScreenViewModel = hiltViewModel()
) {
    LaunchedEffect(key1 = Unit){
        delay(2000)
        viewModel.readOnboardingKey().collect { completed ->
            navController.popBackStack()
            if (completed) {
                if (viewModel.checkAuth()) {
                    navController.navigate(Screen.AddSecret.route)
                } else {
                    navController.navigate(Screen.SignIn.route)
                }
            } else {
                navController.navigate(Screen.Welcome.route)
            }
        }
    }

    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        modifier = Modifier
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