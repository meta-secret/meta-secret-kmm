package com.example.metasecret

import com.example.metasecret.database.DriverFactory
import com.jetbrains.handson.kmm.shared.cache.AuthState
import com.jetbrains.handson.kmm.shared.cache.Database

class AuthManagerApi(factory: DriverFactory) {
    // Registration
    private val db = Database(databaseDriverFactory = factory)
    fun getAuthStatus(): AuthState {
        return db.getAuthState()
    }

    fun setAuthStatus(name: String) {
        db.setAuthInfo(name = name)
    }

    // Onboarding
    fun getOnboardingStatus(): Boolean {
        return db.getOnboardingState()
    }

    fun setOnboardingCompletion(isCompleted: Boolean) {
        db.setOnboardingInfo(isCompleted)
    }
}