package scenes.home

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import data.DeviceModel
import utils.DevicesManager
import javax.inject.Inject


@HiltViewModel
class DevicesScreenViewModel @Inject constructor(
    private val deviceManager: DevicesManager
) : ViewModel() {
    fun getDevices(counter: Int): List<DeviceModel> {
        return  deviceManager.getDeviceDataSource(counter = counter)
    }
}