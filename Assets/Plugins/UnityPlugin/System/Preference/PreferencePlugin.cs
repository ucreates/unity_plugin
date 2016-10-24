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
using System.Collections;
using System.Runtime.InteropServices;
namespace UnityPlugin.System.Preference {
public sealed class PreferencePlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern bool getSwitchPreference(string keyName);
    public PreferencePlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.system.preference.PreferencePlugin");
        }
    }
    public bool GetSwitchPreference(string keyName) {
        bool ret = false;
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            ret = getSwitchPreference(keyName);
        } else if (RuntimePlatform.Android == Application.platform) {
            ret = this.androidPlugin.CallStatic<bool>("getSwitchPreference", keyName);
        }
        return ret;
    }
}
}