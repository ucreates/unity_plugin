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
using UnityEditor;
namespace UnityManagedPlugin.Frontend.Controller {
public class PreferenceControllerPlugin {
    public void Transition() {
        EditorUtility.DisplayDialog("設定画面", "", "OK", "");
    }
}
}
