//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin.Core.Configure;
using UnityEngine;
using System.Runtime.InteropServices;
using System.Collections;
namespace UnityPlugin.Frontend.Controller {
public sealed class PaymentControllerPlugin : BasePlugin {
    public const string GOOGLE_PLAY_SKU_TYPE_INAPP = "inapp";
    public const string GOOGLE_PLAY_SKU_TYPE_SUBS = "subs";
    [DllImport("__Internal")]
    private static extern void transitionPaymentViewControllerPlugin(string paymentUserId, string paymentProductId);
    public override int id {
        get {
            return 5;
        }
    }
    public PaymentControllerPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.core.scene.TransitionPlugin");
        }
    }
    public void Payment(string userId, string productId, string androidSKUType = PaymentControllerPlugin.GOOGLE_PLAY_SKU_TYPE_INAPP) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            transitionPaymentViewControllerPlugin(userId, productId);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.CallStatic("transitionPayment", userId, productId, androidSKUType, PaymentConfigurePlugin.PUBLIC_KEY);
            }
        }
    }
}
}
