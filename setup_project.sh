#!/bin/bash

# Set nama project dan package
PROJECT_NAME="WebViewApp"
PACKAGE_NAME="com.example.webviewapp"
PACKAGE_PATH="com/example/webviewapp"

# Buat folder dasar
mkdir -p $PROJECT_NAME/app/src/main/java/$PACKAGE_PATH
mkdir -p $PROJECT_NAME/app/src/main/res/layout
mkdir -p $PROJECT_NAME/app/src/main/res/values

# ==== AndroidManifest.xml ====
cat > $PROJECT_NAME/app/src/main/AndroidManifest.xml <<EOF
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$PACKAGE_NAME">

    <uses-permission android:name="android.permission.INTERNET"/>

    <application
        android:usesCleartextTraffic="true"
        android:label="WebViewApp"
        android:theme="@style/Theme.WebViewApp">
        <activity android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

# ==== MainActivity.kt ====
cat > $PROJECT_NAME/app/src/main/java/$PACKAGE_PATH/MainActivity.kt <<EOF
package $PACKAGE_NAME

import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private lateinit var webView: WebView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        webView = findViewById(R.id.webview)
        webView.webViewClient = WebViewClient()
        webView.settings.javaScriptEnabled = true
        webView.loadUrl("https://www.example.com")
    }

    override fun onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }
}
EOF

# ==== activity_main.xml ====
cat > $PROJECT_NAME/app/src/main/res/layout/activity_main.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <WebView
        android:id="@+id/webview"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>
</RelativeLayout>
EOF

# ==== strings.xml ====
cat > $PROJECT_NAME/app/src/main/res/values/strings.xml <<EOF
<resources>
    <string name="app_name">WebViewApp</string>
</resources>
EOF

# ==== themes.xml ====
mkdir -p $PROJECT_NAME/app/src/main/res/values/themes
cat > $PROJECT_NAME/app/src/main/res/values/themes/themes.xml <<EOF
<resources xmlns:tools="http://schemas.android.com/tools">
    <style name="Theme.WebViewApp" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
        <item name="colorPrimary">@android:color/holo_blue_dark</item>
        <item name="colorPrimaryVariant">@android:color/holo_blue_light</item>
        <item name="colorOnPrimary">@android:color/white</item>
        <item name="colorSecondary">@android:color/holo_green_dark</item>
        <item name="android:statusBarColor" tools:targetApi="l">@android:color/black</item>
    </style>
</resources>
EOF

# ==== app/build.gradle ====
cat > $PROJECT_NAME/app/build.gradle <<EOF
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
}

android {
    namespace "$PACKAGE_NAME"
    compileSdk 34

    defaultConfig {
        applicationId "$PACKAGE_NAME"
        minSdk 21
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    buildFeatures {
        viewBinding true
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib:1.9.10"
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.10.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
}
EOF

# ==== Root build.gradle ====
cat > $PROJECT_NAME/build.gradle <<EOF
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.2.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.10"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

# ==== settings.gradle ====
cat > $PROJECT_NAME/settings.gradle <<EOF
include ':app'
rootProject.name = "$PROJECT_NAME"
EOF

# ==== gradle.properties ====
cat > $PROJECT_NAME/gradle.properties <<EOF
org.gradle.jvmargs=-Xmx2048m
android.useAndroidX=true
kotlin.code.style=official
EOF

# Output info
echo "✅ Project $PROJECT_NAME berhasil dibuat!"
echo "➡️ Buka project ini di Android Studio dan klik 'Build APK'."
