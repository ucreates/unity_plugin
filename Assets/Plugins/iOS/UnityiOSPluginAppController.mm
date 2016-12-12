//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#import "UnityAppController.h"
#import <UnityPlugin-Swift.h>
@interface UnityiOSPluginAppController : UnityAppController
@end
@implementation UnityiOSPluginAppController
- (void)preStartUnity {
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL ret = [super application:application didFinishLaunchingWithOptions:launchOptions];
    if (NO == ret) {
        return ret;
    }
    return [UnityiOSPluginAppDelegate application:application didFinishLaunchingWithOptions:launchOptions];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [UnityiOSPluginAppDelegate application:app url:url options:options];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [super applicationWillEnterForeground:application];
    return;
}
@end
IMPL_APP_CONTROLLER_SUBCLASS(UnityiOSPluginAppController)