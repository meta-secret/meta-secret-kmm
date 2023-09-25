package scenes.onboarding

import AppColors
import CustomTypography
import android.content.Context
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
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
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
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
    navController: NavHostController,
    viewModel: OnboardingViewModel = hiltViewModel(),
    context: Context
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
        contentScale = ContentScale.FillBounds,
        modifier = Modifier
            .background(Color.Red)
            .fillMaxSize())

    // Main container
    Column(modifier = Modifier
        .padding(top = 24.dp)
        .padding(horizontal = 16.dp)
        .fillMaxSize(1f)) {

        //Top row with pager indicator
        Row(modifier = Modifier
            .padding(top = 24.dp)
            .height(20.dp)
            .fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically) {

            // Page counter
            Text(
                modifier = Modifier
                    .width(100.dp),
                color = AppColors.white75,
                text = "${pages.count()}/${pages.count()}",
                style = CustomTypography.body2,
                textAlign = TextAlign.Start
            )

            //Indicator
            HorizontalPagerIndicator(
                pagerState = pagerState,
                pageCount = 3,
                activeColor = AppColors.actionLinkBlue,
                inactiveColor = AppColors.white50,
                indicatorHeight = 8.dp,
                indicatorWidth = 8.dp
            )

            //Skip button
            Button(
                modifier = Modifier.width(100.dp),
                onClick = {
                    viewModel.saveOnBoardingState(completed = true, context)
                    navController.popBackStack()
                    navController.navigate(Screen.SignIn.route)
                },
                contentPadding = PaddingValues(0.dp),
                colors = ButtonDefaults.buttonColors(
                    contentColor = Color.White,
                    backgroundColor = Color.Transparent
                ),
                elevation = null
            ) {
                Text(
                    modifier = Modifier
                        .fillMaxWidth(),
                    color = AppColors.white75,
                    text = stringResource(id = R.string.skip),
                    style = CustomTypography.body2,
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

        ActionButton(modifier = Modifier, height = 48.0.dp, title = stringResource(id = R.string.next)) {
            scope.launch {
                if (pagerState.currentPage + 1 >= pages.count()) {
                    viewModel.saveOnBoardingState(completed = true, context)
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
        verticalArrangement = Arrangement.SpaceBetween
    ) {
        Image(
            modifier = Modifier
                .fillMaxHeight(0.52f)
                .fillMaxWidth(0.5f),
            painter = painterResource(id = onBoardingPage.image),
            contentDescription = "Pager Image"
        )

        Text(modifier = Modifier
            .padding(top = 24.dp)
            .fillMaxWidth(),
            text = stringResource(id = onBoardingPage.title),
            color = AppColors.whiteMain,
            style = CustomTypography.h1,
            textAlign = TextAlign.Left
        )

        Text(modifier = Modifier
            .padding(top = 18.dp)
            .fillMaxWidth(),
            text = stringResource(id = onBoardingPage.subTitle),
            color = AppColors.whiteMain,
            style = CustomTypography.h4,
            textAlign = TextAlign.Left
        )

        Text(modifier = Modifier
            .fillMaxWidth()
            .padding(top = 18.dp),
            text = stringResource(id = onBoardingPage.description),
            color = AppColors.white75,
            style = CustomTypography.body2,
            textAlign = TextAlign.Left
        )
    }
}