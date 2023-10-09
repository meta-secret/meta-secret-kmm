plugins {
    id("com.android.application").version("8.1.1").apply(false)
    id("com.android.library").version("8.1.1").apply(false)
    kotlin("android").version("1.9.10").apply(false)
    kotlin("multiplatform").version("1.9.10").apply(false)
    id("com.google.dagger.hilt.android") version "2.48.1" apply false
}

buildscript {
    dependencies {
        classpath("com.squareup.sqldelight:gradle-plugin:1.5.5")
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
