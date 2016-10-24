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
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import com.frontend.activity.ActivityPlugin;
public class ReviewViewPlugin {
    public void show(String googlePlayUrl) {
        final Activity activity = ActivityPlugin.getInstance();
        final Uri googlePlayUri = Uri.parse(googlePlayUrl);
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                final String[] items = {"このアプリを評価する", "いいえ、まだ結構です",};
                new AlertDialog.Builder(activity)
                .setTitle("Review")
                .setItems(items, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        if (0 == which) {
                            Intent googlePlayIntent = new Intent(Intent.ACTION_VIEW);
                            googlePlayIntent.setData(googlePlayUri);
                            activity.startActivity(googlePlayIntent);
                        }
                    }
                })
                .show();
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
}
