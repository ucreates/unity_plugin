//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin;
using UnityPlugin.Frontend.View;
using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;
public class NativeTextureAssetPluginEventHandler : MonoBehaviour {
    private List<NativeTextureAssetPluginBehaviour> behaviourList {
        get;
        set;
    }
    private void Start() {
        this.behaviourList = new List<NativeTextureAssetPluginBehaviour>();
        return;
    }
    public void OnCreate() {
        if (0 < this.behaviourList.Count) {
            return;
        }
        for (int i = 0; i < 10; i++) {
            GameObject cube = GameObject.CreatePrimitive(PrimitiveType.Cube);
            float x = UnityEngine.Random.Range(-3f, 3f);
            float y = UnityEngine.Random.Range(-3f, 3f);
            float z = UnityEngine.Random.Range(0f, 3f);
            cube.transform.localPosition = new Vector3(x, y, z);
            NativeTextureAssetPluginBehaviour behaviour = cube.AddComponent<NativeTextureAssetPluginBehaviour>();
            this.behaviourList.Add(behaviour);
        }
        return;
    }
    public void OnDestroy() {
        for (int i = 0; i < this.behaviourList.Count; i++) {
            NativeTextureAssetPluginBehaviour behaviour = this.behaviourList[i];
            behaviour.Destroy();
        }
        this.behaviourList.Clear();
        return;
    }
}
