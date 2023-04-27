package com.example.metasecret

import platform.UIKit.UIDevice

class IOSStoreLink: StoreLink {
    override val urlString: String = "https://apps.apple.com/ru/app/metasecret/id1644286751/"
}

actual fun getStoreUrl(): StoreLink = IOSStoreLink()