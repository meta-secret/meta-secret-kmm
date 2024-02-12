package scenes.registration

import android.content.Context
import androidx.lifecycle.ViewModel
import com.example.metasecret.android.RustWrapper
import dagger.hilt.android.lifecycle.HiltViewModel
import utils.AuthManager
import javax.inject.Inject

@HiltViewModel
class SignInScreenViewModel @Inject constructor(
    private val authManager: AuthManager
) : ViewModel() {
    fun checkAndSaveName(name: String, context: Context): Boolean {
        check()

        return if (authManager.checkValetAvailability(name = name)) {
            authManager.register(name = name, context = context)
            true
        } else {
            false
        }
    }

    fun check() {
        val rustWrapper = RustWrapper()
        val result = rustWrapper.greet("Hello MotherFucker")
        println("End")
    }
}