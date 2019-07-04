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
namespace UnityPlugin.Core.IO {
public sealed class PathPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void fillPathPlugin(string dataPath, string persistentDataPath, string streamingAssetsPath, string temporaryCachePath);
    [DllImport("__Internal")]
    private static extern void dumpPathPlugin();
    public PathPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.core.io.PathPlugin");
        }
    }
    public void Fill() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            fillPathPlugin(Application.dataPath, Application.persistentDataPath, Application.streamingAssetsPath, Application.temporaryCachePath);
        } else if (RuntimePlatform.Android == Application.platform) {
            AndroidJavaObject javaObject = this.androidPlugin.CallStatic<AndroidJavaObject>("getInstance");
            javaObject.Call("fill", Application.dataPath, Application.persistentDataPath, Application.streamingAssetsPath, Application.temporaryCachePath);
        }
        return;
    }
    public void Dump() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            dumpPathPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            AndroidJavaObject javaObject = this.androidPlugin.CallStatic<AndroidJavaObject>("getInstance");
            javaObject.Call("dump");
        }
        return;
    }
}
}
