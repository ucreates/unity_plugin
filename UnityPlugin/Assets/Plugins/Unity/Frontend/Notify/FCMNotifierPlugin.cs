﻿//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using UnityPlugin.Core.Configure.Notify;
namespace UnityPlugin.Frontend.Notify {
public sealed class FCMNotifierPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void registerFCMNotifier();
    public FCMNotifierPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.notify.FCMNotifierPlugin");
        }
    }
    public void Register() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            registerFCMNotifier();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                AndroidJavaObject javaObject = this.androidPlugin.CallStatic<AndroidJavaObject>("getInstance");
                javaObject.Call("register");
            }
        }
        return;
    }
}
}