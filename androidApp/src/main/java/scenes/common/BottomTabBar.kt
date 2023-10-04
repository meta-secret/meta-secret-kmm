package scenes.common

import AppColors
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.material.BottomNavigation
import androidx.compose.material.BottomNavigationItem
import androidx.compose.material.Icon
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Phone
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.NavHostController
import androidx.navigation.compose.currentBackStackEntryAsState
import com.example.metasecret.android.R
import com.example.metasecret.android.screen.Screen
import data.BottomTabBarItemModel

@Composable
fun BottomTabBar(
    navController: NavHostController
) {
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.destination?.route

    val screens = listOf(
        BottomTabBarItemModel(name = stringResource(id = R.string.secrets),
                                icon = Icons.Default.Home,
                                isSelected = false,
                                route = "add_secret"),
        BottomTabBarItemModel(name = stringResource(id = R.string.devices), icon = Icons.Default.Phone, isSelected = false, route = "add_device"),
        BottomTabBarItemModel(name = stringResource(id = R.string.profile), icon = Icons.Default.Person, isSelected = false, route = "profile"),
    )

    BottomNavigation(
        modifier = Modifier
            .fillMaxWidth()
            .height(68.dp),
        backgroundColor = AppColors.blackMenu,
        contentColor = AppColors.whiteMain
    ) {
        screens.forEach { screen ->
            BottomNavigationItem(
                icon = {
                    Icon(
                        imageVector = screen.icon,
                        contentDescription = null
                    )
                },
                label = { Text(text = screen.name) },
                selected = currentRoute == screen.route,
                onClick = {
                    navController.navigate(screen.route) {
                        // Pop up to the start destination of the graph to
                        // avoid building up a large stack of destinations
                        popUpTo(navController.graph.findStartDestination().id) {
                            saveState = true
                        }
                        launchSingleTop = true
                        restoreState = true
                    }
                }
            )
        }
    }
}