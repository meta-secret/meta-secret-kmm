package scenes.registration

import android.content.Context
import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import utils.AuthManager
import javax.inject.Inject

@HiltViewModel
class SignInScreenViewModel @Inject constructor(
    private val authManager: AuthManager
) : ViewModel() {
    fun checkAndSaveName(name: String, context: Context): Boolean {
        return if (authManager.checkValetAvailability(name = name)) {
            authManager.register(name = name, context = context)
            true
        } else {
            false
        }
    }
}