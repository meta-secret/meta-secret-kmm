package com.example.metasecret.android.navigation

import android.content.Context
import scenes.home.SecretsScreen
import scenes.onboarding.OnboardingScreen
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.example.metasecret.android.screen.Screen
import scenes.home.DeviceScreen
import scenes.home.ProfileScreen
import scenes.registration.SignInScreen
import scenes.splashscreen.SplashScreen

@ExperimentalAnimationApi
//@ExperimentalPagerApi
@Composable
fun SetupNavGraph(
    navController: NavHostController,
    context: Context
) {
    NavHost(navController = navController,
            startDestination = Screen.Splash.route
    ) {
        composable(route = Screen.Splash.route) {
            SplashScreen(navController = navController,
                        context = context)
        }
        composable(route = Screen.Welcome.route) {
            OnboardingScreen(navController = navController,
                            context = context)
        }
        composable(route = Screen.SignIn.route) {
            SignInScreen(navController = navController,
                        context = context)
        }
        composable(route = Screen.AddSecret.route) {
            SecretsScreen(navController = navController)
        }
        composable(route = Screen.AddDevice.route) {
            DeviceScreen(navController = navController)
        }
        composable(route = Screen.Profile.route) {
            ProfileScreen(navController = navController)
        }
    }
}