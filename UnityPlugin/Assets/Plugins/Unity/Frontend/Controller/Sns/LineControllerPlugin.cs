//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin.Core.Configure.Sns;
using UnityEngine;
using System;
using System.Runtime.InteropServices;
using System.IO;
using System.Collections;
namespace UnityPlugin.Frontend.Controller.Sns {
public sealed class LineControllerPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void transitionLineViewControllerPlugin(IntPtr imageData, int imageDataLength);
    public override int id {
        get {
            return 4;
        }
    }
    public LineControllerPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.core.scene.TransitionPlugin");
        }
    }
    public void Message(Texture2D texture) {
        byte[] imageData = texture.EncodeToPNG();
        this.Message(imageData);
        return;
    }
    public void Message(byte[] imageData) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            int heapSize = Marshal.SizeOf(imageData[0]) * imageData.Length;
            IntPtr imageDataPtr = Marshal.AllocHGlobal(heapSize);
            Marshal.Copy(imageData, 0, imageDataPtr, imageData.Length);
            transitionLineViewControllerPlugin(imageDataPtr, imageData.Length);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null == this.androidPlugin) {
                return;
            }
            string imagePath = Path.Combine(Application.temporaryCachePath, "image.png");
            File.WriteAllBytes(imagePath, imageData);
            this.androidPlugin.CallStatic("transitionLine", imagePath);
        }
        return;
    }
}
}
