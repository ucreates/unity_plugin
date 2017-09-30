//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.service.platform;
import android.content.Intent;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInResult;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.OptionalPendingResult;
import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.common.api.Status;
public class GoogleServicePlugin {
    private GoogleApiClient apiClient;
    private boolean enable;
    public GoogleServicePlugin() {
        this.enable = false;
    }
    public void buildApiClient(String oauthClientId, FragmentActivity activity) {
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, oauthClientId);
        GoogleApiClient.OnConnectionFailedListener callback = new GoogleApiClient.OnConnectionFailedListener() {
            @Override
            public void onConnectionFailed(ConnectionResult connectionResult) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, connectionResult.getErrorMessage());
                return;
            }
        };
        GoogleSignInOptions.Builder optionsBuilder = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN);
        GoogleApiClient.Builder apiClientBuilder = new GoogleApiClient.Builder(activity);
        GoogleSignInOptions options = optionsBuilder
                                      .requestIdToken(oauthClientId)
                                      .requestEmail()
                                      .build();
        this.apiClient = apiClientBuilder
                         .enableAutoManage(activity, callback)
                         .addApi(Auth.GOOGLE_SIGN_IN_API, options)
                         .build();
        this.enable = true;
        return;
    }
    public Intent logIn() {
        if (false == this.enable) {
            return null;
        }
        return Auth.GoogleSignInApi.getSignInIntent(this.apiClient);
    }
    public void silentLogIn() {
        if (false == this.enable) {
            return;
        }
        ResultCallback<GoogleSignInResult> callback = new ResultCallback<GoogleSignInResult>() {
            @Override
            public void onResult(GoogleSignInResult result) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, result.getStatus().toString());
                return;
            }
        };
        OptionalPendingResult<GoogleSignInResult> opr = Auth.GoogleSignInApi.silentSignIn(this.apiClient);
        if (false == opr.isDone()) {
            opr.setResultCallback(callback);
            return;
        }
        GoogleSignInResult signInResult = opr.get();
        if (false == signInResult.isSuccess()) {
            return;
        }
        this.send(signInResult);
        return;
    }
    public void logOut() {
        if (false == this.enable) {
            return;
        }
        ResultCallback<Status> callback = new ResultCallback<Status>() {
            @Override
            public void onResult(Status status) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, status.toString());
                return;
            }
        };
        Auth.GoogleSignInApi
        .signOut(this.apiClient)
        .setResultCallback(callback);
        return;
    }
    public void revokeAccess() {
        if (false == this.enable) {
            return;
        }
        ResultCallback<Status> callback = new ResultCallback<Status>() {
            @Override
            public void onResult(Status status) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, status.toString());
                return;
            }
        };
        Auth.GoogleSignInApi
        .revokeAccess(this.apiClient)
        .setResultCallback(callback);
        return;
    }
    public void send(Intent data) {
        GoogleSignInResult signInResult = Auth.GoogleSignInApi.getSignInResultFromIntent(data);
        this.send(signInResult);
        return;
    }
    public void send(GoogleSignInResult signInResult) {
        if (false == this.enable || false == signInResult.isSuccess()) {
            Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "logIn is faild::" + signInResult.getStatus().toString());
            return;
        }
        GoogleSignInAccount acct = signInResult.getSignInAccount();
        String idToken = acct.getIdToken();
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "idToken::" + idToken);
        return;
    }
}