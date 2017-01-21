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
import com.frontend.activity.PaymentActivityPlugin;
import com.frontend.activity.sns.TwitterActivityPlugin;
import com.frontend.activity.sns.FacebookActivityPlugin;
import com.frontend.activity.sns.LineActivityPlugin;
public class TransitionPlugin {
    public static void transition(int activityId) {
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
    public static void transitionTwitter(final String post, final String imageDataPath, final String consumerKey, final String consumerSecret, final boolean useTwitterCard) {
        final Activity fromActivity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Activity toActivity = ActivityFactoryPlugin.factoryMethod(TwitterActivityPlugin.ACTIVITY_ID);
                Intent intent = new Intent(fromActivity, toActivity.getClass());
                intent.putExtra("post", post);
                intent.putExtra("imageDataPath", imageDataPath);
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
    public static void transitionFacebook(final String facebookAppId, final byte[] imageData) {
        final Activity fromActivity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Activity toActivity = ActivityFactoryPlugin.factoryMethod(FacebookActivityPlugin.ACTIVITY_ID);
                Intent intent = new Intent(fromActivity, toActivity.getClass());
                intent.putExtra("facebookAppId", facebookAppId);
                intent.putExtra("imageData", imageData);
                fromActivity.startActivity(intent);
                return;
            }
        };
        fromActivity.runOnUiThread(runnable);
        return;
    }
    public static void transitionLine(final String imageDataPath) {
        final Activity fromActivity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Activity toActivity = ActivityFactoryPlugin.factoryMethod(LineActivityPlugin.ACTIVITY_ID);
                Intent intent = new Intent(fromActivity, toActivity.getClass());
                intent.putExtra("imageDataPath", imageDataPath);
                fromActivity.startActivity(intent);
                return;
            }
        };
        fromActivity.runOnUiThread(runnable);
        return;
    }
    public static void transitionPayment(final String userId, final String skuId, final String skuType, final String publicKey) {
        final Activity fromActivity = ActivityPlugin.getInstance();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Activity toActivity = ActivityFactoryPlugin.factoryMethod(PaymentActivityPlugin.ACTIVITY_ID);
                Intent intent = new Intent(fromActivity, toActivity.getClass());
                intent.putExtra("publicKey", publicKey);
                intent.putExtra("skuId", skuId);
                intent.putExtra("skuType", skuType);
                intent.putExtra("userId", userId);
                fromActivity.startActivity(intent);
                return;
            }
        };
        fromActivity.runOnUiThread(runnable);
        return;
    }
}
