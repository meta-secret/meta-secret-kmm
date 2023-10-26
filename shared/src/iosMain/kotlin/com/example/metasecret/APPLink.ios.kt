package com.example.metasecret

import platform.UIKit.UIDevice

class IOSAppLink: APPLink {
    override val appLink: String = "https://apps.apple.com/us/app/metasecret/id1644286751"
}

actual fun getAppLink(): APPLink = IOSAppLink()