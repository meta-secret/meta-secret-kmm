package com.example.metasecret.android

class RustWrapper {

    @Throws(IllegalArgumentException::class)
    external fun greet(string: String): String
}