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
namespace UnityPlugin.Frontend.Controller {
public sealed class PreferenceControllerPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void transitionViewControllerPlugin(int viewControllerId);
    public override int id {
        get {
            return 2;
        }
    }
    public PreferenceControllerPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.core.scene.TransitionPlugin");
        }
    }
    public void Transition() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            transitionViewControllerPlugin(this.id);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.CallStatic("transition", this.id);
            }
        }
    }
}
}
