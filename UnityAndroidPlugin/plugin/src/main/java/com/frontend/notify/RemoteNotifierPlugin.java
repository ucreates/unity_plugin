// ======================================================================
// Project Name    : unity plugin
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
import android.os.AsyncTask;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;
import com.core.identifier.TagPlugin;
import com.frontend.activity.ActivityPlugin;
import com.google.android.gms.gcm.GoogleCloudMessaging;
import java.io.IOException;
public class RemoteNotifierPlugin extends BaseNotifierPlugin {
    private static RemoteNotifierPlugin instance = null;
    private RemoteNotifierPlugin() {}
    public static RemoteNotifierPlugin getInstance() {
        if (null == RemoteNotifierPlugin.instance) {
            RemoteNotifierPlugin.instance = new RemoteNotifierPlugin();
        }
        return RemoteNotifierPlugin.instance;
    }
    public void register(final String senderId) {
        final Activity activity = ActivityPlugin.getInstance();
        final Context context = activity.getApplicationContext();
        AsyncTask<Void, Void, String> task = new AsyncTask<Void, Void, String>() {
            @Override
            protected String doInBackground(Void... params) {
                String gcmToken = "";
                try {
                    GoogleCloudMessaging gcm = GoogleCloudMessaging.getInstance(context);
                    gcmToken = gcm.register(senderId);
                    enable = true;
                    Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "GCMToken::" + gcmToken);
                } catch (IOException e) {
                    enable = false;
                    Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.getMessage());
                }
                return gcmToken;
            }
            @Override
            protected void onPostExecute(String msg) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, msg);
                Window window = activity.getWindow();
                window.setFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN, WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN);
                return;
            }
        };
        task.execute(null, null, null);
        return;
    }
    @Override
    public void register(Context context, Intent intent) {
        String udt = intent.getStringExtra("google.c.a.udt");
        if (null == udt) {
            this.enable = true;
        }
        this.context = context;
        return;
    }
}
