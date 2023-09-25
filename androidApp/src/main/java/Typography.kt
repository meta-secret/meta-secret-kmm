// Typography.kt
import androidx.compose.material.Typography
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.unit.sp
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.font.FontStyle
import com.example.metasecret.android.R

val CustomTypography = Typography(
    defaultFontFamily = FontFamily(
        Font(R.font.manrope_regular)
    ),
    body1 = TextStyle(
        fontFamily = FontFamily(
            Font(R.font.manrope_regular, FontWeight.Normal)
        ),
        fontSize = 16.sp,
        letterSpacing = 1.15.sp
    ),
    body2 = TextStyle(
        fontFamily = FontFamily(
            Font(R.font.manrope_regular, FontWeight.Normal)
        ),
        fontSize = 15.sp,
        letterSpacing = 1.15.sp
    ),
    caption = TextStyle(
        fontFamily = FontFamily(
            Font(R.font.manrope_regular, FontWeight.Normal)
        ),
        fontSize = 13.sp,
        letterSpacing = 1.15.sp
    ),
    h1 = TextStyle(
        fontFamily = FontFamily(
            Font(R.font.manrope_bold, FontWeight.Bold)
        ),
        fontSize = 28.sp,
        letterSpacing = 1.15.sp
    ),
    h2 = TextStyle(
        fontFamily = FontFamily(
            Font(R.font.manrope_bold, FontWeight.Bold)
        ),
        fontSize = 24.sp,
        letterSpacing = 1.15.sp
    ),
    h4 = TextStyle(
        fontFamily = FontFamily(
            Font(R.font.manrope_bold, FontWeight.Bold)
        ),
        fontSize = 20.sp,
        letterSpacing = 1.15.sp
    ),
    button = TextStyle(
        fontFamily = FontFamily(
            Font(R.font.manrope_semibold, FontWeight.SemiBold)
        ),
        fontSize = 16.sp,
        letterSpacing = 1.15.sp
    )
)
