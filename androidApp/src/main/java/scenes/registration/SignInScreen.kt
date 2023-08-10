package scenes.registration

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
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.material.TextFieldColors
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import com.example.metasecret.android.screen.Screen
import kotlinx.coroutines.launch
import scenes.common.ActionBlueButton
import scenes.common.TipTextField

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun SignInScreen(navController: NavHostController) {
    val scope = rememberCoroutineScope()

    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        modifier = Modifier
            .fillMaxSize())

    Column(
        Modifier
            .padding(horizontal = 16.dp)
            .padding(top = 0.dp)
            .fillMaxWidth()
    ) {
        //Top logo
        Row(
            modifier = Modifier
                .fillMaxWidth(),
            horizontalArrangement = Arrangement.Center
        ) {
            Image(
                painter = painterResource(id = R.drawable.top_logo),
                contentDescription = "",
                modifier = Modifier
                    .fillMaxWidth()
                    .fillMaxHeight(0.2f))
        }
        
        //Title
        Row {
            Text(
                modifier = Modifier
                    .padding(top = 0.dp)
                    .fillMaxWidth(),
                text = "Начать работу",
                color = Color.White,
                fontSize = MaterialTheme.typography.h4.fontSize,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Left
            )
        }

        //Description
        Row {
            Text(
                modifier = Modifier
                    .padding(top = 14.dp)
                    .fillMaxWidth(),
                text = "Выберите уникальный никнейм - который вы будете использовать в дальнейшем на других устройствах или войдите по QR коду",
                color = Color.White,
                fontSize = MaterialTheme.typography.subtitle2.fontSize,
                fontWeight = FontWeight.Normal,
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
                onClick = { },
                border = BorderStroke(width = 1.dp, color = Color.White),
                shape = RoundedCornerShape(8.dp),
                colors = ButtonDefaults.buttonColors(
                    contentColor = Color.White,
                    backgroundColor = Color.Transparent
                ),
                elevation = null
            ) {
                Text(
                    modifier = Modifier
                        .fillMaxWidth(),
                    text = "Сканировать QR Code",
                    color = Color.White,
                    fontSize = MaterialTheme.typography.subtitle1.fontSize,
                    fontWeight = FontWeight.Medium,
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
                    .height(52.dp))
            }

        // Button
        ActionBlueButton(modifier = Modifier, title = "Вперед") {
            scope.launch {
                navController.popBackStack()
                navController.navigate(Screen.Home.route)
            }
        }

    }
}