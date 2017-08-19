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
using System.Collections;
using System.Runtime.InteropServices;
using UnityPlugin;
using UnityPlugin.Frontend.Notify;
public class RemoteNotifierPluginBehaviour : MonoBehaviour {
    private RemoteNotifierPlugin plugin {
        get;
        set;
    }
    void Start() {
        this.plugin = PluginFactory.GetPlugin<RemoteNotifierPlugin>();
        this.plugin.Register();
        return;
    }
}
