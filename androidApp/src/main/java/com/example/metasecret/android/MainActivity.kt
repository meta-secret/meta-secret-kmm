package com.example.metasecret.android
import android.annotation.SuppressLint
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Scaffold
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Create
import androidx.compose.material.icons.filled.Person
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.core.view.WindowCompat
import androidx.navigation.Navigation
import androidx.navigation.compose.rememberNavController
import com.example.metasecret.android.navigation.SetupNavGraph
import dagger.hilt.android.AndroidEntryPoint
import data.BottomTabBarItemModel
import scenes.common.BottomTabBar
import scenes.common.BottomTabBarItem
import scenes.splashscreen.SplashScreenViewModel

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    @SuppressLint("UnusedMaterialScaffoldPaddingParameter")
    @OptIn(ExperimentalAnimationApi::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        setContent {
            val navController = rememberNavController()
            SetupNavGraph(navController = navController)

//            Scaffold(
//                bottomBar = {
//                    BottomTabBar(
//                        items = listOf(
//                            BottomTabBarItemModel(
//                                name = "Секреты",
//                                route = "add_secret",
//                                icon = Icons.Default.Add
//                            ),
//                            BottomTabBarItemModel(
//                                name = "Девайсы",
//                                route = "add_device",
//                                icon = Icons.Default.Create
//                            ),
//                            BottomTabBarItemModel(
//                                name = "Профиль",
//                                route = "profile",
//                                icon = Icons.Default.Person
//                            )
//                        ),
//                        navController = navController,
//                        modifier = Modifier
//                            .padding(bottom = 48.dp),
//                        onItemClick = {
//                            navController.navigate(it.route)
//                        })
//                }
//            ) {
//                SetupNavGraph(navController = navController)
//            }
        }
    }
}