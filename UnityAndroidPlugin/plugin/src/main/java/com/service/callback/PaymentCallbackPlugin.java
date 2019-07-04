//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.service.callback;
public abstract class PaymentCallbackPlugin {
    public abstract void onSuccess();
    public abstract void onFaild(String message);
}