plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.capstone_project"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.capstone_project"
        minSdk = 26
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        externalNativeBuild {
            cmake {
                cppFlags.addAll(listOf("-std=c++17", "-frtti", "-fexceptions"))
                arguments.addAll(listOf("-DANDROID_STL=c++_static"))
            }
        }

    }


    buildTypes {
        getByName("release") {
            isMinifyEnabled = false // <-- Important fix here
            isShrinkResources = false // <-- This avoids your crash
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation(platform("com.google.firebase:firebase-bom:33.10.0"))
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
}
