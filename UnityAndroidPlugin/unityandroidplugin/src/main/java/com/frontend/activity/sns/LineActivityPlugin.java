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
import com.core.identifier.TagPlugin;
import com.frontend.view.AlertViewPlugin;
import com.service.sns.LineServicePlugin;
import java.util.List;
import jp.line.android.sdk.LineSdkContextManager;
import jp.line.android.sdk.login.LineLoginFuture;
import jp.line.android.sdk.login.LineLoginFutureListener;
public class LineActivityPlugin extends Activity {
    public static final int ACTIVITY_ID = 5;
    private boolean installedApp = true;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = this.getIntent();
        final String imageDataPath = intent.getStringExtra("imageDataPath");
        final Activity activity = this;
        Context context = this.getApplicationContext();
        LineSdkContextManager.initialize(context);
        LineLoginFutureListener loginCallback = new LineLoginFutureListener() {
            @Override
            public void loginComplete(LineLoginFuture future) {
                LineLoginFuture.ProgressOfLogin status = LineLoginFuture.ProgressOfLogin.SUCCESS;
                if (null != future) {
                    status = future.getProgress();
                }
                switch (status) {
                case SUCCESS:
                    boolean installed = false;
                    PackageManager packageManager = activity.getPackageManager();
                    List<ApplicationInfo> list = packageManager.getInstalledApplications(0);
                    for (ApplicationInfo appInfo : list) {
                        if (false != appInfo.packageName.endsWith("jp.naver.line.android")) {
                            installed = true;
                            break;
                        }
                    }
                    if (false == installed) {
                        installedApp = false;
                        activity.finish();
                        return;
                    }
                    Uri uri = Uri.parse("line://msg/image/" + imageDataPath);
                    Intent intent = new Intent();
                    intent.setAction(Intent.ACTION_VIEW);
                    intent.setData(uri);
                    activity.startActivity(intent);
                    break;
                case CANCELED:
                    break;
                default:
                    break;
                }
                activity.finish();
                return;
            }
        };
        LineServicePlugin service = new LineServicePlugin();
        if (false == service.isLoggedIn()) {
            service.logIn(this, loginCallback);
        } else {
            loginCallback.loginComplete(null);
        }
        return;
    }
    @Override
    protected void onDestroy() {
        if (false == this.installedApp) {
            AlertViewPlugin.show("not installed LINE.");
        }
        super.onDestroy();
        return;
    }
}
