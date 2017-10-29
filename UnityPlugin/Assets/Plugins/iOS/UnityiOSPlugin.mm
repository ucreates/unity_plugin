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
#import "UnityiOSPlugin.h"
#import <UnityPlugin-Swift.h>
#import "UnityNativePlugin.h"
static WebViewPlugin* webViewPlugin;
static IndicatorViewPlugin* activityIndicatorViewPlugin;
static CameraViewPlugin* cameraViewPlugin;
extern "C" void showReviewViewPlugin(char* appStoreUrl) {
    NSString* url = [NSString stringWithCString:appStoreUrl encoding:NSUTF8StringEncoding];
    [ReviewViewPlugin show:url];
    return;
}
extern "C" void showWebViewPlugin(char* url, float left, float top, float right, float bottom) {
    if (nil != webViewPlugin) {
        return;
    }
    NSString* requestUrl = [NSString stringWithCString:url encoding:NSUTF8StringEncoding];
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
extern "C" void showCameraViewPlugin(char* gameObjectName, char* onShowCallbackMethodName, char* onHideCallbackMethodName) {
    if (nil != cameraViewPlugin) {
        return;
    }
    NSString* unityGameObjectName = [NSString stringWithCString:gameObjectName encoding:NSUTF8StringEncoding];
    NSString* unityOnShowCallbackMethodName = [NSString stringWithCString:onShowCallbackMethodName encoding:NSUTF8StringEncoding];
    NSString* unityOnHideCallbackMethodName = [NSString stringWithCString:onHideCallbackMethodName encoding:NSUTF8StringEncoding];
    cameraViewPlugin = [CameraViewPlugin alloc];
    [cameraViewPlugin createWithGameObjectName:unityGameObjectName onShowCallbackName:unityOnShowCallbackMethodName onHideCallbackName:unityOnHideCallbackMethodName];
    return;
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
    [cameraViewPlugin destroy];
    cameraViewPlugin = nil;
    return;
}
extern "C" void fillPathPlugin(char* dataPath, char* persistentDataPath, char* streamingAssetsPath, char* temporaryCachePath) {
    NSString* unityDataPath = [NSString stringWithCString:dataPath encoding:NSUTF8StringEncoding];
    NSString* unityPersistentDataPath = [NSString stringWithCString:persistentDataPath encoding:NSUTF8StringEncoding];
    NSString* unityStreamingAssetsPath = [NSString stringWithCString:streamingAssetsPath encoding:NSUTF8StringEncoding];
    NSString* unityTemporaryCachePath = [NSString stringWithCString:temporaryCachePath encoding:NSUTF8StringEncoding];
    PathPlugin* pathPlugin = [PathPlugin getInstance];
    [pathPlugin fill:unityDataPath persistentDataPath:unityPersistentDataPath streamingAssetsPath:unityStreamingAssetsPath temporaryCachePath:unityTemporaryCachePath];
    return;
}
extern "C" void dumpPathPlugin() {
    PathPlugin* pathPlugin = [PathPlugin getInstance];
    [pathPlugin dump];
    return;
}
extern "C" void showAlertViewPlugin(char* message) {
    NSString* encodedMessage = [NSString stringWithCString:message encoding:NSUTF8StringEncoding];
    [AlertViewPlugin show:encodedMessage];
    return;
}
extern "C" void transitionViewControllerPlugin(int viewControllerId) {
    [TransitionPlugin execute:viewControllerId];
    return;
}
extern "C" void transitionTwitterViewControllerPlugin(char* message, unsigned char* imageData, int imageDataLength, bool useTwitterCard) {
    NSString* unityMassage = [NSString stringWithCString:message encoding:NSUTF8StringEncoding];
    NSData* unityImageData = [NSData dataWithBytes:(const void*)imageData length:imageDataLength];
    TwitterViewControllerPlugin* viewController = (TwitterViewControllerPlugin*)[ViewControllerFactoryPlugin factoryMethod:[TwitterViewControllerPlugin VIEWCONTROLLER_ID]];
    [viewController setParameter:unityMassage postImageData:unityImageData enableTwitterCard:useTwitterCard];
    UIViewController* fromViewController = [ViewControllerPlugin getInstance];
    [fromViewController presentViewController:viewController animated:true completion:nil];
    return;
}
extern "C" void transitionFacebookViewControllerPlugin(unsigned char* imageData, int imageDataLength) {
    NSData* unityImageData = [NSData dataWithBytes:(const void*)imageData length:imageDataLength];
    FacebookViewControllerPlugin* viewController = (FacebookViewControllerPlugin*)[ViewControllerFactoryPlugin factoryMethod:[FacebookViewControllerPlugin VIEWCONTROLLER_ID]];
    [viewController setParameterWithPostImageData:unityImageData];
    UIViewController* fromViewController = [ViewControllerPlugin getInstance];
    [fromViewController presentViewController:viewController animated:true completion:nil];
    return;
}
extern "C" void transitionLineViewControllerPlugin(unsigned char* imageData, int imageDataLength) {
    NSData* unityImageData = [NSData dataWithBytes:(const void*)imageData length:imageDataLength];
    LineViewControllerPlugin* viewController = (LineViewControllerPlugin*)[ViewControllerFactoryPlugin factoryMethod:[LineViewControllerPlugin VIEWCONTROLLER_ID]];
    [viewController setParameterWithPostImageData:unityImageData];
    UIViewController* fromViewController = [ViewControllerPlugin getInstance];
    [fromViewController presentViewController:viewController animated:true completion:nil];
    return;
}
extern "C" void transitionPaymentViewControllerPlugin(char* paymentUserId, char* paymentProductId) {
    NSString* unityUserId = [NSString stringWithCString:paymentUserId encoding:NSUTF8StringEncoding];
    NSString* unityProductId = [NSString stringWithCString:paymentProductId encoding:NSUTF8StringEncoding];
    PaymentViewControllerPlugin* viewController = (PaymentViewControllerPlugin*)[ViewControllerFactoryPlugin factoryMethod:[PaymentViewControllerPlugin VIEWCONTROLLER_ID]];
    [viewController setParameter:unityUserId unityProductId:unityProductId];
    UIViewController* fromViewController = [ViewControllerPlugin getInstance];
    [fromViewController presentViewController:viewController animated:true completion:nil];
    return;
}
extern "C" void transitionGoogleViewControllerPlugin(char* clientId, int mode) {
    NSString* unityClientId = [NSString stringWithCString:clientId encoding:NSUTF8StringEncoding];
    GoogleViewControllerPlugin* viewController = (GoogleViewControllerPlugin*)[ViewControllerFactoryPlugin factoryMethod:[GoogleViewControllerPlugin VIEWCONTROLLER_ID]];
    [viewController setParameterWithClientId:unityClientId];
    UIViewController* fromViewController = [ViewControllerPlugin getInstance];
    [fromViewController presentViewController:viewController animated:true completion:nil];
    return;
}
extern "C" bool getSwitchPreferencePlugin(char* keyName) {
    NSString* requestKeyName = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
    return [PreferencePlugin getSwitchPreference:requestKeyName];
}
extern "C" void registerLocalNotifier() {
    LocalNotifierPlugin* localNotifierPlugin = [LocalNotifierPlugin getInstance];
    [localNotifierPlugin register];
    return;
}
extern "C" void registerRemoteNotifier() {
    RemoteNotifierPlugin* remoteNotifierPlugin = [RemoteNotifierPlugin getInstance];
    [remoteNotifierPlugin register];
    return;
}
extern "C" void registerFCMNotifier() {
    FCMNotifierPlugin* fcmNotifierPlugin = [FCMNotifierPlugin getInstance];
    [fcmNotifierPlugin register];
    return;
}
extern "C" void localNotify(char* title, char* body, double timeInterval) {
    NSString* unityTitle = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
    NSString* unityBody = [NSString stringWithCString:body encoding:NSUTF8StringEncoding];
    LocalNotifierPlugin* localNotifierPlugin = [LocalNotifierPlugin getInstance];
    [localNotifierPlugin noitfyWithTitle:unityTitle body:unityBody interval:timeInterval];
    return;
}
void setPreviewFrameCameraViewPlugin(unsigned char* imageData, int width, int height) {
    SetPreviewFrameToNativeCameraTextureAssetPlugin(imageData, width, height);
    return;
}
