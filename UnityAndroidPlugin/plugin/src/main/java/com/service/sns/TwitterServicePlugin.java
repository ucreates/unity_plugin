//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.service.sns;
import android.app.Activity;
import com.twitter.sdk.android.core.TwitterCore;
import com.twitter.sdk.android.core.Callback;
import com.twitter.sdk.android.core.Result;
import com.twitter.sdk.android.core.TwitterException;
import com.twitter.sdk.android.core.TwitterSession;
import com.twitter.sdk.android.core.SessionManager;
import com.twitter.sdk.android.core.identity.TwitterAuthClient;
public class TwitterServicePlugin {
    private Boolean loggedIn = false;
    private long userId = -1;
    private TwitterAuthClient client = null;
    public void logIn(final Activity twitterActivityPlugin, final Callback<Void> callback) {
        Callback<TwitterSession> logInCallback = new Callback<TwitterSession>() {
            @Override
            public void success(Result<TwitterSession> result) {
                TwitterCore core = TwitterCore.getInstance();
                SessionManager<TwitterSession> sessionManager = core.getSessionManager();
                TwitterSession activeSession = sessionManager.getActiveSession();
                if (null == activeSession) {
                    callback.failure(null);
                    loggedIn = false;
                    return;
                }
                sessionManager.setActiveSession(result.data);
                callback.success(null);
                userId = result.data.getUserId();
                loggedIn = true;
            }
            @Override
            public void failure(TwitterException exception) {
                callback.failure(exception);
                loggedIn = false;
            }
        };
        client = new TwitterAuthClient();
        client.authorize(twitterActivityPlugin, logInCallback);
        return;
    }
    public void logOut() {
        loggedIn = false;
        return;
    }
    public boolean isLoggedIn() {
        return this.loggedIn;
    }
    public long getUserId() {
        return this.userId;
    }
    public TwitterAuthClient getAuthClient() {
        return this.client;
    }
    public TwitterSession getActiveSession() {
        TwitterCore core = TwitterCore.getInstance();
        SessionManager<TwitterSession> sessionManager = core.getSessionManager();
        TwitterSession activeSession = sessionManager.getActiveSession();
        return activeSession;
    }
}
