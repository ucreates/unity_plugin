//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.activity.sns;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import com.service.sns.TwitterServicePlugin;
import com.twitter.sdk.android.core.DefaultLogger;
import com.twitter.sdk.android.core.Twitter;
import com.twitter.sdk.android.core.Callback;
import com.twitter.sdk.android.core.Result;
import com.twitter.sdk.android.core.TwitterConfig;
import com.twitter.sdk.android.core.TwitterAuthConfig;
import com.twitter.sdk.android.core.TwitterException;
import com.twitter.sdk.android.core.TwitterSession;
import com.twitter.sdk.android.core.identity.TwitterAuthClient;
import com.twitter.sdk.android.tweetcomposer.ComposerActivity;
import com.twitter.sdk.android.tweetcomposer.TweetComposer;
import java.io.File;
public class TwitterActivityPlugin extends Activity {
    public static final int ACTIVITY_ID = 3;
    private TwitterServicePlugin service;
    private static final String HASHTAG = "#hashtags by unity twitter plugin";
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = this.getIntent();
        final Activity activity = this;
        final String post = intent.getStringExtra("post");
        final String imageDataPath = intent.getStringExtra("imageDataPath");
        String consumerKey = intent.getStringExtra("consumerKey");
        String consumerSecret = intent.getStringExtra("consumerSecret");
        boolean useTwitterCard = intent.getBooleanExtra("useTwitterCard", false);
        File imageFile = new File(imageDataPath);
        final Uri imageFileUri = Uri.fromFile(imageFile);
        this.service = new TwitterServicePlugin();
        TwitterAuthConfig authConfig = new TwitterAuthConfig(consumerKey, consumerSecret);
        TwitterConfig config = new TwitterConfig.Builder(this)
        .logger(new DefaultLogger(Log.DEBUG))
        .twitterAuthConfig(authConfig)
        .debug(true)
        .build();
        Twitter.initialize(config);
        Callback<Void> callback = null;
        if (false == useTwitterCard) {
            callback = new Callback<Void>() {
                @Override
                public void success(Result<Void> result) {
                    TweetComposer.Builder builder = new TweetComposer.Builder(activity)
                    .text(post)
                    .image(imageFileUri);
                    builder.show();
                    activity.finish();
                    return;
                }
                @Override
                public void failure(TwitterException e) {
                    //Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.fillInStackTrace().toString());
                    service.logOut();
                    activity.finish();
                    return;
                }
            };
        } else {
            callback = new Callback<Void>() {
                @Override
                public void success(Result<Void> result) {
                    TwitterSession activeSession = service.getActiveSession();
                    //set your android app packageName. which is getting from Activity.getPackageName method. The package must correspond to a published app on Google Play for Card Tweets to link correctly.
                    String packageName = activity.getPackageName();
                    Intent intent = new ComposerActivity.Builder(activity)
                    .session(activeSession)
                    .hashtags(TwitterActivityPlugin.HASHTAG)
                    .createIntent();
                    activity.startActivity(intent);
                    activity.finish();
                    return;
                }
                @Override
                public void failure(TwitterException e) {
                    //Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, e.fillInStackTrace().toString());
                    service.logOut();
                    activity.finish();
                    return;
                }
            };
        }
        if (false == service.isLoggedIn()) {
            service.logIn(this, callback);
        } else {
            callback.success(null);
        }
        return;
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        TwitterAuthClient client = this.service.getAuthClient();
        if (null == client) {
            return;
        }
        client.onActivityResult(requestCode, resultCode, data);
        return;
    }
}
