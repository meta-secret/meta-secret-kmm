package com.example.metasecret.android.navigation

import scenes.home.HomeScreen
import scenes.onboarding.OnboardingScreen
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.example.metasecret.android.screen.Screen

@ExperimentalAnimationApi
//@ExperimentalPagerApi
@Composable
fun SetupNavGraph(
    navController: NavHostController
) {
    NavHost(navController = navController,
            startDestination = Screen.Welcome.route
    ) {
        composable(route = Screen.Welcome.route) {
            OnboardingScreen(navController = navController)
        }
        composable(route = Screen.Home.route) {
            HomeScreen()
        }
    }
}