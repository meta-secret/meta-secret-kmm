package utils

import android.content.Context
import com.example.metasecret.AuthManagerApi
import com.example.metasecret.Greeting
import com.example.metasecret.database.DriverFactory
import javax.inject.Inject

class AuthManager @Inject constructor() {
    fun checkValetAvailability(name: String): Boolean {
        return true
    }

    fun checkAuth(context: Context): Boolean {
        return AuthManagerApi(factory = DriverFactory(context)).getAuthStatus()
    }

    fun register(name: String, context: Context) {
        AuthManagerApi(factory = DriverFactory(context)).setAuthStatus(isAuthorized = true)
    }
}