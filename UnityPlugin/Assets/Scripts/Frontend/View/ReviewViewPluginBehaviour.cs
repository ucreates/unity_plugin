//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin;
using UnityPlugin.Frontend.View;
using UnityEngine;
using System.Runtime.InteropServices;
using System.Collections;
public class ReviewViewPluginBehaviour : MonoBehaviour {
    void Start() {
        ReviewViewPlugin plugin = PluginFactory.GetPlugin<ReviewViewPlugin>();
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            plugin.Show("https://itunes.apple.com/jp/app/flappy-bird-original-version/id1086354043?mt=8", "Unityプラグインを評価しましよう", "はい" , "いいえ");
        } else if (RuntimePlatform.Android == Application.platform) {
            plugin.Show("market://details?id=com.trifingger.flyhappybird", "Unityプラグインを評価しましよう", "はい" , "いいえ");
        } else {
            plugin.Show("https://itunes.apple.com/jp/app/flappy-bird-original-version/id1086354043?mt=8", "Unityプラグインを評価しましよう", "はい" , "いいえ");
        }
    }
}
