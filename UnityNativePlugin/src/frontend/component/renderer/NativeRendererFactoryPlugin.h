//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef NativeRendererFactoryPlugin_h
#define NativeRendererFactoryPlugin_h
#include "IUnityGraphics.h"
#include "BaseNativeRendererPlugin.h"
class NativeRendererFactoryPlugin {
   public:
    static BaseNativeRendererPlugin* factoryMethod(UnityGfxRenderer remdererType);
};
#endif /* NativeRendererFactoryPlugin_h */
