﻿//======================================================================
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
public class LocalNotifierPluginBehaviour : MonoBehaviour {
    private LocalNotifierPlugin plugin {
        get;
        set;
    }
    private void Start() {
        this.plugin = PluginFactory.GetPlugin<LocalNotifierPlugin>();
        this.plugin.Register();
        return;
    }
    public void OnNotify() {
        this.plugin.Notify("PushNotification(Local)", "body", 5);
        return;
    }
}