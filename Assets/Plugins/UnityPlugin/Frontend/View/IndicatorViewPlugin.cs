using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
namespace UnityPlugin.Frontend.View {
public sealed class IndicatorViewPlugin : BasePlugin {
    [DllImport("__Internal")]
    private static extern void showIndicatorViewPlugin();
    [DllImport("__Internal")]
    private static extern void hideIndicatorViewPlugin();
    private AndroidJavaObject androidPlugin {
        get;
        set;
    }
    public IndicatorViewPlugin() {
        if (RuntimePlatform.Android == Application.platform) {
            this.androidPlugin = new AndroidJavaObject("com.frontend.view.IndicatorViewPlugin");
        }
    }
    public void Show() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            showIndicatorViewPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("show");
            }
        } else {
#if UNITY_STANDALONE
            UnityManagedPlugin.Frontend.View.IndicatorViewPlugin managedPlugin = new UnityManagedPlugin.Frontend.View.IndicatorViewPlugin();
            managedPlugin.Show();
#endif
        }
    }
    public void Hide() {
        if (RuntimePlatform.IPhonePlayer == Application.platform) {
            hideIndicatorViewPlugin();
        } else if (RuntimePlatform.Android == Application.platform) {
            if (null != this.androidPlugin) {
                this.androidPlugin.Call("hide");
            }
        }
    }
}
}