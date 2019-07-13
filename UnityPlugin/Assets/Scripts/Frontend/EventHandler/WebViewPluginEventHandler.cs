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
public class WebViewPluginEventHandler : MonoBehaviour {
    public Image webViewAreaImage;
    private WebViewPlugin plugin {
        get;
        set;
    }
    public Rect screenRect {
        get;
        set;
    }
    // Use this for initialization
    void Start() {
        this.plugin = PluginFactory.GetPlugin<WebViewPlugin>();
        this.screenRect = new Rect();
    }
    public void OnShow() {
        Vector3[] corners = new Vector3[ 4 ];
        this.webViewAreaImage.rectTransform.GetWorldCorners(corners);
        Vector2 luScreenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, corners[1]);
        Vector2 rdScreenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, corners[3]);
        int leftMargin = (int)luScreenPoint.x;
        int rightMargin = (int)(UnityEngine.Screen.width - rdScreenPoint.x);
        int topMargin = (int)(UnityEngine.Screen.height - luScreenPoint.y);
        int bottomMargin = (int)rdScreenPoint.y;
        this.plugin.Show("http://www.yahoo.co.jp/", leftMargin, topMargin, rightMargin, bottomMargin, UnityEngine.Screen.width, UnityEngine.Screen.height);
        Rect rect = new Rect();
        rect.x = leftMargin;
        rect.width = Screen.width - leftMargin - rightMargin;
        rect.y = topMargin;
        rect.height = Screen.height - topMargin - bottomMargin;
        this.screenRect = rect;
        return;
    }
    public void OnHide() {
        this.plugin.Hide();
        return;
    }
    private void OnGUI() {
        this.plugin.DrawWebViewAreaGizmo(this.screenRect);
        return;
    }
}
