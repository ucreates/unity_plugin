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
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import com.service.platform.GoogleServicePlugin;
public class GoogleActivityPlugin extends AppCompatActivity {
    public static final int ACTIVITY_ID = 7;
    private final static int LOGIN = 0;
    private final static int LOGOUT = 1;
    private final static int REVOKEACCESS = 2;
    private final static int SIGNIN_REQUEST = 9001;
    private GoogleServicePlugin service;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = this.getIntent();
        String clientId = intent.getStringExtra("clientId");
        int mode = intent.getIntExtra("authorizeType", 0);
        this.service = new GoogleServicePlugin();
        this.service.buildApiClient(clientId, this);
        if (GoogleActivityPlugin.LOGIN == mode) {
            Intent signInIntent = this.service.logIn();
            this.startActivityForResult(signInIntent, GoogleActivityPlugin.SIGNIN_REQUEST);
        } else if (GoogleActivityPlugin.LOGOUT == mode) {
            this.service.logOut();
        } else if (GoogleActivityPlugin.REVOKEACCESS == mode) {
            this.service.revokeAccess();
        }
        return;
    }
    @Override
    public void onStart() {
        super.onStart();
        this.service.silentLogIn();
        return;
    }
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        this.service.send(data);
        return;
    }
}