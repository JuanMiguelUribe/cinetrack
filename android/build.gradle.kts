import com.android.build.gradle.BaseExtension
import org.gradle.api.Project

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.5.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.10")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Cambiar la carpeta build global
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    afterEvaluate {
        val androidExt = extensions.findByName("android")
        if (androidExt is BaseExtension) {
            androidExt.compileSdkVersion(35)
            androidExt.buildToolsVersion("35.0.0")

            androidExt.defaultConfig {
                targetSdkVersion(35)
            }
        }
        layout.buildDirectory.set(rootProject.layout.buildDirectory.dir(name))
    }
}

subprojects {
    evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
