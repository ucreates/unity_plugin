# Unity Plugin
the project is iOS / Android plugin for [Unity](https://unity3d.com).

## Description
the project is develoed by Unity(5.4.3f1),Xcode(8.1),Android Studio(2.2.2),Fabric(iOS:2.6.1/Android:2.2.0)

iOS plugin supported iOS10.0 Later.

Android plugin supported Android 4.0(ICE_CREAM_SANDWICH/API Level 14) Later.

## Usage
***Notes on use for Unity***

you may confirm some sample behaviours. which exists in following folder.

- some sample behaviours exists in:https://github.com/ucreates/unity_plugin/blob/master/Assets/Scripts/

***Notes on use for iOS***

1.download and install Xcodeproj gem on your development machine.

- Xcodeproj:https://github.com/CocoaPods/Xcodeproj

2.please rewrite the relevant sections of the following file to the product name. 

- file:https://github.com/ucreates/unity_plugin/blob/master/Assets/Plugins/iOS/UnityiOSPlugin.mm

- replacement:https://gist.github.com/ucreates/dccc0d1ec16b54423eca786180fac9ea

3.please rewrite the replacement section of the following file to the fabric api key. you can confirm fabric api key by fabric official web site.

- fabric:https://fabric.io/settings/account

- replacement:https://github.com/ucreates/unity_plugin/blob/master/Assets/Plugins/UnityPlugin/Core/Sns/TwitterSetting.cs

4.iOS build with Unity.

5.published project build with Xcode.

***Notes on use for Android***

1.please enable Internet connection in the Unity.

- UnityEditor Player Setting → Android → Other Settings → Internet Access

2.please rewrite the replacement section of the following file to the fabric api key. you can confirm fabric api key by fabric official web site.

- fabric:https://fabric.io/settings/account

- replacement:https://github.com/ucreates/unity_plugin/blob/master/Assets/Plugins/UnityPlugin/Core/Sns/TwitterSetting.cs

- replacement:https://github.com/ucreates/unity_plugin/blob/master/Assets/Plugins/Android/AndroidManifest.xml

3.Android build with Unity.
