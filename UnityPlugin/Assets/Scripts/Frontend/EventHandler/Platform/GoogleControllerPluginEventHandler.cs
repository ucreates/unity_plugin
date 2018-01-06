using UnityEngine;
using UnityPlugin;
using UnityPlugin.Frontend.Controller.Platform;
using System.Collections;
public class GoogleControllerPluginEventHandler : MonoBehaviour {
    private GoogleControllerPlugin plugin {
        get;
        set;
    }
    void Start() {
        this.plugin = PluginFactory.GetPlugin<GoogleControllerPlugin>();
    }
    public void OnLogIn() {
        this.plugin.LogIn();
        return;
    }
    public void OnLogOut() {
        this.plugin.LogOut();
        return;
    }
    public void OnRevokeAccess() {
        this.plugin.RevokeAccess();
        return;
    }
}
