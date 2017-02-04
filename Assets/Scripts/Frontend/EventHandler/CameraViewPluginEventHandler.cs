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
using System.Collections;
using UnityPlugin;
using UnityPlugin.Frontend.View;
public class CameraViewPluginEventHandler : MonoBehaviour {
    private CameraViewPluginBehaviour client {
        get;
        set;
    }
    void Start() {
        GameObject clientGameObject = GameObject.Find("Client");
        if (null != clientGameObject) {
            this.client = clientGameObject.GetComponent<CameraViewPluginBehaviour>();
        }
    }
    void OnApplicationPause(bool pauseStatus) {
        if (null == this.client) {
            return;
        }
        this.client.OnPause(pauseStatus);
    }
    public void OnShow() {
        if (null == this.client) {
            return;
        }
        this.client.OnShow();
    }
    public void OnHide() {
        if (null == this.client) {
            return;
        }
        this.client.OnHide();
    }
}
