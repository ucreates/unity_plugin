//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin.Core.Configure.Platform;
using UnityEngine;
using System;
using System.Runtime.InteropServices;
using System.IO;
using System.Collections;
namespace UnityPlugin.Frontend.Controller.Platform {
public sealed class GoogleControllerPlugin : BasePlugin {
    private const int LOGIN = 0;
    private const int LOGOUT = 1;
    private const int REVOKE_ACCESS = 2;
    [DllImport("__Internal")]
    private static extern void transitionGoogleViewControllerPlugin(string clientId, int mode);
    public GoogleControllerPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.core.scene.TransitionPlugin");
        }
    }
    public void LogIn() {
        this.Transition(GoogleControllerPlugin.LOGIN);
        return;
    }
    public void LogOut() {
        this.Transition(GoogleControllerPlugin.LOGOUT);
        return;
    }
    public void RevokeAccess() {
        this.Transition(GoogleControllerPlugin.REVOKE_ACCESS);
        return;
    }
    private void Transition(int authorizeType) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            transitionGoogleViewControllerPlugin(GoogleConfigurePlugin.iOS_CLIENT_ID, authorizeType);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null == this.androidPlugin) {
                return;
            }
            this.androidPlugin.CallStatic("transitionGoogle", GoogleConfigurePlugin.ANDROID_CLIENT_ID, authorizeType);
        }
        return;
    }
}
}
