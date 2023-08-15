package scenes.common

import androidx.compose.material.BottomNavigation
import androidx.compose.material.BottomNavigationItem
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.navigation.NavController
import androidx.navigation.compose.currentBackStackEntryAsState
import data.BottomTabBarItemModel

@Composable
fun BottomTabBar(
    items: List<BottomTabBarItemModel>,
    navController: NavController,
    modifier: Modifier,
    onItemClick: (BottomTabBarItemModel) -> Unit
) {
    val backStackEntry = navController.currentBackStackEntryAsState()
    BottomNavigation(
        modifier = modifier,
        backgroundColor = Color.DarkGray
    ) {
        items.forEach {item ->
            val selected = item.route == backStackEntry.value?.destination?.route

            BottomNavigationItem(
                selected = selected,
                onClick = { onItemClick(item) },
                selectedContentColor = Color.White,
                unselectedContentColor = Color.White.copy(alpha = 0.7f),
                icon = {
                    BottomTabBarItem(item = item)
                }
            )
        }
    }
}