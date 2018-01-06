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
using System;
using System.Runtime.InteropServices;
namespace UnityPlugin.Frontend.View {
public sealed class CameraViewPlugin : BasePlugin {
    public const int VALID_CAPTURE_PREVIEW_SIZE_COUNT = 2;
    [DllImport("__Internal")]
    private static extern void showCameraViewPlugin(string gameObjectName, string onShowCallbackName, string onHideCallbackName);
    [DllImport("__Internal")]
    private static extern void updateCameraViewPlugin(bool suspend);
    [DllImport("__Internal")]
    private static extern void hideCameraViewPlugin();
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern void CreatePreviewFrameNativeCameraTextureAssetPlugin();
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern void DestroyPreviewFrameNativeCameraTextureAssetPlugin();
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern void SetTextureIdToNativeCameraTextureAssetPlugin(int instanceId, System.IntPtr unityNativeTexturePtr);
#if UNITY_IPHONE
    [DllImport("__Internal")]
#else
    [DllImport("UnityNativePlugin")]
#endif
    private static extern IntPtr GetRenderCameraPreviewFrameCallbackByNativeRendererPlugin();
    public CameraViewPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.view.CameraViewPlugin");
        }
        return;
    }
    public void Show(string gameObjectName, string onShowCallbackName, string onHideCallbackName) {
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            Screen.orientation = ScreenOrientation.Portrait;
            CreatePreviewFrameNativeCameraTextureAssetPlugin();
            if (RuntimePlatform.IPhonePlayer == Application.platform) {
                showCameraViewPlugin(gameObjectName, onShowCallbackName, onHideCallbackName);
            } else if (RuntimePlatform.Android == Application.platform) {
                if (null != this.androidPlugin) {
                    this.androidPlugin.Call("create", gameObjectName, onShowCallbackName, onHideCallbackName);
                }
            }
        }
        return;
    }
    public void Hide() {
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            Screen.orientation = ScreenOrientation.AutoRotation;
            if (RuntimePlatform.IPhonePlayer == Application.platform) {
                hideCameraViewPlugin();
            } else if (RuntimePlatform.Android == Application.platform) {
                if (null != this.androidPlugin) {
                    this.androidPlugin.Call("destroy");
                }
            }
            DestroyPreviewFrameNativeCameraTextureAssetPlugin();
        }
        return;
    }
    public void Update(bool suspend) {
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            if (RuntimePlatform.IPhonePlayer == Application.platform) {
                updateCameraViewPlugin(suspend);
            } else if (RuntimePlatform.Android == Application.platform) {
                if (null != this.androidPlugin) {
                    this.androidPlugin.Call("update", suspend);
                }
                if (false != suspend) {
                    DestroyPreviewFrameNativeCameraTextureAssetPlugin();
                } else {
                    CreatePreviewFrameNativeCameraTextureAssetPlugin();
                }
            }
        }
        return;
    }
    public void SetTexture(int instanceId, IntPtr texturePtr) {
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            SetTextureIdToNativeCameraTextureAssetPlugin(instanceId, texturePtr);
        }
        return;
    }
    public IntPtr GetNativeRenderCallback() {
        IntPtr ret = IntPtr.Zero;
        if (RuntimePlatform.IPhonePlayer == Application.platform || RuntimePlatform.Android == Application.platform) {
            ret =  GetRenderCameraPreviewFrameCallbackByNativeRendererPlugin();
        }
        return ret;
    }
}
}
