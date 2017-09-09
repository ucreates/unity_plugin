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
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.FirebaseInstanceIdService;
public class FCMNotifierTokenServicePlugin extends FirebaseInstanceIdService {
    @Override
    public void onTokenRefresh() {
        FirebaseInstanceId fcmIId = FirebaseInstanceId.getInstance();
        String fcmToken = fcmIId.getToken();
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "FCMToken::" + fcmToken);
        return;
    }
}