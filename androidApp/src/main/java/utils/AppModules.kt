package utils

import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent

@Module
@InstallIn(SingletonComponent::class)
class AppModules {
    @Provides
    fun providesAuthManager(): AuthManager
            = AuthManager()
}