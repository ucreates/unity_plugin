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
extern "C" void showReviewViewPlugin(char* appStoreUrl) {
    NSString* url = [NSString stringWithCString: appStoreUrl encoding:NSUTF8StringEncoding];
    [ReviewViewPlugin show:url];
}
extern "C" void showWebViewPlugin(char* url, CGFloat left, CGFloat top, CGFloat right, CGFloat bottom) {
    if (nil != webViewPlugin) {
        return;
    }
    NSString* requestUrl = [NSString stringWithCString: url encoding:NSUTF8StringEncoding];
    webViewPlugin = [WebViewPlugin alloc];
    [webViewPlugin create:requestUrl left:left top:top right:right bottom:bottom];
    [webViewPlugin show];
}
extern "C" void hideWebViewPlugin() {
    if (nil == webViewPlugin) {
        return;
    }
    [webViewPlugin hide];
    [webViewPlugin destroy];
    webViewPlugin = nil;
}