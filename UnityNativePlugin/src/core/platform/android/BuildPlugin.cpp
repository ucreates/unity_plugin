//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include <stdlib.h>
#include "BuildPlugin.h"
#include "PlatformBase.h"
#if UNITY_ANDROID
#include <sys/system_properties.h>
#endif
#if UNITY_IPHONE
int BuildPlugin::getVersion() { return 0; }
#endif
#if UNITY_ANDROID
int BuildPlugin::getVersion() {
    char sdkVersion[100];
    __system_property_get("ro.build.version.sdk", sdkVersion);
    return atoi(sdkVersion);
}
#endif
