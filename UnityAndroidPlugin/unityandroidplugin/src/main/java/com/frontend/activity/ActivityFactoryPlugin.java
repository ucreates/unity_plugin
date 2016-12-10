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
import com.frontend.activity.sns.FacebookActivityPlugin;
import com.frontend.activity.sns.TwitterActivityPlugin;
public class ActivityFactoryPlugin {
    public static Activity factoryMethod(int activityId) {
        Activity activity = null;
        switch (activityId) {
        case PreferenceActivityPlugin.ACTIVITY_ID:
            activity = new PreferenceActivityPlugin();
            break;
        case FacebookActivityPlugin.ACTIVITY_ID:
            activity = new FacebookActivityPlugin();
            break;
        case TwitterActivityPlugin.ACTIVITY_ID:
            activity = new TwitterActivityPlugin();
            break;
        default:
            break;
        }
        return activity;
    }
}
