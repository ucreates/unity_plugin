//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
using UnityPlugin.Frontend.View;
using UnityEngine;
using System;
using System.Collections;
namespace UnityPlugin {
public class PluginFactory {
    public static T GetPlugin<T>() where T : BasePlugin, new() {
        Type type = typeof(T);
        return Activator.CreateInstance(type) as T;
    }
}
}
