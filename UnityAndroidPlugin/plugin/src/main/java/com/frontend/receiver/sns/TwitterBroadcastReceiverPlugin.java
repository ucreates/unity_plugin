//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.receiver.sns;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.twitter.sdk.android.tweetcomposer.TweetUploadService;
public class TwitterBroadcastReceiverPlugin extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (false != TweetUploadService.UPLOAD_SUCCESS.equals(action)) {
            Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, TweetUploadService.UPLOAD_SUCCESS);
        } else {
            Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, TweetUploadService.UPLOAD_FAILURE);
        }
        return;
    }
}