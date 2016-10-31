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
using System.Runtime.InteropServices;
using UnityPlugin;
using UnityPlugin.Frontend.View;
public class IndicatorViewPluginEventHandler : MonoBehaviour {
    private IndicatorViewPlugin plugin {
        get;
        set;
    }
    void Start() {
        this.plugin = PluginFactory.GetPlugin<IndicatorViewPlugin>();
    }
    public void OnShow() {
        this.StartCoroutine(this.OnWait());
    }
    IEnumerator OnWait() {
        this.plugin.Show();
        yield return new WaitForSeconds(3f);
        this.plugin.Hide();
    }
}
