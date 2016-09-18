//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using System;
using UnityEngine;
namespace UnityManagedPlugin.Frontend.View {
public class WebViewPlugin {
    public void Show(string requestUrl) {
        Application.OpenURL(requestUrl);
    }
}
}
