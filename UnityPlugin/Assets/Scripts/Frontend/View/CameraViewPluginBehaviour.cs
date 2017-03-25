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
using System;
using System.Collections;
using UnityPlugin;
using UnityPlugin.Frontend.View;
using UnityPlugin.Frontend.Component.Renderer;
public class CameraViewPluginBehaviour : MonoBehaviour {
    private const float ACCELERATION = 100f;
    private CameraViewPlugin cameraViewPlugin {
        get;
        set;
    }
    private NativeRendererPlugin nativeRendererPlugin {
        get;
        set;
    }
    private float aspectRatio {
        get;
        set;
    }
    private GameObject captureGameObject {
        get;
        set;
    }
    // Use this for initialization
    void Start() {
        this.cameraViewPlugin = PluginFactory.GetPlugin<CameraViewPlugin>();
        this.nativeRendererPlugin = PluginFactory.GetPlugin<NativeRendererPlugin>();
        float z = this.gameObject.transform.position.z + 2f;
        this.captureGameObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
        this.captureGameObject.name = "Capture";
        this.captureGameObject.transform.position = new Vector3(0f, 0f, z);
        this.captureGameObject.transform.localScale = Vector3.zero;
        return;
    }
    // Update is called once per frame
    private void Update() {
        float degree = Time.time * CameraViewPluginBehaviour.ACCELERATION;
        this.transform.rotation = Quaternion.Euler(degree, degree, degree);
        this.StartCoroutine("OnRender");
        return;
    }
    private IEnumerator OnRender() {
        IntPtr nativeRenderCallback = this.cameraViewPlugin.GetNativeRenderCallback();
        yield return this.nativeRendererPlugin.Render(nativeRenderCallback);
    }
    public void OnShow() {
        if (null == this.cameraViewPlugin) {
            return;
        }
        this.cameraViewPlugin.Show(this.gameObject.name, "OnShowCallback", "OnHideCallback");
        return;
    }
    public void OnShowCallback(string parameter) {
        string[] previewFrameSize = parameter.Split('x');
        if (CameraViewPlugin.VALID_CAPTURE_PREVIEW_SIZE_COUNT != previewFrameSize.Length) {
            return;
        }
        int width = Convert.ToInt32(previewFrameSize[0]);
        int height = Convert.ToInt32(previewFrameSize[1]);
        Texture2D texture = new Texture2D(width, height, TextureFormat.ARGB32, false);
        texture.hideFlags = HideFlags.HideAndDontSave;
        texture.filterMode = FilterMode.Bilinear;
        texture.wrapMode = TextureWrapMode.Clamp;
        texture.anisoLevel = 1;
        texture.Apply();
        IntPtr texturePtr = texture.GetNativeTexturePtr();
        int instanceId = this.captureGameObject.GetInstanceID();
        UnityEngine.Renderer[] rendererList = new UnityEngine.Renderer[2];
        rendererList[0] = this.captureGameObject.GetComponent<UnityEngine.Renderer>();
        rendererList[1] = this.GetComponent<UnityEngine.Renderer>();
        for (int i = 0; i < rendererList.Length; i++) {
            UnityEngine.Renderer renderer = rendererList[i];
            renderer.material.mainTexture = texture;
            renderer.material.mainTextureScale = new Vector2(1f, 1f);
        }
        this.cameraViewPlugin.SetTexture(instanceId, texturePtr);
        this.aspectRatio = (float)height / (float)width;
        this.OnOrientationChanged();
        this.nativeRendererPlugin.Create();
        return;
    }
    public void OnHide() {
        if (null == this.cameraViewPlugin) {
            return;
        }
        this.cameraViewPlugin.Hide();
        return;
    }
    public void OnHideCallback(string parameter) {
        this.nativeRendererPlugin.Destroy();
        //you should write scene transition process by UnityEngine.SceneManagement.SceneManager
        return;
    }
    public void OnPause(bool suspend) {
        if (null == this.cameraViewPlugin) {
            return;
        }
        this.cameraViewPlugin.Update(suspend);
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
        width = Mathf.Abs(width);
        height = Mathf.Abs(height);
        float sideWidth = width < height ? height : width;
        this.captureGameObject.transform.localScale = new Vector3(-1f * sideWidth, sideWidth * this.aspectRatio, 1f);
        Quaternion rotation = Quaternion.identity;
        if (RuntimePlatform.Android == Application.platform) {
            rotation = Quaternion.Euler(0f, 0f, 270f);
        }
        this.captureGameObject.transform.rotation = rotation;
        return;
    }
}
