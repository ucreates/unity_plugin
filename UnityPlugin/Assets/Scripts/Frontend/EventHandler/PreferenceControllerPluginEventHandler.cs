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
using UnityPlugin;
using UnityPlugin.Frontend.Controller;
using UnityPlugin.Core.Preference;
using System.Collections;
using System.Runtime.InteropServices;
public class PreferenceControllerPluginEventHandler : MonoBehaviour {
    private PreferenceControllerPlugin preferenceControllerPlugin {
        get;
        set;
    }
    private PreferencePlugin preferencePlugin {
        get;
        set;
    }
    void Start() {
        this.preferenceControllerPlugin = PluginFactory.GetPlugin<PreferenceControllerPlugin>();
        this.preferencePlugin = PluginFactory.GetPlugin<PreferencePlugin>();
    }
    void Update() {
        for (int i = 0; i < 5; i++) {
            int tag = i + 1;
            string keyName = "switch" + tag.ToString();
            bool ret = this.preferencePlugin.GetSwitchPreference(keyName);
            Debug.Log(keyName + ":" + ret);
        }
    }
    public void OnTransition() {
        this.preferenceControllerPlugin.Transition();
    }
}
