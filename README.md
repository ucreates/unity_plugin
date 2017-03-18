# Unity Plugin
the project is iOS / Android plugin for [Unity](https://unity3d.com).

## Description
the project is develoed by Unity(5.4.3f1),Xcode(8.1),Android Studio(2.2.2),

Fabric(iOS:2.8.0/Android:2.3.1),Facebook(iOS:4.19/Android:4.19),LINE(iOS:3.2.2/Android:3.1.21)

iOS plugin supported iOS10.0 Later.

Android plugin supported Android 4.3(JELLY_BEAN_MR2/API Level 18) Later.

## Usage
***Notes on use for Unity***

you may confirm some sample behaviours. which exists in following folder.

- some sample behaviours exists in:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Scripts/

***Notes on use for iOS***

1.download and install Xcodeproj gem on your development machine.

- Xcodeproj:https://github.com/CocoaPods/Xcodeproj

2.please rewrite the relevant sections of the following file to the product name. 

- file:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/iOS/UnityiOSPlugin.mm

- replacement:https://gist.github.com/ucreates/dccc0d1ec16b54423eca786180fac9ea

3.please add some domain of the following file to the allowed http access domain list in UIWebView.

- add to:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Unity/Core/Configure/WebViewConfigurePlugin.cs

4.please rewrite the replacement section of the following file to the fabric api key. you can confirm fabric api key by fabric official web site.

- fabric:https://fabric.io/settings/account

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Unity/Core/Configure/Sns/TwitterConfigurePlugin.cs

5.please rewrite the replacement section of the following file to the facebook app id. you can confirm facebook app id by facebook official developer web site.

- facebook:https://developers.facebook.com/apps/

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Unity/Core/Configure/Sns/FacebookConfigurePlugin.cs

6.please rewrite the replacement section of the following file to the LINE channel id. you can create and confirm LINE channel id by LINE official developer web site.

- LINE(Login):https://developers.line.me/line-login/overview

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Unity/Core/Configure/Sns/LineConfigurePlugin.cs

7.please configure player and build setting for UnityNativePlugin in the Unity project and published Xcode project.

- Unity

 - Player Setting→iOS→Other Settings→Architecture:Universal

- Xcode

 - Architectures→Build Architecture Only:Debug/Release→Yes

 - Architectures→Supported Platform:iphoneos→iOS

8.iOS build with Unity.

9.published project build with Xcode.

***Notes on use for Android***

1.please enable Internet connection in the Unity.

- UnityEditor Player Setting → Android → Other Settings → Internet Access

2.please rewrite the replacement section of the following file to the fabric api key. you can confirm fabric api key by fabric official web site.

- fabric:https://fabric.io/settings/account

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Unity/Core/Configure/Sns/TwitterConfigurePlugin.cs

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Android/AndroidManifest.xml

3.please rewrite the replacement section of the following file to the facebook app id. you can confirm facebook app id by facebook official developer web site.

- facebook:https://developers.facebook.com/apps/

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Unity/Core/Configure/Sns/FacebookConfigurePlugin.cs

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Android/AndroidManifest.xml

4.please rewrite the replacement section of the following file to the LINE channel id. you can create and confirm LINE channel id by LINE official developer web site.

- LINE(Login):https://developers.line.me/line-login/overview

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Unity/Core/Configure/Sns/LineConfigurePlugin.cs

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Android/AndroidManifest.xml

5.please rewrite the replacement section of the following file to the Your Android App License Key. you can create and confirm License Key by Google Play Developer Console web site.

- Google Play Developer Console:https://play.google.com/apps/publish/

- replacement:https://github.com/ucreates/unity_plugin/blob/master/UnityPlugin/Assets/Plugins/Unity/Core/Configure/PaymentConfigurePlugin.cs

6.Android build with Unity.
