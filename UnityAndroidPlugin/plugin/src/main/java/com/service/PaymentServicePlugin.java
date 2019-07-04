//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.service;
import android.app.Activity;
import android.app.PendingIntent;
import android.content.Context;
import android.content.ComponentName;
import android.content.Intent;
import android.content.IntentSender;
import android.content.IntentSender.SendIntentException;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.text.TextUtils;
import android.util.Log;
import com.android.vending.billing.IInAppBillingService;
import com.core.identifier.TagPlugin;
import com.core.validator.PaymentValidatorPlugin;
import com.service.callback.PaymentCallbackPlugin;
import com.service.response.PaymentServiceResponsePlugin;
import java.lang.Runnable;
import java.lang.Thread;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONException;
import org.json.JSONObject;
public class PaymentServicePlugin {
    private final static int INAPPBILLING_API_VERSION = 3;
    private final static int REQUEST_CODE = 10001;
    private final static String SKU_TYPE_INAPP = "inapp";
    private final static String SKU_TYPE_SUBS = "subs";
    private String userId = null;
    private String publicKey = null;
    private String skuType = null;
    private Context context = null;
    private ServiceConnection connection = null;
    private IInAppBillingService serviceInterface = null;
    public void request(String paymentUserId, String paymentSkuType, String base64EncordedPublicKey, final Context applicationContext, final PaymentCallbackPlugin callback) {
        if (false == paymentSkuType.equals(PaymentServicePlugin.SKU_TYPE_INAPP) && false == paymentSkuType.equals(PaymentServicePlugin.SKU_TYPE_SUBS)) {
            return;
        }
        this.connection = new ServiceConnection() {
            @Override
            public void onServiceConnected(ComponentName name, IBinder service) {
                try {
                    serviceInterface = IInAppBillingService.Stub.asInterface(service);
                    String packageName = applicationContext.getPackageName();
                    int response = serviceInterface.isBillingSupported(PaymentServicePlugin.INAPPBILLING_API_VERSION, packageName, skuType);
                    if (PaymentServiceResponsePlugin.RESULT_OK != response) {
                        return;
                    }
                    callback.onSuccess();
                } catch (RemoteException e) {
                    String message = e.getMessage();
                    callback.onFaild(message);
                }
                return;
            }
            @Override
            public void onServiceDisconnected(ComponentName name) {
                return;
            }
        };
        PackageManager manager = applicationContext.getPackageManager();
        Intent intent = new Intent("com.android.vending.billing.InAppBillingService.BIND");
        intent.setPackage("com.android.vending");
        List<ResolveInfo> intentServiceList = manager.queryIntentServices(intent, 0);
        if (null == intentServiceList || false != intentServiceList.isEmpty()) {
            return;
        }
        applicationContext.bindService(intent, this.connection, Context.BIND_AUTO_CREATE);
        this.context = applicationContext;
        this.publicKey = base64EncordedPublicKey;
        this.skuType = paymentSkuType;
        this.userId = paymentUserId;
        return;
    }
    public void payment(final Activity activity, final String skuId) {
        PaymentCallbackPlugin callback = new PaymentCallbackPlugin() {
            @Override
            public void onSuccess() {
                try {
                    String packageName = context.getPackageName();
                    ArrayList<String> skuIdList = new ArrayList<String> ();
                    skuIdList.add(skuId);
                    Bundle querySKUIdListBundle = new Bundle();
                    querySKUIdListBundle.putStringArrayList("ITEM_ID_LIST", skuIdList);
                    Bundle skuDetailsList = serviceInterface.getSkuDetails(PaymentServicePlugin.INAPPBILLING_API_VERSION, packageName, skuType, querySKUIdListBundle);
                    int response = PaymentServiceResponsePlugin.getResponse(skuDetailsList);
                    if (PaymentServiceResponsePlugin.RESULT_OK != response) {
                        activity.finish();
                        return;
                    }
                    boolean ret = PaymentValidatorPlugin.isValid(skuId, skuDetailsList);
                    if (false == ret) {
                        activity.finish();
                        return;
                    }
                    Bundle bundle = serviceInterface.getBuyIntent(PaymentServicePlugin.INAPPBILLING_API_VERSION, packageName, skuId, skuType, userId);
                    response = PaymentServiceResponsePlugin.getResponse(bundle);
                    if (PaymentServiceResponsePlugin.RESULT_OK != response) {
                        activity.finish();
                        return;
                    }
                    PendingIntent pendingIntent = bundle.getParcelable("BUY_INTENT");
                    IntentSender sender = pendingIntent.getIntentSender();
                    activity.startIntentSenderForResult(sender, PaymentServicePlugin.REQUEST_CODE, new Intent(), Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0));
                } catch (RemoteException e) {
                    e.printStackTrace();
                } catch (JSONException e) {
                    e.printStackTrace();
                } catch (SendIntentException e) {
                    e.printStackTrace();
                }
                return;
            }
            @Override
            public void onFaild(String message) {
                Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, message);
                activity.finish();
                return;
            }
        };
        this.clear(callback);
        return;
    }
    public void verify(int requestCode, int resultCode, Intent data) {
        if (PaymentServicePlugin.REQUEST_CODE != requestCode) {
            this.destroy();
            return;
        }
        int response = PaymentServiceResponsePlugin.getResponse(data);
        if (PaymentServiceResponsePlugin.RESULT_OK != response || Activity.RESULT_OK != resultCode) {
            this.destroy();
            return;
        }
        String purchaseData = data.getStringExtra("INAPP_PURCHASE_DATA");
        String dataSignature = data.getStringExtra("INAPP_DATA_SIGNATURE");
        if (null == purchaseData || null == dataSignature) {
            this.destroy();
            return;
        }
        if (false == PaymentValidatorPlugin.isValid(this.publicKey, purchaseData, dataSignature)) {
            this.destroy();
            return;
        }
        Log.i(TagPlugin.UNITY_PLUGIN_IDENTIFIER, "billing summary " + purchaseData);
        //send your purchase data.
        this.destroy();
        return;
    }
    public void clear(final PaymentCallbackPlugin callback) {
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                String packageName = context.getPackageName();
                String continueToken = null;
                do {
                    try {
                        Bundle ownedItems = serviceInterface.getPurchases(PaymentServicePlugin.INAPPBILLING_API_VERSION, packageName, skuType, continueToken);
                        int response = PaymentServiceResponsePlugin.getResponse(ownedItems);
                        if (PaymentServiceResponsePlugin.RESULT_OK != response) {
                            return;
                        }
                        if (false == ownedItems.containsKey("INAPP_PURCHASE_ITEM_LIST")
                                || false == ownedItems.containsKey("INAPP_PURCHASE_DATA_LIST")
                                || false == ownedItems.containsKey("INAPP_DATA_SIGNATURE_LIST")) {
                            return;
                        }
                        ArrayList<String> ownedSKUIdList = ownedItems.getStringArrayList("INAPP_PURCHASE_ITEM_LIST");
                        ArrayList<String> purchaseDataList = ownedItems.getStringArrayList("INAPP_PURCHASE_DATA_LIST");
                        ArrayList<String> signatureList = ownedItems.getStringArrayList("INAPP_DATA_SIGNATURE_LIST");
                        for (int i = 0; i < purchaseDataList.size(); i++) {
                            String purchaseData = purchaseDataList.get(i);
                            String signature = signatureList.get(i);
                            String skuId = ownedSKUIdList.get(i);
                            if (false == PaymentValidatorPlugin.isValid(publicKey, purchaseData, signature)) {
                                continue;
                            }
                            JSONObject jsonObject = new JSONObject(purchaseData);
                            String purchaseToken = jsonObject.optString("purchaseToken");
                            String token = jsonObject.optString("token", purchaseToken);
                            response = serviceInterface.consumePurchase(PaymentServicePlugin.INAPPBILLING_API_VERSION, packageName, token);
                            if (PaymentServiceResponsePlugin.RESULT_OK != response) {
                                continue;
                            }
                        }
                    } catch (JSONException e) {
                        String message = e.getMessage();
                        callback.onFaild(message);
                    } catch (RemoteException e) {
                        String message = e.getMessage();
                        callback.onFaild(message);
                    }
                } while (false == TextUtils.isEmpty(continueToken));
                callback.onSuccess();
                return;
            }
        };
        Thread thread = new Thread(runnable);
        thread.start();
        return;
    }
    public void destroy() {
        if (null != this.connection && null != this.context) {
            this.context.unbindService(this.connection);
            this.connection = null;
        }
        this.context = null;
        this.serviceInterface = null;
        return;
    }
}