using UnityEngine;
using UnityPlugin;
using UnityPlugin.Core.Environment;
using UnityEngine.UI;
using System.Collections;
public class VersionPluginEventHandler : MonoBehaviour {
    private VersionPlugin plugin {
        get;
        set;
    }
    // Use this for initialization
    void Start() {
        this.plugin = PluginFactory.GetPlugin<VersionPlugin>();
        return;
    }
    public void OnConfirm() {
        int version = this.plugin.GetVersion();
        string versionName = this.plugin.GetVersionName();
        GameObject versionTextObject = GameObject.Find("VersionText");
        Text versionText = versionTextObject.GetComponent<Text>();
        versionText.text = string.Format("version::{0}\nversionName::{1}", version, versionName);
        return;
    }
}
