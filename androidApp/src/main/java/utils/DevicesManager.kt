package utils

import android.content.Context
import com.example.metasecret.AuthManagerApi
import com.example.metasecret.database.DriverFactory
import com.jetbrains.handson.kmm.shared.cache.AuthState
import data.DeviceModel
import data.DeviceType
import kotlinx.coroutines.delay
import javax.inject.Inject

class DevicesManager @Inject constructor() {
    fun getDeviceDataSource(counter: Int): List<DeviceModel> {
        if (counter == 1) {
            return listOf(
                DeviceModel(name = "Android(R2D2)", deviceType = DeviceType.Phone, deviceId = "313701fc-c222-488d-b9c9-432237413155", secretsCount = "No secrets")
            )
        } else if (counter == 2) {
            return listOf(
                DeviceModel(name = "Android(R2D2)", deviceType = DeviceType.Phone, deviceId = "313701fc-c222-488d-b9c9-432237413155", secretsCount = "No secrets") ,
                DeviceModel(name = "iPhone(R2D2)", deviceType = DeviceType.Phone, deviceId = "01B6C691-EE6E-48F2-B2DE-AFC1DA180EFE", secretsCount = "No secrets")
            )
        } else {
            return listOf(
                DeviceModel(name = "iPhoneSE", deviceType = DeviceType.Phone, deviceId = "01B6C691-EE6E-48F2-B2DE-AFC1DA180EFE", secretsCount = "No secrets"),
                DeviceModel(name = "iPhone 13 Pro", deviceType = DeviceType.Phone, deviceId = "87AF5680-067C-4B69-8DD6-33F1F4ECC584", secretsCount = "No secrets"),
                DeviceModel(name = "Galaxy A04", deviceType = DeviceType.Phone, deviceId = "313701fc-c222-488d-b9c9-432237413155", secretsCount = "No secrets")
            )
        }
    }

}