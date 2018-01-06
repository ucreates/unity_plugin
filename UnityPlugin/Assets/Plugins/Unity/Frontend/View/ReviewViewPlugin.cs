//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityEngine;
using System.Runtime.InteropServices;
using System.Collections;
namespace UnityPlugin.Frontend.View {
public sealed class ReviewViewPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void showReviewViewPlugin(string storeUrl);
    public void Show(string storeUrl) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            showReviewViewPlugin(storeUrl);
        } else if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.view.ReviewViewPlugin");
            this.androidPlugin.CallStatic("show", storeUrl);
        }
    }
}
}
