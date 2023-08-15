package scenes.common

import androidx.compose.foundation.layout.Column
import androidx.compose.material.BadgedBox
import androidx.compose.material.Icon
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.sp
import data.BottomTabBarItemModel

@Composable
fun BottomTabBarItem(
    item: BottomTabBarItemModel
) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        if (item.badgeCount > 0) {
            Column() {
                Icon(
                    imageVector = item.icon,
                    contentDescription = item.name
                )

                Text(
                    text = item.name,
                    textAlign = TextAlign.Center,
                    fontSize = 10.sp
                )
            }
        }
    }
}