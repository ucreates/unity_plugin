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
import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookException;
import com.facebook.FacebookCallback;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import java.util.Arrays;
import java.util.List;
public class FacebookServicePlugin {
    private CallbackManager callbackManager = null;
    private Boolean loggedIn = false;
    private long userId = -1;
    public void logIn(final Activity facebookActivity, final FacebookCallback<Void> callback) {
        this.callbackManager = CallbackManager.Factory.create();
        FacebookCallback<LoginResult> loginCallback = new FacebookCallback<LoginResult>() {
            @Override
            public void onSuccess(LoginResult loginResult) {
                AccessToken accessToken = loginResult.getAccessToken();
                String strUserId = accessToken.getUserId();
                userId = Long.parseLong(strUserId);
                loggedIn = true;
                callback.onSuccess(null);
                return;
            }
            @Override
            public void onCancel() {
                callback.onCancel();
                return;
            }
            @Override
            public void onError(FacebookException exception) {
                callback.onError(exception);
                return;
            }
        };
        List<String> permissionList = Arrays.asList("publish_actions");
        LoginManager loginManager = LoginManager.getInstance();
        loginManager.registerCallback(this.callbackManager, loginCallback);
        loginManager.logInWithPublishPermissions(facebookActivity, permissionList);
        return;
    }
    public void logOut() {
        LoginManager loginManager = LoginManager.getInstance();
        loginManager.logOut();
        this.loggedIn = false;
        this.userId = -1;
        return;
    }
    public boolean isLoggedIn() {
        return this.loggedIn;
    }
    public long getUserId() {
        return this.userId;
    }
    public CallbackManager getCallbackManager() {
        return this.callbackManager;
    }
}
