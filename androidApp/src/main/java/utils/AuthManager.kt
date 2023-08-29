package utils

import com.example.metasecret.AuthManagerApi
import com.example.metasecret.Greeting
import javax.inject.Inject

class AuthManager @Inject constructor() {
    fun checkValetAvailability(name: String): Boolean {
        return true
    }

    fun checkAuth(): Boolean {
        return AuthManagerApi().getAuthStatus()
    }

    fun register(name: String) {

    }
}