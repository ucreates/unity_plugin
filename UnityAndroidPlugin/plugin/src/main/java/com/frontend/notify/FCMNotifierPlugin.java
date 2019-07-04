// ======================================================================
// Project Name    : android_foundation
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
package com.frontend.notify;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;
import com.core.identifier.TagPlugin;
import com.frontend.activity.ActivityPlugin;
import com.google.firebase.iid.FirebaseInstanceId;
public class FCMNotifierPlugin extends BaseNotifierPlugin {
    private static FCMNotifierPlugin instance = null;
    private FCMNotifierPlugin() {}
    public static FCMNotifierPlugin getInstance() {
        if (null == FCMNotifierPlugin.instance) {
            FCMNotifierPlugin.instance = new FCMNotifierPlugin();
        }
        return FCMNotifierPlugin.instance;
    }
    @Override
    public void register() {
        final Activity activity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Window window = activity.getWindow();
                window.setFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN, WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN);
                FirebaseInstanceId fcmIId = FirebaseInstanceId.getInstance();
                String fcmToken = fcmIId.getToken();
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "FCMToken::" + fcmToken);
                enable = true;
                return;
            }
        };
        activity.runOnUiThread(runnable);
        return;
    }
    @Override
    public void register(Context context, Intent intent) {
        String udt = intent.getStringExtra("google.c.a.udt");
        this.context = context;
        if (null != udt) {
            this.enable = true;
        }
        return;
    }
}
