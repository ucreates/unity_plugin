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
public sealed class AlertViewPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void showAlertViewPlugin(string message);
    public void Show(string message) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            showAlertViewPlugin(message);
        } else if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.view.AlertViewPlugin");
            this.androidPlugin.CallStatic("show", message);
        }
        return;
    }
}
}
