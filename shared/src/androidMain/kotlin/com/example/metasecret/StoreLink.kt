package com.example.metasecret

class AndroidStoreLink : StoreLink {
    override val urlString: String = "https://play.google.com/store/apps/details?id=ru.finam.android"
}

actual fun getStoreUrl(): StoreLink = AndroidStoreLink()