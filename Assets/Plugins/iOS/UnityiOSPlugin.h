//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#import <UIKit/UIKit.h>
#import <LineAdapter/LineSDK.h>
typedef void (^cmplcbk)(void);
UIViewController* UnityGetGLViewController();
void UnitySendMessage(const char* obj, const char* method, const char* msg);
