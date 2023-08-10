package scenes.common

import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Email
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.outlined.Lock
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.platform.LocalSoftwareKeyboardController
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp

@Composable
fun TipTextField(modifier: Modifier) {
    var value by remember {
        mutableStateOf("")
    }

    val focusManager = LocalFocusManager.current

    var isNameAlreadyTaken by remember {
        mutableStateOf(false)
    }

    Column(modifier = Modifier
        .clip(shape = RoundedCornerShape(8.dp))
        .clip(RoundedCornerShape(8.dp))
        .background(Color.Transparent, shape = RoundedCornerShape(18.dp))
        .border(BorderStroke(2.dp, SolidColor(Color.Transparent)))) {
        TextField(
            modifier = modifier,
            value = value,
            onValueChange = { newText ->
                value = newText
                isNameAlreadyTaken = false
            },
            singleLine = true,
            shape = RoundedCornerShape(1.dp),
            label = { Text(
                color = Color.White.copy(alpha = 0.5f),
                fontSize = MaterialTheme.typography.caption.fontSize,
                fontWeight = FontWeight.Normal,
                textAlign = TextAlign.Left,
                text = "Выберите уникальный никнейм") },
            placeholder = { Text(
                color = Color.White.copy(alpha = 0.5f),
                fontSize = MaterialTheme.typography.subtitle2.fontSize,
                fontWeight = FontWeight.Normal,
                textAlign = TextAlign.Left,
                text = "") },
            isError = isNameAlreadyTaken,
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Text,
                imeAction = ImeAction.Done
            ),
            keyboardActions = KeyboardActions(
                onDone = {
                    focusManager.clearFocus()
                    isNameAlreadyTaken = validateName(inputText = value)
                }
            ),
            colors = TextFieldDefaults.textFieldColors(
                textColor = Color.White,
                backgroundColor = Color.White.copy(alpha = 0.05f),
                cursorColor = Color.White,
                focusedIndicatorColor = Color.Transparent,
                unfocusedIndicatorColor = Color.Transparent,
                disabledIndicatorColor = Color.Transparent,
                errorIndicatorColor = Color.Transparent
            )
        )

        if (isNameAlreadyTaken) {
            Text(
                modifier = Modifier.padding(start = 16.dp),
                text = "Это имя занято",
                color = MaterialTheme.colors.error
            )
        }
    }
}

private fun validateName(inputText: String): Boolean {
    return inputText == "Dima"
}