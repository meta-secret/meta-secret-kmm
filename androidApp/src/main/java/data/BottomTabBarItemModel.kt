package data

import androidx.compose.ui.graphics.vector.ImageVector

data class BottomTabBarItemModel(
    val name: String,
    val route: String,
    val icon: ImageVector,
    val badgeCount: Int = 0
) {
}