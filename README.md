# image_editor_pro

To fix image editing app crash


1.

Fix: Set the required NDK version
Add this line to your android/app/build.gradle or build.gradle.kts inside the android {} block:


ndkVersion = "27.0.12077973"


2.


Edit AndroidManifest.xml (for Android permissions)
Location:
android/app/src/main/AndroidManifest.xml

Steps:

- In your project folder, go to: android > app > src > main

- Open AndroidManifest.xml

- Add the following above the <application> tag:

<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="28"/>


3.


Inside the <application> tag, add this:

<provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/provider_paths"/>
</provider>


4.


Create provider_paths.xml (required by ImageCropper)
Location:
android/app/src/main/res/xml/provider_paths.xml

Steps:

- Navigate to: android/app/src/main/res

- If xml folder doesn't exist, create a new folder and name it xml

- Inside that xml folder, create a file called: provider_paths.xml

- Paste this code inside:

<?xml version="1.0" encoding="utf-8"?>
<paths xmlns:android="http://schemas.android.com/apk/res/android">
    <external-path name="external_files" path="." />
</paths>


5.


Manually declare the UCropActivity in AndroidManifest.xml
Add this inside the <application> tag in:


android/app/src/main/AndroidManifest.xml


<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>



6.(optional)

Open Settings:

Press Win + I to open the Settings app.

Go to "Update & Security":

In the Settings window, scroll down and select Update & Security.

Navigate to "For Developers":

In the left sidebar, click on For Developers.

Enable Developer Mode:

In the For Developers section, you’ll see an option for Developer Mode. Toggle the switch to enable it.

Restart Your PC:

After enabling Developer Mode, restart your computer to apply the changes. 





A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
#   I m a g e _ e d i t i n g _ p r o 
 
 
