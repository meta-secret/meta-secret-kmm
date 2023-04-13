package com.example.metasecret

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform