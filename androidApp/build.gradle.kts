plugins {
    id("com.android.application")
    kotlin("android")
}

android {
    namespace = "com.example.metasecret.android"
    compileSdk = 33
    defaultConfig {
        applicationId = "com.example.metasecret.android"
        minSdk = 28
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }
    buildFeatures {
        compose = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.4.0"
    }
    packagingOptions {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
}

dependencies {
    implementation(project(":shared"))
    implementation("androidx.compose.ui:ui:1.4.2")
    implementation("androidx.compose.ui:ui-tooling:1.4.2")
    implementation("androidx.compose.ui:ui-tooling-preview:1.4.2")
    implementation("androidx.compose.foundation:foundation:1.4.2")
    implementation("androidx.compose.material:material:1.4.2")
    implementation("androidx.activity:activity-compose:1.7.1")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.8.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("com.google.zxing:core:3.4.0")
    //ML Kit Barcode Scanning
    implementation("com.google.mlkit:barcode-scanning:16.0.3")

    //CameraX Dependencies
    implementation("androidx.camera:camera-core:1.0.0-beta10")
    implementation("androidx.camera:camera-camera2:1.0.0-beta10")
    implementation("androidx.camera:camera-lifecycle:1.0.0-beta10")
    implementation("androidx.camera:camera-view:1.0.0-alpha10")
    implementation("androidx.camera:camera-extensions:1.0.0-alpha10")
    implementation("com.google.android.material:material:1.3.0-alpha02")

    //Library to get URL Meta Data
    implementation("org.jsoup:jsoup:1.13.1")
}