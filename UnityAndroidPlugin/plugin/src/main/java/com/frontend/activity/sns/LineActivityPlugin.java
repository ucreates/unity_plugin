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
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import com.frontend.view.AlertViewPlugin;
import com.linecorp.linesdk.LineApiResponseCode;
import com.linecorp.linesdk.Scope;
import com.linecorp.linesdk.auth.LineAuthenticationParams;
import com.linecorp.linesdk.auth.LineLoginApi;
import com.linecorp.linesdk.auth.LineLoginResult;
import java.util.Arrays;
import java.util.List;
public class LineActivityPlugin extends Activity {
    public static final int ACTIVITY_ID = 5;
    public static final int REQUEST_CODE = 1;
    private String imageDataPath = "";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = this.getIntent();
        this.imageDataPath = intent.getStringExtra("imageDataPath");
        try {
            String packageName = getPackageName();
            ApplicationInfo appInfo = this.getPackageManager().getApplicationInfo(packageName, PackageManager.GET_META_DATA);
            final String channelId = appInfo.metaData.getString("jp.line.sdk.ChannelId");
            List<Scope> scopeList = Arrays.asList(Scope.PROFILE);
            LineAuthenticationParams params = new LineAuthenticationParams.Builder().scopes(scopeList).build();
            Context context = this.getApplicationContext();
            Intent loginIntent = LineLoginApi.getLoginIntent(context, channelId, params);
            this.startActivityForResult(loginIntent, REQUEST_CODE);
        } catch (Exception e) {
            AlertViewPlugin.show(e.getLocalizedMessage());
            this.finish();
        }
        return;
    }
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode != REQUEST_CODE) {
            Log.e("ERROR", "Unsupported Request");
            return;
        }
        LineLoginResult result = LineLoginApi.getLoginResultFromIntent(data);
        LineApiResponseCode responseCode = result.getResponseCode();
        switch (responseCode) {
        case SUCCESS:
            boolean installed = false;
            PackageManager packageManager = this.getPackageManager();
            List<ApplicationInfo> list = packageManager.getInstalledApplications(0);
            for (ApplicationInfo appInfo : list) {
                if (false != appInfo.packageName.endsWith("jp.naver.line.android")) {
                    installed = true;
                    break;
                }
            }
            if (false == installed) {
                AlertViewPlugin.show("LINE App is not installed.");
                this.finish();
                return;
            }
            String uriString = String.format("line://msg/image/%s", imageDataPath);
            Uri uri = Uri.parse(uriString);
            Intent intent = new Intent();
            intent.setAction(Intent.ACTION_VIEW);
            intent.setData(uri);
            this.startActivity(intent);
            break;
        case CANCEL:
            AlertViewPlugin.show("LINE Login Canceled by user.");
            break;
        default:
            String errorMessage = String.format("Login FAILED! responseCode::%s, error::%s", responseCode.toString(), result.getErrorData().toString());
            AlertViewPlugin.show(errorMessage);
            break;
        }
        this.finish();
        return;
    }
}
