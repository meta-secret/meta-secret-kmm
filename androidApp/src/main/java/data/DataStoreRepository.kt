package data

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.emptyPreferences
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.map
import java.io.IOException

val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "on_boarding_pref")

class DataStoreRepository(context: Context) {

    private val dataStore = context.dataStore

    suspend fun saveBoolValue(keyType: StoredKey, value: Boolean) {
        dataStore.edit { preferences ->
            val storedKey = booleanPreferencesKey(name = keyType.key)
            preferences[storedKey] = value
        }
    }

    fun readBoolValue(keyType: StoredKey): Flow<Boolean> {
        return dataStore.data
            .catch { exception ->
                if (exception is IOException) {
                    emit(emptyPreferences())
                } else {
                    throw exception
                }
            }
            .map { preferences ->
                val readKey = booleanPreferencesKey(name = keyType.key)
                val valueByKey = preferences[readKey] ?: false
                valueByKey
            }
    }
}

enum class StoredKey(val key: String) {
    ON_BOARDING_COMPLETE_KEY("on_boarding_completed")
}