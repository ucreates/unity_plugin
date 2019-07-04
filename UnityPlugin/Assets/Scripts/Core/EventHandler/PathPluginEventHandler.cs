using UnityEngine;
using UnityPlugin;
using UnityPlugin.Core.IO;
using System.Collections;
public class PathPluginEventHandler : MonoBehaviour {
    private PathPlugin plugin {
        get;
        set;
    }
    // Use this for initialization
    void Start() {
        this.plugin = PluginFactory.GetPlugin<PathPlugin>();
        this.plugin.Fill();
        return;
    }
    public void OnDump() {
        Debug.Log("dataPath in Unity::" + Application.dataPath);
        Debug.Log("persistentDataPath in Unity::" + Application.persistentDataPath);
        Debug.Log("streamingAssetsPath in Unity::" + Application.streamingAssetsPath);
        Debug.Log("temporaryCachePath in Unity::" + Application.temporaryCachePath);
        this.plugin.Dump();
        return;
    }
}
