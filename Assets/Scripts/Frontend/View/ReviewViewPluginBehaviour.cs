﻿//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using UnityPlugin;
using UnityPlugin.Frontend.View;
public class ReviewViewPluginBehaviour : MonoBehaviour {
    void Start() {
        ReviewViewPlugin plugin = PluginFactory.GetPlugin<ReviewViewPlugin>();
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            plugin.Show("https://itunes.apple.com/jp/app/flappy-bird-original-version/id1086354043?mt=8");
        } else if (RuntimePlatform.Android == Application.platform) {
            plugin.Show("market://details?id=com.trifingger.flyhappybird");
        } else {
            plugin.Show("https://itunes.apple.com/jp/app/flappy-bird-original-version/id1086354043?mt=8");
        }
    }
}
