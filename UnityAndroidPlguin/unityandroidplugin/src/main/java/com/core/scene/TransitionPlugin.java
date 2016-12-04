//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.core.scene;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.frontend.activity.ActivityPlugin;
import com.frontend.activity.ActivityFactoryPlugin;
public class TransitionPlugin {
    public static void execute(int activityId) {
        final Activity fromActivity = ActivityPlugin.getInstance();
        final int id = activityId;
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Activity toActivity = ActivityFactoryPlugin.factoryMethod(id);
                Intent intent = new Intent(fromActivity, toActivity.getClass());
                fromActivity.startActivity(intent);
                return;
            }
        };
        fromActivity.runOnUiThread(runnable);
        return;
    }
    public static void executeTwitter(final int activityId, final String post, final String pixPath, final String consumerKey, final String consumerSecret, final boolean useTwitterCard) {
        final Activity fromActivity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Activity toActivity = ActivityFactoryPlugin.factoryMethod(activityId);
                Intent intent = new Intent(fromActivity, toActivity.getClass());
                intent.putExtra("post", post);
                intent.putExtra("pixPath", pixPath);
                intent.putExtra("consumerKey", consumerKey);
                intent.putExtra("consumerSecret", consumerSecret);
                intent.putExtra("useTwitterCard", useTwitterCard);
                fromActivity.startActivity(intent);
                return;
            }
        };
        fromActivity.runOnUiThread(runnable);
        return;
    }
}
