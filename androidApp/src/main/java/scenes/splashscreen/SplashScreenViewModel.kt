package scenes.splashscreen

import android.content.Context
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.metasecret.android.screen.Screen
import dagger.hilt.android.lifecycle.HiltViewModel
import data.DataStoreRepository
import data.StoredKey
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import utils.AuthManager
import java.security.KeyStore
import javax.inject.Inject

@HiltViewModel
class SplashScreenViewModel @Inject constructor(
    private val repository: DataStoreRepository,
    private val authManager: AuthManager
) : ViewModel() {
    fun readOnboardingKey(): Flow<Boolean> {
        return repository.readBoolValue(keyType = StoredKey.ON_BOARDING_COMPLETE_KEY)
    }

    fun checkAuth(context: Context): Boolean {
        return authManager.checkAuth(context = context)
    }
}