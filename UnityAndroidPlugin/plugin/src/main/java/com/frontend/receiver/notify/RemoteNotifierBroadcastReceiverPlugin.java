// ======================================================================
// Project Name    : android_foundation
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
package com.frontend.receiver.notify;
import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.support.v4.content.WakefulBroadcastReceiver;
import com.frontend.notify.BaseNotifierPlugin;
import com.frontend.notify.FCMNotifierPlugin;
import com.frontend.notify.RemoteNotifierPlugin;
import com.service.notify.RemoteNotifierIntentServicePlugin;
public class RemoteNotifierBroadcastReceiverPlugin extends WakefulBroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        BaseNotifierPlugin[] notifiers = {RemoteNotifierPlugin.getInstance(), FCMNotifierPlugin.getInstance()};
        for (int i = 0; i < notifiers.length; i++) {
            BaseNotifierPlugin notifier = notifiers[i];
            notifier.register(context, intent);
        }
        Class<RemoteNotifierIntentServicePlugin> clazz = RemoteNotifierIntentServicePlugin.class;
        String packageName = context.getPackageName();
        String serviceName = clazz.getName();
        ComponentName name = new ComponentName(packageName, serviceName);
        Intent serviceIntent = intent.setComponent(name);
        this.startWakefulService(context, serviceIntent);
        this.setResultCode(Activity.RESULT_OK);
        return;
    }
}
