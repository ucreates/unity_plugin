//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.activity;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.preference.CheckBoxPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceCategory;
import android.preference.PreferenceScreen;
import android.preference.Preference.OnPreferenceChangeListener;
import android.preference.Preference.OnPreferenceClickListener;
import android.provider.Settings;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.core.preference.PreferencePlugin;
public class PreferenceActivityPlugin extends PreferenceActivity {
    public static final int ACTIVITY_ID = 2;
    private static final int CELL_NUM = 5;
    private static String[] SECTION_TITLE = {"設定カテゴリ1", "設定カテゴリ2"};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        OnPreferenceClickListener buttonListener  = new OnPreferenceClickListener() {
            @Override
            public boolean onPreferenceClick(Preference preference) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "onPreferenceClick");
                Activity activity = ActivityPlugin.getInstance();
                Intent intent = new Intent();
                intent.setAction(Settings.ACTION_APPLICATION_SETTINGS);
                activity.startActivity(intent);
                return true;
            }
        };
        OnPreferenceChangeListener checkBoxListener  = new OnPreferenceChangeListener() {
            @Override
            public boolean onPreferenceChange(Preference preference, Object newValue) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "onPreferenceChange");
                String keyName = preference.getKey();
                boolean switchStatus = Boolean.valueOf(newValue.toString());
                PreferencePlugin.setSwitchPreference(keyName, switchStatus);
                return true;
            }
        };
        PreferenceScreen screen = getPreferenceManager().createPreferenceScreen(this);
        for (int i = 0; i < PreferenceActivityPlugin.SECTION_TITLE.length; i++) {
            String caregoryTitle = PreferenceActivityPlugin.SECTION_TITLE[i];
            PreferenceCategory category = new PreferenceCategory(this);
            category.setTitle(caregoryTitle);
            screen.addPreference(category);
            for (int j = 0; j < PreferenceActivityPlugin.CELL_NUM; j++) {
                int tag = j + 1;
                String title = String.format("項目%02d", tag);
                String summary = String.format("項目%02dの設定項目です", tag);
                if (0 == i) {
                    String keyName = "button" + tag;
                    Preference button = new Preference(this);
                    button.setKey(keyName);
                    button.setOnPreferenceClickListener(buttonListener);
                    button.setSummary(summary);
                    button.setTitle(title);
                    category.addPreference(button);
                } else {
                    String keyName = "switch" + tag;
                    boolean status = PreferencePlugin.getSwitchPreference(keyName);
                    CheckBoxPreference checkBox = new CheckBoxPreference(this);
                    checkBox.setChecked(status);
                    checkBox.setKey(keyName);
                    checkBox.setOnPreferenceChangeListener(checkBoxListener);
                    checkBox.setSummary(summary);
                    checkBox.setTitle(title);
                    category.addPreference(checkBox);
                }
            }
        }
        this.setPreferenceScreen(screen);
        return;
    }
}
