package data

import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.ui.res.stringResource
import com.example.metasecret.android.R
import java.util.UUID

@Immutable
data class SecretModel(
    val description: String = "",
    val strenghtType: ProtectionType,
    val secret: String
) : CommonItemModel {
    override val type: ItemType = ItemType.Device
    override val id: UUID = UUID.randomUUID()
}

enum class ProtectionType {
    Weak,
    Strong,
    Max
}

@Composable
fun getProtectionTypeImage(protectionType: ProtectionType): Int {
    return when (protectionType) {
        ProtectionType.Weak -> R.drawable.weak_ico
        ProtectionType.Strong -> R.drawable.strong_ico
        ProtectionType.Max -> R.drawable.max_ico
    }
}

@Composable
fun getProtectionTypeText(protectionType: ProtectionType): String {
    return when (protectionType) {
        ProtectionType.Weak -> stringResource(id = R.string.weak)
        ProtectionType.Strong -> stringResource(id = R.string.strong)
        ProtectionType.Max -> stringResource(id = R.string.maximum)
    }
}

@Composable
fun getDevicesCountText(protectionType: ProtectionType): String {
    return when (protectionType) {
        ProtectionType.Weak -> stringResource(id = R.string.countDevices)
        ProtectionType.Strong -> stringResource(id = R.string.countDevices)
        ProtectionType.Max -> stringResource(id = R.string.countDevices)
    }
}
