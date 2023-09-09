package data

import androidx.compose.ui.graphics.vector.ImageVector

data class BottomTabBarItemModel(
    val name: String,
    val icon: ImageVector,
    val isSelected: Boolean,
    val route: String
) {
}