package com.example.metasecret

import com.example.metasecret.database.DriverFactory
import com.jetbrains.handson.kmm.shared.cache.AuthState
import com.jetbrains.handson.kmm.shared.cache.Database

class DevicesManagerApi(factory: DriverFactory) {
    private val db = Database(databaseDriverFactory = factory)
//    internal fun getAllDevices(): List<RocketLaunch> {
//        return db.selectAllDevices(::mapDevicesSelecting).executeAsList()
//    }

//    private fun mapDevicesSelecting(
//        flightNumber: Long,
//        missionName: String,
//        details: String?,
//        launchSuccess: Boolean?,
//        launchDateUTC: String,
//        patchUrlSmall: String?,
//        patchUrlLarge: String?,
//        articleUrl: String?
//    ): RocketLaunch {
//        return RocketLaunch(
//            flightNumber = flightNumber.toInt(),
//            missionName = missionName,
//            details = details,
//            launchDateUTC = launchDateUTC,
//            launchSuccess = launchSuccess,
//            links = Links(
//                patch = Patch(
//                    small = patchUrlSmall,
//                    large = patchUrlLarge
//                ),
//                article = articleUrl
//            )
//        )
//    }
}