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
import com.frontend.activity.ActivityPlugin;
import com.frontend.activity.ActivityFactoryPlugin;
public class TransitionPlugin {
    public static void execute(int activityId) {
        final Activity fromActivity = ActivityPlugin.getInstance();
        final int id = activityId;
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Activity toActiviry = ActivityFactoryPlugin.factoryMethod(id);
                Intent intent = new Intent(fromActivity, toActiviry.getClass());
                fromActivity.startActivity(intent);
                return;
            }
        };
        fromActivity.runOnUiThread(runnable);
        return;
    }
}
