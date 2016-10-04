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
import android.app.Dialog;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.FrameLayout;
import android.widget.ProgressBar;
import com.frontend.activity.ActivityPlugin;
public class IndicatorViewPlugin {
    private Dialog dialog;
    public void show() {
        final Activity activity = ActivityPlugin.getInstance();
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                FrameLayout.LayoutParams progressBarLayoutParams = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                ProgressBar progressBar = new ProgressBar(activity);
                progressBar.setIndeterminate(true);
                progressBar.setLayoutParams(progressBarLayoutParams);
                FrameLayout.LayoutParams dialogLayoutParams = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                FrameLayout relativeLayout = new FrameLayout(activity);
                relativeLayout.addView(progressBar, dialogLayoutParams);
                ColorDrawable drawable = new ColorDrawable(Color.TRANSPARENT);
                dialog = new Dialog(activity);
                dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
                Window window = dialog.getWindow();
                window.setBackgroundDrawable(drawable);
                dialog.setCancelable(false);
                dialog.setContentView(relativeLayout);
                dialog.show();
                return;
            }
        });
        return;
    }
    public void hide() {
        final Activity activity = ActivityPlugin.getInstance();
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (null == dialog) {
                    return;
                }
                dialog.dismiss();
                dialog = null;
                return;
            }
        });
        return;
    }
}
