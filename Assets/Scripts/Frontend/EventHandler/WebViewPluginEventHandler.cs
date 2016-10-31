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
using System.Collections;
using UnityPlugin;
using UnityPlugin.Frontend.View;
public class WebViewPluginEventHandler : MonoBehaviour {
    private WebViewPlugin plugin {
        get;
        set;
    }
    // Use this for initialization
    void Start() {
        this.plugin = PluginFactory.GetPlugin<WebViewPlugin>();
    }
    public void OnShow() {
        this.plugin.Show("http://www.yahoo.co.jp/", 100f, 100f, 100f, 100f);
    }
    public void OnHide() {
        this.plugin.Hide();
    }
}
