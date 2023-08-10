package com.example.metasecret.android.screen

sealed class Screen(val route: String) {
    object Welcome: Screen(route = "welcome_screen")
    object Home: Screen(route = "home_screen")
    object SignIn: Screen(route = "signin_screen")
    object Splash: Screen(route = "splash_screen")
}