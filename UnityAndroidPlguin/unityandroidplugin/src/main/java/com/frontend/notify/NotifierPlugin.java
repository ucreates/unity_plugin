//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.notify;
import com.unity3d.player.UnityPlayer;
public class NotifierPlugin {
    public static void notify(String gameObjectName, String method, String msg) {
        UnityPlayer.UnitySendMessage(gameObjectName, method, msg);
        return;
    }
}
