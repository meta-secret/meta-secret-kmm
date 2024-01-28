package scenes.registration

import android.content.Context
import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import utils.AuthManager
import utils.rustLib.RustLibraryWrapper
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
        val myLibraryWrapper = RustLibraryWrapper()
        val vaultName = "Dima123"
        val vaultNameBytes: ByteArray = vaultName.toByteArray(Charsets.UTF_8)
        val jsonLen: Int = vaultNameBytes.size
//        val string = myLibraryWrapper.stringFromJNI()
        val userObj: String? = myLibraryWrapper.generateSignedUser(vaultNameBytes, jsonLen)
        println("Результат: $userObj")
    }
}