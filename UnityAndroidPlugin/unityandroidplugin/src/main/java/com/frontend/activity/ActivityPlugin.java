//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
package com.frontend.activity;
import android.app.Activity;
import com.unity3d.player.UnityPlayer;
public class ActivityPlugin {
    public static final int ACTIVITY_ID = 1;
    public static Activity getInstance() {
        return UnityPlayer.currentActivity;
    }
}
