//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.view;
import android.app.Activity;
import android.app.AlertDialog;
import com.frontend.activity.ActivityPlugin;
public class AlertViewPlugin {
    public static void show(String message) {
        final Activity activity = ActivityPlugin.getInstance();
        final String alertMessage = message;
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                new AlertDialog.Builder(activity)
                .setTitle(alertMessage)
                .setPositiveButton("OK", null)
                .show();
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
}