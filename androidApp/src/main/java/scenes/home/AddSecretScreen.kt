package scenes.home

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Scaffold
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Create
import androidx.compose.material.icons.filled.Person
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import androidx.navigation.compose.rememberNavController
import com.example.metasecret.android.R
import com.example.metasecret.android.navigation.SetupNavGraph
import data.BottomTabBarItemModel
import scenes.common.AlertBubble
import scenes.common.BottomTabBar
import scenes.common.PlusButton

@ExperimentalAnimationApi
@Composable
fun AddSecretScreen(navController: NavHostController) {
    var isEmpty = true
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
            println("TUT")
        }
    }

    Column(modifier = Modifier
        .fillMaxSize()
        .padding(bottom = 50.dp),
        verticalArrangement = Arrangement.Bottom) {
        BottomTabBar(navController = navController)
    }
}