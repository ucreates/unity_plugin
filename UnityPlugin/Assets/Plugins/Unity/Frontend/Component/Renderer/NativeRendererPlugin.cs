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
using AOT;
namespace UnityPlugin.Frontend.Component.Renderer {
public class NativeRendererPlugin : BasePlugin {
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern void CreateNativeRendererPlugin();
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern void DestroyNativeRendererPlugin();
    public void Create() {
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            CreateNativeRendererPlugin();
        }
        return;
    }
    public void Destroy() {
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            DestroyNativeRendererPlugin();
        }
        return;
    }
    public IEnumerator Render(IntPtr nativeRenderCalback) {
        yield return new WaitForEndOfFrame();
        if (IntPtr.Zero != nativeRenderCalback) {
            GL.IssuePluginEvent(nativeRenderCalback, 1);
        }
        yield return null;
    }
}
}
