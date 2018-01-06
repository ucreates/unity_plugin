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
public sealed class WebViewPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void showWebViewPlugin(string url, float left, float top, float right, float bottom);
    [DllImport("__Internal")]
    private static extern void hideWebViewPlugin();
    public WebViewPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.view.WebViewPlugin");
        }
    }
    public void Show(string requestUrl, float left, float top, float right, float bottom) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            showWebViewPlugin(requestUrl, left, top, right, bottom);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("create", requestUrl, (int)left, (int)top, (int)right, (int)bottom);
                this.androidPlugin.Call("show");
            }
        }
    }
    public void Hide() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            hideWebViewPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("hide");
                this.androidPlugin.Call("destroy");
            }
        }
    }
}
}
