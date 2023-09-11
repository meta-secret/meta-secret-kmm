package data

import android.media.Image
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.example.metasecret.android.R
import java.util.UUID

@Immutable
data class DeviceModel(
    val name: String,
    val deviceType: DeviceType,
    val deviceId: String,
    val secretsCount: String
) : CommonItemModel {
    override val type: ItemType = ItemType.Device
    override val id: UUID = UUID.randomUUID()
}

enum class DeviceType {
    Phone,
    iPhone,
    Pad,
    NoteBook
}

@Composable
fun getDeviceTypeImage(deviceType: DeviceType): Int {
    return when (deviceType) {
        DeviceType.Phone -> R.drawable.phone_ico
        DeviceType.iPhone -> R.drawable.iphone_ico
        DeviceType.Pad -> R.drawable.tab_ico
        DeviceType.NoteBook -> R.drawable.note_ico
    }
}