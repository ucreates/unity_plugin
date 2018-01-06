using UnityEngine;
using UnityPlugin;
using UnityPlugin.Frontend.Component.Renderer;
using UnityPlugin.Frontend.Component.Asset;
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
public class NativeTextureAssetPluginBehaviour : MonoBehaviour {
    private const float UNIT_SCALE = 1f;
    private NativeTextureAssetPlugin nativeTextureAssetPlugin {
        get;
        set;
    }
    private NativeRendererPlugin nativeRendererPlugin {
        get;
        set;
    }
    // Use this for initialization
    private void Start() {
        this.nativeTextureAssetPlugin = PluginFactory.GetPlugin<NativeTextureAssetPlugin>();
        this.nativeRendererPlugin = PluginFactory.GetPlugin<NativeRendererPlugin>();
        this.nativeRendererPlugin.Create();
        //dummy download asset process from network.
        List<NativeTextureAssetPluginEntity> entityList = new List<NativeTextureAssetPluginEntity>();
        entityList.Add(new NativeTextureAssetPluginEntity("native_square_01.raw", 256, 256, false));
        entityList.Add(new NativeTextureAssetPluginEntity("native_square_02.raw", 256, 256, true));
        entityList.Add(new NativeTextureAssetPluginEntity("native_rectangle_01.raw", 512, 256, false));
        entityList.Add(new NativeTextureAssetPluginEntity("native_rectangle_02.raw", 512, 256, true));
        entityList.Add(new NativeTextureAssetPluginEntity("native_square_01.jpg", false));
        entityList.Add(new NativeTextureAssetPluginEntity("native_square_02.jpg", false));
        entityList.Add(new NativeTextureAssetPluginEntity("native_rectangle_01.jpg", false));
        entityList.Add(new NativeTextureAssetPluginEntity("native_rectangle_02.jpg", false));
        entityList.Add(new NativeTextureAssetPluginEntity("native_square_01.png", true));
        entityList.Add(new NativeTextureAssetPluginEntity("native_square_02.png", true));
        entityList.Add(new NativeTextureAssetPluginEntity("native_rectangle_01.png", true));
        entityList.Add(new NativeTextureAssetPluginEntity("native_rectangle_02.png", true));
        int index = UnityEngine.Random.Range(0, entityList.Count);
        NativeTextureAssetPluginEntity entity = entityList[index];
        string path = Path.Combine(Application.streamingAssetsPath, entity.fileName);
        byte[] data = null;
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            data = File.ReadAllBytes(path);
        } else if (RuntimePlatform.Android == Application.platform) {
            WWW client = new WWW(path);
            while (false == client.isDone) {}
            data = client.bytes;
        }
        path = Path.Combine(Application.temporaryCachePath, entity.fileName);
        if (false == File.Exists(path)) {
            File.WriteAllBytes(path, data);
        }
        //if you use png with alpha channel. then you must use tranpsarent support shader.
        Shader shader = Shader.Find("Unlit/Transparent Cutout");
        //load donwloaded texture by native texture plugin.
        this.nativeTextureAssetPlugin.Load(path, entity.width, entity.height, entity.enableAlphaChannel, this.gameObject, shader);
        entity.width = this.nativeTextureAssetPlugin.width;
        entity.height = this.nativeTextureAssetPlugin.height;
        entity.Reset();
        this.gameObject.transform.localScale = new Vector3(NativeTextureAssetPluginBehaviour.UNIT_SCALE * entity.widthRatio, NativeTextureAssetPluginBehaviour.UNIT_SCALE * entity.heightRatio, NativeTextureAssetPluginBehaviour.UNIT_SCALE);
    }
    // Update is called once per frame
    private void Update() {
        bool enable = this.nativeTextureAssetPlugin.Enable();
        if (false == enable) {
            UnityEngine.Object.Destroy(this.gameObject);
            UnityEngine.Object.Destroy(this);
            return;
        }
        this.StartCoroutine("OnRender");
    }
    public void Destroy() {
        this.nativeTextureAssetPlugin.Destroy();
        return;
    }
    private IEnumerator OnRender() {
        IntPtr nativeRenderCallback = this.nativeTextureAssetPlugin.GetNativeRenderCallback();
        yield return this.nativeRendererPlugin.Render(nativeRenderCallback);
    }
}
