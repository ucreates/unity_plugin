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
public class TwitterControllerPluginEventHandler : MonoBehaviour {
    private TwitterControllerPlugin plugin {
        get;
        set;
    }
    void Start() {
        this.plugin = PluginFactory.GetPlugin<TwitterControllerPlugin>();
    }
    public void OnPost() {
        GameObject toggleObject = GameObject.Find("Canvas/UseTwiterCardToggle");
        Toggle toggle = toggleObject.GetComponent<Toggle>();
        bool useTwitterCard = toggle.isOn;
        string message = "message from unity";
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            message += " ios";
        } else if (RuntimePlatform.Android == Application.platform) {
            message += " android";
        }
        Texture2D texture = Resources.Load<Texture2D>("Textures/card");
        this.plugin.Tweet(message, texture, useTwitterCard);
    }
}
