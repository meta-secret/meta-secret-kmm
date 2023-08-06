package scenes.onboarding

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
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
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.FloatingActionButtonDefaults
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Stable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import com.example.metasecret.android.R
import com.google.accompanist.pager.ExperimentalPagerApi
import com.google.accompanist.pager.HorizontalPagerIndicator

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

    Image(
        painter = painterResource(id = R.drawable.bg_main),
        contentDescription = "",
        modifier = Modifier
            .fillMaxSize())

    // Main container
    Column(modifier = Modifier
        .padding(top = 68.dp)
        .padding(horizontal = 16.dp)
        .fillMaxSize()) {

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
                onClick = { },
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

        NextButton(modifier = Modifier) {}
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
                .fillMaxWidth(0.5f),
            painter = painterResource(id = onBoardingPage.image),
            contentDescription = "Pager Image"
        )

        Text(modifier = Modifier
            .fillMaxWidth(),
            text = onBoardingPage.title,
            color = Color.White,
            fontSize = MaterialTheme.typography.h4.fontSize,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )

        Text(modifier = Modifier
            .fillMaxWidth(),
            text = onBoardingPage.subTitle,
            color = Color.White,
            fontSize = MaterialTheme.typography.subtitle1.fontSize,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )

        Text(modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 40.dp)
            .padding(top = 20.dp),
            text = onBoardingPage.description,
            color = Color.White,
            fontSize = MaterialTheme.typography.subtitle2.fontSize,
            fontWeight = FontWeight.Normal,
            textAlign = TextAlign.Center
        )
    }
}

@ExperimentalAnimationApi
@Stable
@Composable
fun NextButton(
    modifier: Modifier,
    onClick: () -> Unit
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .padding(top = 24.dp)
            .padding(bottom = 26.dp),
        verticalAlignment = Alignment.Top,
        horizontalArrangement = Arrangement.Center
    ) {
            Button(
                modifier = modifier
                    .fillMaxWidth()
                    .height(63.dp)
                    .clip(RoundedCornerShape(8.dp)),
                onClick = onClick,
                colors = ButtonDefaults.buttonColors(
                    contentColor = Color.White
                )
            ) {
                Text(text = "Далее")
            }
    }
}