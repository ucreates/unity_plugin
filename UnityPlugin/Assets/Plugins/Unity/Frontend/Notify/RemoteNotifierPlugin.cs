//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin.Core.Configure.Notify;
using UnityEngine;
using System.Runtime.InteropServices;
using System.Collections;
namespace UnityPlugin.Frontend.Notify {
public sealed class RemoteNotifierPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void registerRemoteNotifier();
    public RemoteNotifierPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.notify.RemoteNotifierPlugin");
        }
    }
    public void Register() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            registerRemoteNotifier();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                AndroidJavaObject javaObject = this.androidPlugin.CallStatic<AndroidJavaObject>("getInstance");
                javaObject.Call("register", RemoteNotifierConfigurePlugin.SENDER_ID);
            }
        }
        return;
    }
}
}
