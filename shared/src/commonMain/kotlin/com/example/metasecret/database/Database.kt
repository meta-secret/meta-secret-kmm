package com.jetbrains.handson.kmm.shared.cache

import com.example.metasecret.database.AppDatabase
import com.example.metasecret.database.DriverFactory

internal class Database(databaseDriverFactory: DriverFactory) {
    private val database = AppDatabase(databaseDriverFactory.createDriver())
    private val dbAuthQuery = database.authInformationQueries
    private val dbOnboardingQuery = database.onboardingInformationQueries

    //Registration
    internal fun clearDatabase() {
        dbAuthQuery.transaction {
            dbAuthQuery.removeAuthInfo()
        }
    }

    internal fun getAuthState(): AuthState {
        val authState = dbAuthQuery.selectAuthInfo().executeAsOneOrNull()

        if (authState?.vaultName == null) {
            return AuthState.NOT_REGISTERED
        }

        return AuthState.ALREADY_REGISTERED
    }

    internal fun setAuthInfo(name: String) {
        dbAuthQuery.insertAuthInfo(name)
    }

    // Onboarding
    internal fun clearOnboardingDatabase() {
        dbOnboardingQuery.transaction {
            dbOnboardingQuery.removeOnboardingInfo()
        }
    }

    internal fun getOnboardingState(): Boolean {
        val state = dbOnboardingQuery.selectOnboardingInfo().executeAsOneOrNull()

        if (state == null || state.equals(0L)) {
            return false
        }
        return true
    }

    internal fun setOnboardingInfo(isCompleted: Boolean) {
        if (isCompleted) {
            dbOnboardingQuery.insertOnboardingInfo(1L)
        } else {
            dbOnboardingQuery.insertOnboardingInfo(0L)
        }

    }
}

enum class AuthState {
    NOT_REGISTERED,
    ALREADY_REGISTERED
}