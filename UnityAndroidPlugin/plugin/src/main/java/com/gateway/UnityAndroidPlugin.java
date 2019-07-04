//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.gateway;
public class UnityAndroidPlugin {
    static {
        System.loadLibrary("UnityNativePlugin");
    }
    public static native void SetPreviewFrameToNativeCameraTextureAssetPlugin(byte[] imageData, int bufferSize, int width, int height);
    public static void setPreviewFrameCameraViewPlugin(byte[] imageData, int bufferSize, int width, int height) {
        SetPreviewFrameToNativeCameraTextureAssetPlugin(imageData, bufferSize, width, height);
        return;
    }
}
