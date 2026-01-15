import java.util.Properties
import java.io.FileInputStream
import java.text.SimpleDateFormat
import java.util.Date

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.lbstudio12.onestopjournaling"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.lbstudio12.onestopjournaling"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }

    // Task to rename output APK/AAB with timestamp after build
    applicationVariants.all {
        val sdf = SimpleDateFormat("ddMMyyyy_HHmmss")
        val currentDateAndTime = sdf.format(Date())
        val appName = applicationId
        val versionName = defaultConfig.versionName
        val versionCode = defaultConfig.versionCode

        this.outputs
            .map { it as com.android.build.gradle.internal.api.ApkVariantOutputImpl }
            .forEach { output ->
                val variant = this.buildType.name
                val fileExtension = output.outputFileName.substringAfterLast('.', "")
                val apkName =
                    "${appName}-${variant}-${versionName}-${versionCode}-${currentDateAndTime}.${fileExtension}"
                output.outputFileName = apkName
            }

        this.outputs.forEach { output ->
            val variant = this.buildType.name
            val bundleTaskName = "bundle${variant.capitalize()}"
            tasks.named(bundleTaskName).configure {
                doLast {
                    val newFileName = "${appName}-${variant}-${versionName}-${versionCode}-${currentDateAndTime}.aab"

                    val bundleOutputDir = file("build/outputs/bundle/${variant}")
                    val bundleFile = bundleOutputDir.listFiles()?.firstOrNull { it.extension == "aab" }

                    if (bundleFile != null) {
                        val newFile = File(bundleFile.parentFile, newFileName)
                        bundleFile.copyTo(newFile)
                        println("Renamed bundle output to '${newFile.name}'")
                    } else {
                        println("AAB file not found for variant '${variant}'")
                    }
                }
            }
        }
    }
}

flutter {
    source = "../.."
}
