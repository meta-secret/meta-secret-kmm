package Scenes.Onboarding

import androidx.annotation.DrawableRes
import com.example.metasecret.android.R

sealed class OnBoardingPage(
    @DrawableRes
    val image: Int,
    val title: String,
    val subTitle: String,
    val description: String
) {
    object First: OnBoardingPage(
        image = R.drawable.first,
        title = "Есть очень важные секреты ?",
        subTitle = "Поделите их между своими устроствами",
        description = "Все пароли и секретная ифнормация храниться только на ваших устройствах и надежно защищены  по стандартам шифтрования RSA и AES"
    )

    object Second: OnBoardingPage(
        image = R.drawable.second,
        title = "Есть очень важные секреты ?",
        subTitle = "Поделите их между своими устроствами",
        description = "Все пароли и секретная ифнормация храниться только на ваших устройствах и надежно защищены  по стандартам шифтрования RSA и AES"
    )

    object Third: OnBoardingPage(
        image = R.drawable.third,
        title = "Есть очень важные секреты ?",
        subTitle = "Поделите их между своими устроствами",
        description = "Все пароли и секретная ифнормация храниться только на ваших устройствах и надежно защищены  по стандартам шифтрования RSA и AES"
    )
}