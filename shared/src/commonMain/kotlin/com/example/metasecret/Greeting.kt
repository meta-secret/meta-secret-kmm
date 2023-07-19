package com.example.metasecret

class Greeting {
    private val appURL: APPLink = getAppLink()

    fun getAppUrl(): String {
        return "${appURL.appLink}"
    }
}