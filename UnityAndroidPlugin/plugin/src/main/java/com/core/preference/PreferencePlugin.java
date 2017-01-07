//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.core.preference;
import android.content.Context;
import android.content.SharedPreferences;
import com.frontend.activity.ActivityPlugin;
public class PreferencePlugin {
    private static final String PREFERENCE_NAME = "PREFERENCE";
    public static boolean getSwitchPreference(String keyName) {
        Context context = ActivityPlugin.getInstance();
        SharedPreferences preferences = context.getSharedPreferences(PreferencePlugin.PREFERENCE_NAME, Context.MODE_PRIVATE);
        return preferences.getBoolean(keyName, false);
    }
    public static void setSwitchPreference(String keyName, boolean value) {
        Context context = ActivityPlugin.getInstance();
        SharedPreferences preferences = context.getSharedPreferences(PreferencePlugin.PREFERENCE_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = preferences.edit();
        editor.putBoolean(keyName, value);
        editor.apply();
        return;
    }
}
