package scenes.onboarding

import android.content.Context
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import data.DataStoreRepository
import data.StoredKey
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import utils.AuthManager
import javax.inject.Inject

@HiltViewModel
class OnboardingViewModel @Inject constructor(
    private val repository: DataStoreRepository,
    private val authManager: AuthManager
    ) : ViewModel()
{
    fun saveOnBoardingState(completed: Boolean, context: Context) {
        authManager.setOnboardingState(isCompleted = completed, context)
    }
}
