// ======================================================================
// Project Name    : android_foundation
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
package com.service.notify;
import android.app.IntentService;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;
import com.frontend.notify.BaseNotifierPlugin;
import com.frontend.notify.RemoteNotifierPlugin;
import com.frontend.receiver.notify.RemoteNotifierBroadcastReceiverPlugin;
import com.google.android.gms.gcm.GoogleCloudMessaging;
import com.unity3d.player.UnityPlayerActivity;
public class RemoteNotifierIntentServicePlugin extends IntentService {
    private static final String TITLE = "PushNotification(Remote)";
    public RemoteNotifierIntentServicePlugin() {
        super("RemoteNotifierIntentServicePlugin");
    }
    @Override
    protected void onHandleIntent(Intent intent) {
        BaseNotifierPlugin notifier = RemoteNotifierPlugin.getInstance();
        if (false == notifier.isEnabled()) {
            return;
        }
        Bundle extras = intent.getExtras();
        if (false == extras.isEmpty()) {
            GoogleCloudMessaging gcm = GoogleCloudMessaging.getInstance(this);
            String messageType = gcm.getMessageType(intent);
            if (false != GoogleCloudMessaging.MESSAGE_TYPE_MESSAGE.equals(messageType)) {
                String body = extras.toString();
                Intent nextIntent = new Intent(this, UnityPlayerActivity.class);
                PendingIntent pendingIntent = PendingIntent.getActivity(this, 777, nextIntent, PendingIntent.FLAG_UPDATE_CURRENT);
                notifier.notify(RemoteNotifierIntentServicePlugin.TITLE, body,  0, pendingIntent);
            }
        }
        RemoteNotifierBroadcastReceiverPlugin.completeWakefulIntent(intent);
        return;
    }
}
