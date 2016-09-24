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
public class IndicatorViewPlugin {
    public void Show() {
        EditorUtility.DisplayDialog("インジゲータ", "", "OK", "");
    }
}
}
