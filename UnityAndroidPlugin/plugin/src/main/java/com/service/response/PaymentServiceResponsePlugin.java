//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.service.response;
import android.content.Intent;
import android.os.Bundle;
public class PaymentServiceResponsePlugin {
    public static final int RESULT_OK = 0;
    public static final int RESULT_USER_CANCELED = 1;
    public static final int RESULT_SERVICE_UNAVAILABLE = 2;
    public static final int RESULT_BILLING_UNAVAILABLE = 3;
    public static final int RESULT_ITEM_UNAVAILABLE = 4;
    public static final int RESULT_DEVELOPER_ERROR = 5;
    public static final int RESULT_ERROR = 6;
    public static final int RESULT_ITEM_ALREADY_OWNED = 7;
    public static final int RESULT_ITEM_NOT_OWNED = 8;
    public static int getResponse(Bundle bundle) {
        Object ret = bundle.get("RESPONSE_CODE");
        if (null != ret) {
            if (ret instanceof Integer) {
                Integer intRet = (Integer) ret;
                int response = intRet.intValue();
                if (0 != response) {
                    return response;
                }
            } else if (ret instanceof Long) {
                Long longRet = (Long) ret;
                long response = longRet.longValue();
                if (0 != response) {
                    return (int)response;
                }
            } else {
                return PaymentServiceResponsePlugin.RESULT_ERROR;
            }
        }
        return PaymentServiceResponsePlugin.RESULT_OK;
    }
    public static int getResponse(Intent intent) {
        Bundle bundle = intent.getExtras();
        return PaymentServiceResponsePlugin.getResponse(bundle);
    }
}