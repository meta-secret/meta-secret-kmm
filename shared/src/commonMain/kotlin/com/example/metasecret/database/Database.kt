package com.jetbrains.handson.kmm.shared.cache

import com.example.metasecret.database.AppDatabase
import com.example.metasecret.database.DriverFactory

internal class Database(databaseDriverFactory: DriverFactory) {
    private val database = AppDatabase(databaseDriverFactory.createDriver())
    private val dbAuthQuery = database.authInformationQueries

    internal fun clearDatabase() {
        dbAuthQuery.transaction {
            dbAuthQuery.removeAuthInfo()
        }
    }

    internal fun getAuthState(): Boolean {
        val authState = dbAuthQuery.selectAuthInfo().executeAsOneOrNull()

        if (authState == null || authState.isAuthorized == 0L) {
            println("FALSE")
            return false
        }
        println("TRUE")
        return true
    }

    internal fun setAuthInfo(isAuthorized: Boolean) {
        val authInfo = if (isAuthorized) 1L else 0L
        dbAuthQuery.insertAuthInfo(authInfo)
    }
}