package com.example.metasecret.Managers

import com.example.metasecret.QRGenerator

class QRManager {
    fun getLink() {
        QRGenerator().getQRLink()
    }
}