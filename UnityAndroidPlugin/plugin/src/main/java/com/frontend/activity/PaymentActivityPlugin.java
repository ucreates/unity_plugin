//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.activity;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.util.Log;
import com.core.identifier.TagPlugin;
import com.frontend.receiver.PaymentBroadcastReceiverPlugin;
import com.service.PaymentServicePlugin;
import com.service.callback.PaymentCallbackPlugin;
public class PaymentActivityPlugin extends Activity {
    public static final int ACTIVITY_ID = 6;
    private PaymentServicePlugin service = null;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = this.getIntent();
        final String publicKey = intent.getStringExtra("publicKey");
        final String skuId = intent.getStringExtra("skuId");
        final String skuType = intent.getStringExtra("skuType");
        final String userId = intent.getStringExtra("userId");
        final Activity activity = this;
        this.service = new PaymentServicePlugin();
        PaymentCallbackPlugin callback = new PaymentCallbackPlugin() {
            @Override
            public void onSuccess() {
                service.payment(activity, skuId);
                return;
            }
            @Override
            public void onFaild(String message) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, message);
                service.destroy();
                activity.finish();
                return;
            }
        };
        Context context = this.getApplicationContext();
        PaymentBroadcastReceiverPlugin receiver = new PaymentBroadcastReceiverPlugin();
        IntentFilter intentFilter = new IntentFilter("com.android.vending.billing.PURCHASES_UPDATED");
        activity.registerReceiver(receiver, intentFilter);
        this.service.request(userId, skuType, publicKey, context, callback);
        return;
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        this.service.verify(requestCode, resultCode, data);
        this.finish();
        return;
    }
}
