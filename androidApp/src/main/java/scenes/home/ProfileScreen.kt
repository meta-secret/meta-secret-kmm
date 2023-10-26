package scenes.home

import AppColors
import CustomTypography
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
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
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
        contentScale = ContentScale.FillBounds,
        modifier = Modifier
            .background(Color.Red)
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
                        text = stringResource(id = R.string.profile),
                        color = AppColors.whiteMain,
                        style = CustomTypography.h1,
                        textAlign = TextAlign.Start
                    )
                }

                //NickName
                Row(
                    modifier = Modifier
                        .height(52.dp)
                        .fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(modifier = Modifier
                        .fillMaxSize(),) {

                        Text(
                            modifier = Modifier
                                .fillMaxWidth(),
                            text = stringResource(id = R.string.nickName),
                            color = AppColors.white75,
                            style = CustomTypography.body2,
                            textAlign = TextAlign.Start
                        )

                        Text(
                            modifier = Modifier
                                .fillMaxWidth(),
                            text = "Dimas",
                            color = AppColors.whiteMain,
                            style = CustomTypography.h3,
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
                                .height(84.dp)
                                .fillMaxSize(),
                            horizontalArrangement = Arrangement.Center,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Column(
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = stringResource(id = R.string.secrets),
                                    color = AppColors.white75,
                                    style = CustomTypography.body2,
                                    textAlign = TextAlign.Center
                                )
                                //TODO: Move 12 to common module
                                Text(
                                    text = "12",
                                    color = AppColors.whiteMain,
                                    style = CustomTypography.h3,
                                    textAlign = TextAlign.Center
                                )
                            }

                            Box(modifier = Modifier
                                .padding(horizontal = 22.dp, vertical = 20.dp)
                                .height(44.dp)
                                .background(color = AppColors.white10)
                                .width(1.dp)
                            )

                            Column(
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = stringResource(id = R.string.devices),
                                    color = AppColors.white75,
                                    style = CustomTypography.body2,
                                    textAlign = TextAlign.Center
                                )
                                Text(
                                    text = "3",
                                    color = AppColors.whiteMain,
                                    style = CustomTypography.h3,
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
                    color = AppColors.redError,
                    paddingTop = 0.dp,
                    paddingBottom = 0.dp,
                    height = 48.dp,
                    title = stringResource(id = R.string.logout))
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
                            color = AppColors.white50,
                            style = CustomTypography.body2,
                            textAlign = TextAlign.Center
                        )
                        Text(
                            text = " Powered by Slavic incorporated",
                            color = AppColors.white50,
                            style = CustomTypography.body2,
                            textAlign = TextAlign.Center
                        )
                    }
                }

            }
        }
    }
    Column(modifier = Modifier
        .fillMaxSize()
        .padding(bottom = 22.dp),
        verticalArrangement = Arrangement.Bottom) {
        BottomTabBar(navController = navController)
    }
}


@Composable
fun separatorH() {
    Box(
        modifier = Modifier
            .background(color = AppColors.white10)
            .height(1.dp)
            .fillMaxWidth()
    ) {}
}