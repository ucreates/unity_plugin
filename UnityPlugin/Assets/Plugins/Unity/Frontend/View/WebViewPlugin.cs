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
namespace UnityPlugin.Frontend.View {
public sealed class WebViewPlugin : BasePlugin {
#if UNITY_IOS
    [DllImport("__Internal")]
    private static extern void showWebViewPlugin(string requestUrl, float left, float top, float right, float bottom, float baseWidth, float baseHeight);
    [DllImport("__Internal")]
    private static extern void hideWebViewPlugin();
#endif
    public Texture2D marginDebugTexture {
        get;
        set;
    }
    public WebViewPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.view.WebViewPlugin");
        }
#if UNITY_EDITOR
        Texture2D texure = new Texture2D(4, 4, TextureFormat.ARGB32, false);
        for (int y = 0; y < texure.height; y++) {
            for (int x = 0; x < texure.width; x++) {
                Color color = new Color(1.0f, 0.0f, 0.0f, 0.5f);
                texure.SetPixel(x, y, color);
            }
        }
        texure.Apply();
        this.marginDebugTexture = texure;
#endif
    }
    public void Show(string requestUrl, float left, float top, float right, float bottom, float baseWidth, float baseHeight) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
#if UNITY_IOS
            showWebViewPlugin(requestUrl, left, top, right, bottom, baseWidth, baseHeight);
#endif
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("create", requestUrl, (int)left, (int)top, (int)right, (int)bottom, (int)baseWidth, (int)baseHeight);
                this.androidPlugin.Call("show");
            }
        }
    }
    public void Hide() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
#if UNITY_IOS
            hideWebViewPlugin();
#endif
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("hide");
                this.androidPlugin.Call("destroy");
            }
        }
#if UNITY_EDITOR
        this.marginDebugTexture = null;
#endif
    }
    public void DrawWebViewAreaGizmo(Rect areaRect) {
#if UNITY_EDITOR
        GUI.DrawTexture(areaRect, this.marginDebugTexture);
#endif
        return;
    }
}
}
