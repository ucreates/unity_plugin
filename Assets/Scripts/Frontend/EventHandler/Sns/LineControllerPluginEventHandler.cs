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
using UnityEngine.UI;
using UnityPlugin;
using UnityPlugin.Frontend.Controller.Sns;
using System.Collections;
using System.Runtime.InteropServices;
public class LineControllerPluginEventHandler : MonoBehaviour {
    private LineControllerPlugin plugin {
        get;
        set;
    }
    void Start() {
        this.plugin = PluginFactory.GetPlugin<LineControllerPlugin>();
    }
    public void OnMessage() {
        Texture2D texture = Resources.Load<Texture2D>("Textures/line_card");
        this.plugin.Message(texture);
    }
}
