package com.example.metasecret

import com.example.metasecret.database.AuthInformation
import com.example.metasecret.database.DriverFactory
import com.jetbrains.handson.kmm.shared.cache.Database

class AuthManagerApi(factory: DriverFactory) {
    private val db = Database(databaseDriverFactory = factory)
    fun getAuthStatus(): Boolean {
        return db.getAuthState()
    }

    fun setAuthStatus(isAuthorized: Boolean) {
        db.setAuthInfo(isAuthorized = isAuthorized)
    }
}