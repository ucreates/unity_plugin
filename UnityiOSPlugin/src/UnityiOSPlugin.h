//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#pragma once
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AVFoundation/AVFoundation.h>
#import <StoreKit/StoreKit.h>
#import <UserNotifications/UserNotifications.h>
#import <Fabric/Fabric.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKSharing.h>
#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseMessaging/FirebaseMessaging.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <LineSDK/LineSDK.h>
#import <TwitterKit/TwitterKit.h>
#import <WebKit/WebKit.h>
typedef void (^cmplcbk)(void);
UIViewController* UnityGetGLViewController();
void UnitySendMessage(const char* obj, const char* method, const char* msg);
#ifdef __cplusplus
extern "C" {
#endif
void setPreviewFrameCameraViewPlugin(unsigned char* imageData, int width, int height);
#ifdef __cplusplus
}
#endif
