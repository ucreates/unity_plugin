//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityEngine;
using System.Runtime.InteropServices;
using System.Collections;
namespace UnityPlugin.Frontend.Notify {
public sealed class LocalNotifierPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void registerLocalNotifier();
    [DllImport("__Internal")]
    private static extern void localNotify(string title, string body, double timeInterval);
    public LocalNotifierPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.notify.LocalNotifierPlugin");
        }
    }
    public void Register() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            registerLocalNotifier();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                AndroidJavaObject javaObject = this.androidPlugin.CallStatic<AndroidJavaObject>("getInstance");
                javaObject.Call("register");
            }
        }
        return;
    }
    public void Notify(string title, string body, double timeInterval) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            localNotify(title, body, timeInterval);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                long ltimeInterval = System.Convert.ToInt64(timeInterval);
                AndroidJavaObject javaObject = this.androidPlugin.CallStatic<AndroidJavaObject>("getInstance");
                javaObject.Call("notify", title, body, ltimeInterval);
            }
        }
        return;
    }
}
}
