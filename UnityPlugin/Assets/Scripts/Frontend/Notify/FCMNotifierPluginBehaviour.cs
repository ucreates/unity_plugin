//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin;
using UnityPlugin.Frontend.Notify;
using UnityEngine;
using System.Runtime.InteropServices;
using System.Collections;
public class FCMNotifierPluginBehaviour : MonoBehaviour {
    private FCMNotifierPlugin plugin {
        get;
        set;
    }
    void Start() {
        this.plugin = PluginFactory.GetPlugin<FCMNotifierPlugin>();
        this.plugin.Register();
        return;
    }
}
