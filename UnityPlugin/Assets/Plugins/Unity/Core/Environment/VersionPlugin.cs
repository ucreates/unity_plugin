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
using System;
using System.Runtime.InteropServices;
using System.Collections;
namespace UnityPlugin.Core.Environment {
public sealed class VersionPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern int getVersionPlugin();
    [DllImport("__Internal")]
    private static extern string getVersionNamePlugin();
    public VersionPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.core.environment.VersionPlugin");
        }
    }
    public int GetVersion() {
        int version = 0;
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            version = getVersionPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            version = this.androidPlugin.CallStatic<int>("getVersion");
        } else {
            float fVersion = Convert.ToSingle(Application.version);
            version = Convert.ToInt32(fVersion);
        }
        return version;
    }
    public string GetVersionName() {
        string versionName = "0.0.0";
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            versionName = getVersionNamePlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            versionName = this.androidPlugin.CallStatic<string>("getVersionName");
        } else {
            versionName = Application.version;
        }
        return versionName;
    }
}
}
