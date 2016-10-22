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
    private const int ORIENTATION_AUTO = 0;
    private const int ORIENTATION_HORIZONTAL = 1;
    private const int ORIENTATION_PORTRATE = 2;
    [DllImport("__Internal")]
    private static extern void showCameraViewPlugin();
    [DllImport("__Internal")]
    private static extern string getTextureCameraViewPlugin();
    [DllImport("__Internal")]
    private static extern void updateCameraViewPlugin(bool suspend);
    [DllImport("__Internal")]
    private static extern void hideCameraViewPlugin();
    private AndroidJavaObject androidPlugin {
        get;
        set;
    }
    private bool enablePlugin {
        get;
        set;
    }
    public CameraViewPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.view.CameraViewPlugin");
        }
        this.enablePlugin = false;
        return;
    }
    public void Show() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            showCameraViewPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("create");
                this.androidPlugin.Call("show");
            }
        }
        this.enablePlugin = true;
        return;
    }
    public void Hide() {
        this.enablePlugin = false;
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            hideCameraViewPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("hide");
                this.androidPlugin.Call("destroy");
            }
        }
        return;
    }
    public void Update(bool suspend) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            updateCameraViewPlugin(suspend);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("update", suspend);
            }
        }
        this.enablePlugin = !suspend;
        return;
    }
    public Texture2D GetTexture() {
        if (false == this.enablePlugin) {
            return null;
        }
        byte[] data = null;
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            string base64EncodedUTF8Data = getTextureCameraViewPlugin();
            if (false != string.IsNullOrEmpty(base64EncodedUTF8Data)) {
                return null;
            }
            data = Convert.FromBase64String(base64EncodedUTF8Data);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null == this.androidPlugin) {
                return null;
            }
            AndroidJavaObject androidJavaObject = this.androidPlugin.Call<AndroidJavaObject>("getTexture");
            if (null == androidJavaObject) {
                return null;
            }
            IntPtr rawObject = androidJavaObject.GetRawObject();
            data = AndroidJNIHelper.ConvertFromJNIArray<byte[]>(rawObject);
        }
        if (null == data) {
            return null;
        }
        Texture2D texture = new Texture2D(Screen.width, Screen.height, TextureFormat.ARGB32, false);
        texture.LoadImage(data);
        texture.hideFlags = HideFlags.HideAndDontSave;
        texture.filterMode = FilterMode.Bilinear;
        texture.wrapMode = TextureWrapMode.Clamp;
        texture.anisoLevel = 1;
        texture.Apply();
        return texture;
    }
}
}