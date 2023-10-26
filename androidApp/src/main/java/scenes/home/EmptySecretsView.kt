package scenes.home

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import com.example.metasecret.android.R

@Composable
fun EmptySecretsView() {
    Column() {
        Image(
            painter = painterResource(id = R.drawable.executioner),
            contentDescription = "",
            contentScale = ContentScale.FillHeight,
            modifier = Modifier
                .fillMaxHeight()
        )
    }
}