package com.example.metasecret.android.navigation

import scenes.home.HomeScreen
import scenes.onboarding.OnboardingScreen
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.example.metasecret.android.screen.Screen
import scenes.registration.SignInScreen
import scenes.splashscreen.SplashScreen

@ExperimentalAnimationApi
//@ExperimentalPagerApi
@Composable
fun SetupNavGraph(
    navController: NavHostController
) {
    NavHost(navController = navController,
            startDestination = Screen.Splash.route
    ) {
        composable(route = Screen.Splash.route) {
            SplashScreen(navController = navController)
        }
        composable(route = Screen.Welcome.route) {
            OnboardingScreen(navController = navController)
        }
        composable(route = Screen.Home.route) {
            HomeScreen()
        }
        composable(route = Screen.SignIn.route) {
            SignInScreen(navController = navController)
        }


    }
}