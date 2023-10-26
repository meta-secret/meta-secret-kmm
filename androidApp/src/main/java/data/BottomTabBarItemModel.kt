package data

import androidx.compose.ui.graphics.painter.Painter

data class BottomTabBarItemModel(
    val name: String,
    val icon: Painter,
    val isSelected: Boolean,
    val route: String
) {
}