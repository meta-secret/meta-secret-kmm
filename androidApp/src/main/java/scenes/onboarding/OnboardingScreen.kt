package scenes.onboarding

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import com.example.metasecret.android.screen.Screen
import com.google.accompanist.pager.ExperimentalPagerApi
import com.google.accompanist.pager.HorizontalPagerIndicator
import kotlinx.coroutines.launch
import scenes.common.ActionButton

@Composable
@OptIn(ExperimentalFoundationApi::class, ExperimentalAnimationApi::class,
    ExperimentalPagerApi::class
)
fun OnboardingScreen(
    navController: NavHostController
) {
    val pages = listOf(
        OnBoardingPage.First,
        OnBoardingPage.Second,
        OnBoardingPage.Third
    )

    val pagerState = rememberPagerState()
    val scope = rememberCoroutineScope()

    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        modifier = Modifier
            .fillMaxSize())

    // Main container
    Column(modifier = Modifier
        .padding(top = 68.dp)
        .padding(horizontal = 16.dp)
        .fillMaxSize(1f)) {

        //Top row with pager indicator
        Row(modifier = Modifier
            .height(30.dp)
            .fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically) {

            // Page counter
            Text(
                modifier = Modifier
                    .width(100.dp),
                text = "${pages.count()}/${pages.count()}",
                color = Color.White,
                fontSize = MaterialTheme.typography.subtitle2.fontSize,
                fontWeight = FontWeight.Normal,
                textAlign = TextAlign.Start
            )

            //Indicator
            HorizontalPagerIndicator(
                pagerState = pagerState,
                pageCount = 3,
                activeColor = Color.Blue,
                inactiveColor = Color.White,
                indicatorHeight = 8.dp,
                indicatorWidth = 8.dp
            )

            //Skip button
            Button(
                onClick = {
                    navController.popBackStack()
                    navController.navigate(Screen.SignIn.route)
                },
                modifier = Modifier
                    .width(100.dp),
                contentPadding = PaddingValues(0.dp),
                colors = ButtonDefaults.buttonColors(
                    contentColor = Color.White,
                    backgroundColor = Color.Transparent
                ),
                elevation = null
            ) {
                Text(
                    modifier = Modifier
                        .fillMaxHeight(),
                    text = "Пропустить",
                    color = Color.White,
                    fontSize = MaterialTheme.typography.subtitle2.fontSize,
                    fontWeight = FontWeight.Normal,
                    textAlign = TextAlign.End
                )
            }
        }

        Row(modifier = Modifier
            .padding(top = 24.dp)) {
            HorizontalPager(
                pageCount = 3,
                state = pagerState,
                verticalAlignment = Alignment.CenterVertically
            ) { position ->
                PagerScreen(onBoardingPage = pages[position])
            }
        }

        ActionButton(modifier = Modifier, title = "Далее") {
            scope.launch {
                if (pagerState.currentPage + 1 >= pages.count()) {
                    navController.popBackStack()
                    navController.navigate(Screen.SignIn.route)
                } else {
                    pagerState.animateScrollToPage(pagerState.currentPage + 1)
                }
            }
        }
    }
}

@Composable
fun PagerScreen(onBoardingPage: OnBoardingPage) {
    Column(
        modifier = Modifier
            .fillMaxWidth(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Top
    ) {
        Image(
            modifier = Modifier
                .fillMaxHeight(0.6f)
                .fillMaxWidth(0.5f),
            painter = painterResource(id = onBoardingPage.image),
            contentDescription = "Pager Image"
        )

        Text(modifier = Modifier
            .padding(top = 24.dp)
            .fillMaxWidth(),
            text = onBoardingPage.title,
            color = Color.White,
            fontSize = MaterialTheme.typography.h4.fontSize,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Left
        )

        Text(modifier = Modifier
            .padding(top = 18.dp)
            .fillMaxWidth(),
            text = onBoardingPage.subTitle,
            color = Color.White,
            fontSize = MaterialTheme.typography.subtitle1.fontSize,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Left
        )

        Text(modifier = Modifier
            .fillMaxWidth()
            .padding(top = 18.dp),
            text = onBoardingPage.description,
            color = Color.White,
            fontSize = MaterialTheme.typography.subtitle2.fontSize,
            fontWeight = FontWeight.Normal,
            textAlign = TextAlign.Left
        )
    }
}