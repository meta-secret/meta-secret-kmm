package com.example.metasecret

interface StoreLink {
    val urlString: String
}

expect fun getStoreUrl(): StoreLink