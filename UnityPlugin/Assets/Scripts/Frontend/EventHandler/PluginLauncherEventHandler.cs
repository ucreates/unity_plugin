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
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using System.Collections;
public class PluginLauncherEventHandler : MonoBehaviour {
    public void OnGoButtonClick() {
        GameObject dropDownObject = GameObject.Find("Canvas/PluginDropdown");
        Dropdown dropDown = dropDownObject.GetComponent<Dropdown>();
        string sceneName = dropDown.captionText.text + "Viewer";
        SceneManager.LoadScene(sceneName);
    }
}
