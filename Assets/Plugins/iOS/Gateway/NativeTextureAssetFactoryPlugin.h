//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef NativeTextureAssetFactoryPlugin_h
#define NativeTextureAssetFactoryPlugin_h
#include "BaseNativeTextureAssetPlugin.h"
class NativeTextureAssetFactoryPlugin {
   public:
    static BaseNativeTextureAssetPlugin* factoryMethod(const char* textureAssetPath);
    static BaseNativeTextureAssetPlugin* factoryMethod(const int textureType);
};
#endif /* NativeTextureAssetFactoryPlugin_h */
