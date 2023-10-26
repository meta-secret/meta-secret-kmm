package com.example.metasecret

interface APPLink {
    val appLink: String
}

expect fun getAppLink(): APPLink