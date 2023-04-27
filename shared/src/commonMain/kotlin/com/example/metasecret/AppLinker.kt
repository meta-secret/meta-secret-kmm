package com.example.metasecret

class AppLinker {
    private val storeLink: StoreLink = getStoreUrl()

    fun getStoreLink(): String {
        return storeLink.urlString
    }
}