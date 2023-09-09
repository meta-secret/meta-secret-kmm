package scenes.home

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import scenes.common.BottomTabBar

@Composable
fun AddDeviceScreen(navController: NavHostController) {
    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        modifier = Modifier
            .fillMaxSize()
    )
    Column(modifier = Modifier
        .fillMaxSize()
        .padding(bottom = 50.dp),
        verticalArrangement = Arrangement.Bottom) {
        BottomTabBar(navController = navController)
    }
}