package com.example.metasecret

class AndroidAppLink : APPLink {
    override val appLink: String = "https://play.google.com/store/apps/details?id=ru.yandex.travel&hl=en_US"
}

actual fun getAppLink(): APPLink = AndroidAppLink()