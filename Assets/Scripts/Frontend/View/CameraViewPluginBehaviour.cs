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
public class CameraViewPluginBehaviour : MonoBehaviour {
    private const float ACCELERATION = 100f;
    private CameraViewPlugin plugin {
        get;
        set;
    }
    private GameObject captureGameObject {
        get;
        set;
    }
    // Use this for initialization
    void Start() {
        this.captureGameObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
        this.captureGameObject.name = "Capture";
        this.plugin = PluginFactory.GetPlugin<CameraViewPlugin>();
        this.OnOrientationChanged();
        return;
    }
    void Update() {
        if (null == this.plugin) {
            return;
        }
        float degree = Time.time * CameraViewPluginBehaviour.ACCELERATION;
        this.transform.rotation = Quaternion.Euler(degree, degree, degree);
        MeshRenderer renderer = this.captureGameObject.GetComponent<MeshRenderer>();
        Texture2D texture = this.plugin.GetTexture();
        if (null == texture) {
            return;
        }
        UnityEngine.Object.DestroyImmediate(renderer.material.mainTexture);
        renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
        renderer.receiveShadows = false;
        renderer.material.mainTexture = texture;
        return;
    }
    public void OnPause(bool suspend) {
        if (null == this.plugin) {
            return;
        }
        this.plugin.Update(suspend);
        return;
    }
    public void OnShow() {
        if (null == this.plugin) {
            return;
        }
        this.plugin.Show();
        return;
    }
    public void OnHide() {
        if (null == this.plugin) {
            return;
        }
        this.plugin.Hide();
        MeshRenderer renderer = this.captureGameObject.GetComponent<MeshRenderer>();
        UnityEngine.Object.DestroyImmediate(renderer.material.mainTexture);
        return;
    }
    public void OnOrientationChanged() {
        if (null == this.captureGameObject) {
            return;
        }
        float distance = this.captureGameObject.transform.position.z - Camera.main.transform.position.z;
        distance = Mathf.Abs(distance);
        Vector3 viewPortPoint = new Vector3(0, 0, distance);
        Vector3 worldLeftUpPoint = Camera.main.ViewportToWorldPoint(viewPortPoint);
        viewPortPoint.Set(1, 1, distance);
        Vector3 worldRightDownPoint = Camera.main.ViewportToWorldPoint(viewPortPoint);
        float width = worldRightDownPoint.x - worldLeftUpPoint.x;
        float height = worldRightDownPoint.y - worldLeftUpPoint.y;
        float tmpsize = 0f;
        width = Mathf.Abs(width);
        height = Mathf.Abs(height);
        float rotate = 0f;
        ScreenOrientation oientation = Screen.orientation;
        switch (oientation) {
        case ScreenOrientation.Portrait:
            rotate = 90f;
            tmpsize = width;
            width = height;
            height = tmpsize;
            break;
        case ScreenOrientation.PortraitUpsideDown:
            rotate = 270f;
            tmpsize = width;
            width = height;
            height = tmpsize;
            break;
        case ScreenOrientation.LandscapeRight:
            rotate = 0f;
            break;
        case ScreenOrientation.LandscapeLeft:
            rotate = 180f;
            break;
        default:
            break;
        }
        this.captureGameObject.transform.position = new Vector3(0f, 0f, 2f);
        this.captureGameObject.transform.localScale = new Vector3(width, height, 1f);
        this.captureGameObject.transform.rotation = Quaternion.Euler(0f, 0f, rotate);
        return;
    }
}
