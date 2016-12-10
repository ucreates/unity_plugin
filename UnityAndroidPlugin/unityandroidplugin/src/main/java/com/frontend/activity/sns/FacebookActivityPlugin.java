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
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import com.facebook.CallbackManager;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.FacebookCallback;
import com.facebook.share.Sharer;
import com.facebook.share.model.SharePhoto;
import com.facebook.share.model.SharePhotoContent;
import com.facebook.share.widget.ShareDialog;
import com.service.sns.FacebookServicePlugin;
import java.util.ArrayList;
public class FacebookActivityPlugin extends Activity {
    public static final int ACTIVITY_ID = 4;
    private FacebookServicePlugin service = null;
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.service = new FacebookServicePlugin();
        Intent intent = this.getIntent();
        final String facebookAppId = intent.getStringExtra("facebookAppId");
        final byte[] imageData = intent.getByteArrayExtra("imageData");
        final Activity activity = this;
        Context context = this.getApplicationContext();
        FacebookSdk.setApplicationId(facebookAppId);
        FacebookSdk.sdkInitialize(context);
        FacebookCallback<Void> callback = new FacebookCallback<Void>() {
            @Override
            public void onSuccess(Void loginResult) {
                Bitmap image = BitmapFactory.decodeByteArray(imageData, 0, imageData.length);
                SharePhoto shareImage = new SharePhoto.Builder()
                .setBitmap(image)
                .build();
                ArrayList<SharePhoto> shareImageList = new ArrayList<>();
                shareImageList.add(shareImage);
                SharePhotoContent sharePhotoContent = new SharePhotoContent.Builder()
                .setPhotos(shareImageList)
                .build();
                FacebookCallback<Sharer.Result> shareCallback = new FacebookCallback<Sharer.Result>() {
                    @Override
                    public void onSuccess(Sharer.Result shareResult) {
                        activity.finish();
                        return;
                    }
                    @Override
                    public void onCancel() {
                        service.logOut();
                        activity.finish();
                        return;
                    }
                    @Override
                    public void onError(FacebookException exception) {
                        service.logOut();
                        activity.finish();
                        return;
                    }
                };
                CallbackManager callbackManager = service.getCallbackManager();
                ShareDialog shareDialog = new ShareDialog(activity);
                shareDialog.registerCallback(callbackManager, shareCallback);
                shareDialog.show(sharePhotoContent);
                return;
            }
            @Override
            public void onCancel() {
                service.logOut();
                activity.finish();
                return;
            }
            @Override
            public void onError(FacebookException exception) {
                service.logOut();
                activity.finish();
                return;
            }
        };
        if (false == this.service.isLoggedIn()) {
            this.service.logIn(this, callback);
        } else {
            callback.onSuccess(null);
        }
        return;
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        CallbackManager callbackManager = this.service.getCallbackManager();
        if (null == callbackManager) {
            return;
        }
        callbackManager.onActivityResult(requestCode, resultCode, data);
    }
}
