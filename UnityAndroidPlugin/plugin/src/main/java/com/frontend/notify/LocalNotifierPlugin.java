// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
// ======================================================================
package com.frontend.notify;
public class LocalNotifierPlugin extends BaseNotifierPlugin {
    private static LocalNotifierPlugin instance = null;
    private LocalNotifierPlugin() {}
    public static LocalNotifierPlugin getInstance() {
        if (null == LocalNotifierPlugin.instance) {
            LocalNotifierPlugin.instance = new LocalNotifierPlugin();
        }
        return LocalNotifierPlugin.instance;
    }
}
