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
import android.app.PendingIntent;
import android.content.Intent;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.frontend.notify.BaseNotifierPlugin;
import com.frontend.notify.FCMNotifierPlugin;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import com.unity3d.player.UnityPlayerActivity;
public class FCMNotifierMessageServicePlugin extends FirebaseMessagingService {
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        BaseNotifierPlugin notifier = FCMNotifierPlugin.getInstance();
        if (false == notifier.isEnabled()) {
            Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "FCMNotifier does not enable.");
            return;
        }
        RemoteMessage.Notification notification = remoteMessage.getNotification();
        String title = notification.getTitle();
        String body = notification.getBody();
        Intent nextIntent = new Intent(this, UnityPlayerActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 777, nextIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        notifier.notify(title, body, 0, pendingIntent);
        return;
    }
}