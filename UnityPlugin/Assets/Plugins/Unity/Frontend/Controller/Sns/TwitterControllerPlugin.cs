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
public sealed class TwitterControllerPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void transitionTwitterViewControllerPlugin(string message, IntPtr imageData, int imageDataLength, bool enableTwitterCard);
    public override int id {
        get {
            return 3;
        }
    }
    public TwitterControllerPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.core.scene.TransitionPlugin");
        }
    }
    public void Tweet(string message, Texture2D texture, bool enableTwitterCard = false) {
        byte[] imageData = texture.EncodeToPNG();
        this.Tweet(message, imageData, enableTwitterCard);
        return;
    }
    public void Tweet(string message, byte[] imageData, bool enableTwitterCard = false) {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            int heapSize = Marshal.SizeOf(imageData[0]) * imageData.Length;
            IntPtr imageDataPtr = Marshal.AllocHGlobal(heapSize);
            Marshal.Copy(imageData, 0, imageDataPtr, imageData.Length);
            transitionTwitterViewControllerPlugin(message, imageDataPtr, imageData.Length, enableTwitterCard);
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null == this.androidPlugin) {
                return;
            }
            string imagePath = Path.Combine(Application.temporaryCachePath, "image.png");
            File.WriteAllBytes(imagePath, imageData);
            this.androidPlugin.CallStatic("transitionTwitter", message, imagePath, TwitterConfigurePlugin.CONSUMER_KEY, TwitterConfigurePlugin.CONSUMER_SEACRET, enableTwitterCard);
        }
        return;
    }
}
}
