package scenes.onboarding

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import data.DataStoreRepository
import data.StoredKey
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import javax.inject.Inject

    @HiltViewModel
    class OnboardingViewModel @Inject constructor(
        private val repository: DataStoreRepository
    ) : ViewModel() {

        fun saveOnBoardingState(completed: Boolean) {
            viewModelScope.launch(Dispatchers.IO) {
                repository.saveBoolValue(
                    keyType = StoredKey.ON_BOARDING_COMPLETE_KEY,
                    value = completed
                )
            }
        }

    }
