package scenes.home

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import com.example.metasecret.android.R

@Composable
fun AddSecretScreen() {
    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        modifier = Modifier
            .fillMaxSize())
}