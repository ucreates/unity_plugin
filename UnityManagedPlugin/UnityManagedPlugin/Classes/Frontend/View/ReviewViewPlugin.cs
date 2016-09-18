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
using UnityEditor;
namespace UnityManagedPlugin.Frontend.View {
public class ReviewViewPlugin {
    public string title {
        get;
        private set;
    }
    public void SetTitle(string title) {
        this.title = title;
    }
    public void Show() {
        EditorUtility.DisplayDialog(this.title, "", "いいえ、結構です", "このアプリを評価する");
    }
}
}