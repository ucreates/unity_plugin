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
    public static void show(String googlePlayUrl, final String title, final String evalActionTitle, final String noActionTitle) {
        final Activity activity = ActivityPlugin.getInstance();
        final Uri googlePlayUri = Uri.parse(googlePlayUrl);
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                DialogInterface.OnClickListener listener = new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        if (0 == which) {
                            Intent googlePlayIntent = new Intent(Intent.ACTION_VIEW);
                            googlePlayIntent.setData(googlePlayUri);
                            activity.startActivity(googlePlayIntent);
                            return;
                        }
                    }
                };
                final String[] items = {evalActionTitle, noActionTitle,};
                new AlertDialog.Builder(activity)
                .setTitle(title)
                .setItems(items, listener)
                .show();
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
}
