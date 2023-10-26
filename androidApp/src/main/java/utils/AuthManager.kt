package utils

import android.content.Context
import com.example.metasecret.AuthManagerApi
import com.example.metasecret.Greeting
import com.example.metasecret.database.DriverFactory
import com.jetbrains.handson.kmm.shared.cache.AuthState
import javax.inject.Inject

class AuthManager @Inject constructor() {
    fun checkValetAvailability(name: String): Boolean {
        //TODO: Read from DB
        return true
    }

    fun checkAuth(context: Context): AuthState {
        return AuthManagerApi(factory = DriverFactory(context)).getAuthStatus()
    }

    fun register(name: String, context: Context) {
        AuthManagerApi(factory = DriverFactory(context)).setAuthStatus(name = name)
    }

    fun checkOnboardingState(context: Context): Boolean {
        return AuthManagerApi(factory = DriverFactory(context)).getOnboardingStatus()
    }

    fun setOnboardingState(isCompleted: Boolean, context: Context) {
        return AuthManagerApi(factory = DriverFactory(context)).setOnboardingCompletion(isCompleted)
    }
}