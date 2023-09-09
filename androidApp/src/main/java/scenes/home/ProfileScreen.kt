package scenes.home

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
import androidx.compose.foundation.layout.width
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import scenes.common.ActionButton
import scenes.common.BottomTabBar

@OptIn(ExperimentalAnimationApi::class)
@Composable
fun ProfileScreen(navController: NavHostController) {
    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        modifier = Modifier
            .fillMaxSize())

    Column(
        modifier = Modifier
            .padding(horizontal = 16.dp)
            .fillMaxSize(),
        verticalArrangement = Arrangement.SpaceBetween
    ) 
    {
        Box(modifier = Modifier
            .padding(top = 24.dp)
            .fillMaxWidth()
            .height(252.dp)
        )
        {
            Column(modifier = Modifier
                .fillMaxSize()) {

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
                        text = "Профиль",
                        color = Color.White,
                        fontSize = MaterialTheme.typography.h4.fontSize,
                        fontWeight = FontWeight.Bold,
                        textAlign = TextAlign.Start
                    )
                }

                //NickName
                Row(
                    modifier = Modifier
                        .height(48.dp)
                        .fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(modifier = Modifier
                        .fillMaxSize(),) {

                        Text(
                            modifier = Modifier
                                .fillMaxWidth(),
                            text = "Nickname",
                            color = Color.White.copy(alpha = 0.5f),
                            fontSize = MaterialTheme.typography.subtitle2.fontSize,
                            fontWeight = FontWeight.Light,
                            textAlign = TextAlign.Start
                        )

                        Text(
                            modifier = Modifier
                                .fillMaxWidth(),
                            text = "Dimas",
                            color = Color.White,
                            fontSize = MaterialTheme.typography.subtitle1.fontSize,
                            fontWeight = FontWeight.Bold,
                            textAlign = TextAlign.Start
                        )
                    }
                }

                // Info block
                Row(
                    modifier = Modifier
                        .padding(top = 20.dp)
                        .height(92.dp)
                        .fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(
                        modifier = Modifier
                            .fillMaxSize()
                    ) {
                        separatorH()

                        Row(
                            modifier = Modifier
                                .height(90.dp)
                                .fillMaxSize(),
                            horizontalArrangement = Arrangement.Center,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Column(
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = "Секреты",
                                    color = Color.White.copy(alpha = 0.75f),
                                    fontSize = MaterialTheme.typography.subtitle2.fontSize,
                                    fontWeight = FontWeight.Light,
                                    textAlign = TextAlign.Center
                                )
                                Text(
                                    text = "12",
                                    color = Color.White,
                                    fontSize = MaterialTheme.typography.subtitle1.fontSize,
                                    fontWeight = FontWeight.Bold,
                                    textAlign = TextAlign.Center
                                )
                            }

                            Box(modifier = Modifier
                                .fillMaxHeight()
                                .padding(horizontal = 22.dp)
                                .background(color = Color.Gray)
                                .width(1.dp)
                                .padding(vertical = 20.dp)
                            )

                            Column(
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = "Девайсы",
                                    color = Color.White.copy(alpha = 0.75f),
                                    fontSize = MaterialTheme.typography.subtitle2.fontSize,
                                    fontWeight = FontWeight.Light,
                                    textAlign = TextAlign.Center
                                )
                                Text(
                                    text = "3",
                                    color = Color.White,
                                    fontSize = MaterialTheme.typography.subtitle1.fontSize,
                                    fontWeight = FontWeight.Bold,
                                    textAlign = TextAlign.Center
                                )
                            }
                        }

                        separatorH()
                    }
                }
            }
        }


        Box(modifier = Modifier
            .padding(bottom = 124.dp)
            .fillMaxWidth()
            .height(128.dp)
        )
        {
            Column(modifier = Modifier
                .fillMaxSize(),
                verticalArrangement = Arrangement.SpaceBetween
            )
            {
                ActionButton(
                    modifier = Modifier,
                    color = Color.Red,
                    paddingTop = 0.dp,
                    paddingBottom = 0.dp,
                    height = 48.dp,
                    title = "Выйти")
                {
                    // Need action handler
                }

                Box(modifier = Modifier
                    .height(800.dp)
                    .fillMaxSize()
                )
                {
                    Column(
                        modifier = Modifier
                            .fillMaxSize()
                            .padding(vertical = 20.dp),
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Text(
                            text = "Version 1.1.00.22",
                            color = Color.White.copy(alpha = 0.5f),
                            fontSize = MaterialTheme.typography.subtitle1.fontSize,
                            fontWeight = FontWeight.Normal,
                            textAlign = TextAlign.Center
                        )
                        Text(
                            text = " Powered by Slavic incorporated",
                            color = Color.White.copy(alpha = 0.5f),
                            fontSize = MaterialTheme.typography.subtitle1.fontSize,
                            fontWeight = FontWeight.Normal,
                            textAlign = TextAlign.Center
                        )
                    }
                }

            }
        }
    }
    Column(modifier = Modifier
        .fillMaxSize()
        .padding(bottom = 50.dp),
        verticalArrangement = Arrangement.Bottom) {
        BottomTabBar(navController = navController)
    }
}


@Composable
fun separatorH() {
    Box(
        modifier = Modifier
            .background(color = Color.Gray)
            .height(1.dp)
            .fillMaxWidth()
    ) {}
}