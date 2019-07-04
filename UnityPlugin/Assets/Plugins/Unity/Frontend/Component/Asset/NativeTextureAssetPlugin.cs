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
using System.IO;
using System.Collections;
namespace UnityPlugin.Frontend.Component.Asset {
public class NativeTextureAssetPlugin : BasePlugin {
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern void LoadTextureByNativeTextureAssetPlugin(int instanceId, string textureAssetPath, int width = 0, int height = 0, bool useAlphaChannel = false);
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern void DestroyTextureByNativeTextureAssetPlugin(int instanceId);
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern int GetTextureWidthByNativeTextureAssetPlugin(int instanceId);
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern int GetTextureHeightByNativeTextureAssetPlugin(int instanceId);
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern bool EnableAlphaChannelByNativeTextureAssetPlugin(int instanceId);
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern void SetTextureIdToNativeTextureAssetPlugin(int instanceId, System.IntPtr unityNativeTexturePtr);
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern IntPtr GetRenderTextureCallbackByNativeRendererPlugin();
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern bool EnableTextureByNativeTextureAssetPlugin(int instanceId);
    public int width {
        get;
        set;
    }
    public int height {
        get;
        set;
    }
    private int instanceId {
        get;
        set;
    }
    public NativeTextureAssetPlugin() {
        this.instanceId = 0;
    }
    public void Load(string textureAssetPath, int width, int height, bool useAlphaChannel, GameObject renderGameObject, Shader shader = null) {
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            if (null == renderGameObject) {
                return;
            }
            UnityEngine.Renderer renderer = renderGameObject.GetComponent<UnityEngine.Renderer>();
            if (null == renderer) {
                return;
            }
            this.instanceId = renderGameObject.GetInstanceID();
            LoadTextureByNativeTextureAssetPlugin(this.instanceId, textureAssetPath, width, height, useAlphaChannel);
            this.width = GetTextureWidthByNativeTextureAssetPlugin(this.instanceId);
            this.height = GetTextureHeightByNativeTextureAssetPlugin(this.instanceId);
            bool enableAlphaChannel = EnableAlphaChannelByNativeTextureAssetPlugin(this.instanceId);
            TextureFormat format = TextureFormat.RGB24;
            if (false != enableAlphaChannel) {
                format = TextureFormat.ARGB32;
            }
            string extension = Path.GetExtension(textureAssetPath);
            Texture2D texture = new Texture2D(this.width, this.height, format, false);
            texture.filterMode = FilterMode.Point;
            texture.Apply();
            if (false != extension.Equals(".png")) {
                if (null == shader) {
                    this.Destroy();
                    return;
                }
                Material material = new Material(shader);
                material.mainTexture = texture;
                renderer.material = material;
            } else {
                renderer.material.mainTexture = texture;
            }
            renderer.material.mainTextureScale = new Vector2(-1f, 1f);
            IntPtr texturePtr = texture.GetNativeTexturePtr();
            SetTextureIdToNativeTextureAssetPlugin(this.instanceId, texturePtr);
        }
        return;
    }
    public void Destroy() {
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            DestroyTextureByNativeTextureAssetPlugin(this.instanceId);
        }
        return;
    }
    public bool Enable() {
        bool ret = true;
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            ret =  EnableTextureByNativeTextureAssetPlugin(this.instanceId);
        }
        return ret;
    }
    public IntPtr GetNativeRenderCallback() {
        IntPtr ret = IntPtr.Zero;
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            ret =  GetRenderTextureCallbackByNativeRendererPlugin();
        }
        return ret;
    }
}
}
