//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#import <Foundation/Foundation.h>
#import <UnityPlugin-Swift.h>
static WebViewPlugin* webViewPlugin;
static IndicatorViewPlugin* activityIndicatorViewPlugin;
static CameraViewPlugin* cameraViewPlugin;
extern "C" void showReviewViewPlugin(char* appStoreUrl) {
    NSString* url = [NSString stringWithCString: appStoreUrl encoding:NSUTF8StringEncoding];
    [ReviewViewPlugin show:url];
    return;
}
extern "C" void showWebViewPlugin(char* url, CGFloat left, CGFloat top, CGFloat right, CGFloat bottom) {
    if (nil != webViewPlugin) {
        return;
    }
    NSString* requestUrl = [NSString stringWithCString: url encoding:NSUTF8StringEncoding];
    webViewPlugin = [WebViewPlugin alloc];
    [webViewPlugin create:requestUrl left:left top:top right:right bottom:bottom];
    [webViewPlugin show];
    return;
}
extern "C" void hideWebViewPlugin() {
    if (nil == webViewPlugin) {
        return;
    }
    [webViewPlugin hide];
    [webViewPlugin destroy];
    webViewPlugin = nil;
    return;
}
extern "C" void showIndicatorViewPlugin() {
    if (nil != activityIndicatorViewPlugin) {
        return;
    }
    activityIndicatorViewPlugin = [IndicatorViewPlugin alloc];
    [activityIndicatorViewPlugin create];
    [activityIndicatorViewPlugin show];
    return;
}
extern "C" void hideIndicatorViewPlugin() {
    if (nil == activityIndicatorViewPlugin) {
        return;
    }
    [activityIndicatorViewPlugin hide];
    [activityIndicatorViewPlugin destroy];
    activityIndicatorViewPlugin = nil;
    return;
}
extern "C" void showCameraViewPlugin() {
    if (nil != cameraViewPlugin) {
        return;
    }
    cameraViewPlugin = [CameraViewPlugin alloc];
    [cameraViewPlugin create];
    [cameraViewPlugin show];
    return;
}
extern "C" const char* getTextureCameraViewPlugin() {
    if (nil == cameraViewPlugin) {
        return nil;
    }
    NSString* base64EncodedDataString = [cameraViewPlugin getTexture];
    if (nil == base64EncodedDataString) {
        return nil;
    }
    const char* base64EncodedDataUTF8String = [base64EncodedDataString UTF8String];
    unsigned long bufferSize = strlen(base64EncodedDataUTF8String) + 1;
    char* ret = (char*)malloc(bufferSize);
    strcpy(ret, base64EncodedDataUTF8String);
    return ret;
}
extern "C" void updateCameraViewPlugin(bool suspend) {
    if (nil == cameraViewPlugin) {
        return;
    }
    [cameraViewPlugin update:suspend];
    return;
}
extern "C" void hideCameraViewPlugin() {
    if (nil == cameraViewPlugin) {
        return;
    }
    [cameraViewPlugin hide];
    [cameraViewPlugin destroy];
    cameraViewPlugin = nil;
    return;
}
extern "C" void transitionViewControllerPlugin(int viewControllerId) {
    [TransitionPlugin execute:viewControllerId];
    return;
}
extern "C" bool getSwitchPreference(char* keyName) {
    NSString* requestKeyName = [NSString stringWithCString: keyName encoding:NSUTF8StringEncoding];
    return [PreferencePlugin getSwitchPreference:requestKeyName];
}