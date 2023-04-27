package com.example.metasecret.android

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Color
import android.os.Bundle
import android.widget.Button
import android.widget.ImageView
import androidx.activity.ComponentActivity
import com.example.metasecret.AppLinker
import com.example.metasecret.StoreLink
import com.google.zxing.BarcodeFormat
import com.google.zxing.EncodeHintType
import com.google.zxing.qrcode.QRCodeWriter

class WelcomeQRViewActivity: ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.onboarding_qr)

        val bitmap = qrGeneration()
        val qrImageView = findViewById<ImageView>(R.id.qrIc)
        qrImageView.setImageBitmap(bitmap)

        val nextAction = findViewById<Button>(R.id.nextQr)
        nextAction.setOnClickListener {
            startActivity(
                Intent(this, WelcomeAddPasswordActivity::class.java)
            )
        }
    }

    private fun qrGeneration(): Bitmap {
        val size = 300
        val qrCodeContent = AppLinker().getStoreLink()
        val bits = QRCodeWriter().encode(qrCodeContent, BarcodeFormat.QR_CODE, size, size)
        return Bitmap.createBitmap(size, size, Bitmap.Config.RGB_565).also {
            for (x in 0 until size) {
                for (y in 0 until size) {
                    it.setPixel(x, y, if (bits[x, y]) getColor(R.color.main_black) else getColor(R.color.main_creame))
                }
            }
        }
    }
}