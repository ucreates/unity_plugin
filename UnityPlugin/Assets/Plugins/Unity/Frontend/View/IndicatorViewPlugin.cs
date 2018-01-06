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
public sealed class IndicatorViewPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void showIndicatorViewPlugin();
    [DllImport("__Internal")]
    private static extern void hideIndicatorViewPlugin();
    public IndicatorViewPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.view.IndicatorViewPlugin");
        }
    }
    public void Show() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            showIndicatorViewPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("show");
            }
        }
    }
    public void Hide() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            hideIndicatorViewPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("hide");
            }
        }
    }
}
}
