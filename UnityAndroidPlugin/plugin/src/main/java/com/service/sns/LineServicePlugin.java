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
import android.util.Log;
import com.core.identifier.TagPlugin;
import jp.line.android.sdk.exception.LineSdkLoginException;
import jp.line.android.sdk.LineSdkContext;
import jp.line.android.sdk.LineSdkContextManager;
import jp.line.android.sdk.model.AccessToken;
import jp.line.android.sdk.login.LineAuthManager;
import jp.line.android.sdk.login.LineLoginFuture;
import jp.line.android.sdk.login.LineLoginFutureListener;
public class LineServicePlugin {
    private Boolean loggedIn = false;
    private String userId = "";
    public void logIn(final Activity lineActivity, final LineLoginFutureListener callback) {
        LineLoginFutureListener loginCallback = new LineLoginFutureListener() {
            @Override
            public void loginComplete(LineLoginFuture future) {
                Throwable cause = future.getCause();
                if (cause instanceof LineSdkLoginException) {
                    Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, cause.getMessage());
                    callback.loginComplete(future);
                    return;
                }
                LineLoginFuture.ProgressOfLogin status = future.getProgress();
                switch (status) {
                case SUCCESS:
                    AccessToken accessToken = future.getAccessToken();
                    if (null == accessToken) {
                        logOut();
                        return;
                    }
                    userId = accessToken.mid;
                    loggedIn = true;
                    break;
                case CANCELED:
                    logOut();
                    break;
                default:
                    logOut();
                    break;
                }
                callback.loginComplete(future);
                return;
            }
        };
        LineSdkContext sdkContext = LineSdkContextManager.getSdkContext();
        LineAuthManager authManager = sdkContext.getAuthManager();
        LineLoginFuture loginFuture = authManager.login(lineActivity);
        loginFuture.addFutureListener(loginCallback);
        return;
    }
    public void logOut() {
        LineSdkContext sdkContext = LineSdkContextManager.getSdkContext();
        LineAuthManager authManager = sdkContext.getAuthManager();
        authManager.logout();
        this.loggedIn = false;
        this.userId = "";
        return;
    }
    public boolean isLoggedIn() {
        return this.loggedIn;
    }
    public String getUserId() {
        return this.userId;
    }
}
