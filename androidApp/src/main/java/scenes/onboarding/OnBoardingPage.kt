package scenes.onboarding

import androidx.annotation.DrawableRes
import androidx.compose.runtime.Composable
import androidx.compose.ui.res.stringResource
import com.example.metasecret.android.R

sealed class OnBoardingPage(
    @DrawableRes
    val image: Int,
    val title: Int,
    val subTitle: Int,
    val description: Int
) {
    object First: OnBoardingPage(
        image = R.drawable.first,
        title = R.string.gotSecrets,
        subTitle = R.string.splitIt,
        description = R.string.secureSafe
    )

    object Second: OnBoardingPage(
        image = R.drawable.second,
        title = R.string.gotSecrets,
        subTitle = R.string.splitIt,
        description = R.string.secureSafe
    )

    object Third: OnBoardingPage(
        image = R.drawable.third,
        title = R.string.gotSecrets,
        subTitle = R.string.splitIt,
        description = R.string.secureSafe
    )
}
