package com.example.metasecret.android.screen

sealed class Screen(val route: String) {
    object Splash: Screen(route = "splash_screen")
    object Welcome: Screen(route = "welcome_screen")
    object SignIn: Screen(route = "signin_screen")
    object AddSecret: Screen(route = "add_secret")
    object AddDevice: Screen(route = "add_device")
    object Profile: Screen(route = "profile")
}