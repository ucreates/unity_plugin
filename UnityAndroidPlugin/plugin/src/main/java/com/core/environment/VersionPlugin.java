//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.core.environment;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.frontend.activity.ActivityPlugin;
public class VersionPlugin {
    public static int getVersion() {
        PackageInfo packageInfo = VersionPlugin.getPackage();
        int version = 0;
        if (null != packageInfo) {
            version = Integer.valueOf(packageInfo.versionCode);
        }
        return version;
    }
    public static String getVersionName() {
        PackageInfo packageInfo = VersionPlugin.getPackage();
        String version = "0.0.0";
        if (null != packageInfo) {
            version = packageInfo.versionName;
        }
        return version;
    }
    private static PackageInfo getPackage() {
        Activity activity = ActivityPlugin.getInstance();
        Context context = activity.getApplicationContext();
        String packageName = context.getPackageName();
        PackageManager manager = context.getPackageManager();
        PackageInfo packageInfo = null;
        try {
            packageInfo = manager.getPackageInfo(packageName, 0);
        } catch (PackageManager.NameNotFoundException e) {
            Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.getMessage());
        }
        return packageInfo;
    }
}