//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.activity.platform;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.service.platform.GoogleServicePlugin;
public class GoogleActivityPlugin extends AppCompatActivity {
    public static final int ACTIVITY_ID = 7;
    public final static int SIGNIN_REQUEST = 9001;
    private final static int LOGIN = 0;
    private final static int LOGOUT = 1;
    private final static int REVOKEACCESS = 2;
    private GoogleServicePlugin service;
    private int mode;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = this.getIntent();
        String clientId = intent.getStringExtra("clientId");
        this.mode = intent.getIntExtra("authorizeType", 0);
        this.service = new GoogleServicePlugin();
        this.service.buildApiClient(clientId, this);
        if (GoogleActivityPlugin.LOGIN == this.mode) {
            this.service.logIn();
        } else if (GoogleActivityPlugin.LOGOUT == this.mode) {
            this.service.logOut();
        } else if (GoogleActivityPlugin.REVOKEACCESS == this.mode) {
            this.service.revokeAccess();
        }
        return;
    }
    @Override
    public void onStart() {
        super.onStart();
        if (GoogleActivityPlugin.LOGIN == this.mode) {
            this.service.silentLogIn();
        }
        return;
    }
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (Activity.RESULT_OK != resultCode || GoogleActivityPlugin.SIGNIN_REQUEST != requestCode) {
            Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, String.format("faild activity result.requestCode::%d,resultCode::%d", requestCode, resultCode));
            return;
        }
        this.service.send(data);
        this.finish();
        return;
    }
}
