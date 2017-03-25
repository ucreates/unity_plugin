//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef BaseNativeRendererPlugin_h
#define BaseNativeRendererPlugin_h
#include "IUnityInterface.h"
#include "BaseNativeTextureAssetPlugin.h"
class BaseNativeRendererPlugin {
   public:
    BaseNativeRendererPlugin();
    virtual ~BaseNativeRendererPlugin();
    virtual void render(unsigned int textureId, int width, int height, unsigned char* data, bool useAlphaChannel);
    virtual void render(void* texturePtr, int width, int height, unsigned char* data, bool useAlphaChannel);
    virtual void render(BaseNativeTextureAssetPlugin* textureAsset);
};
#endif /* BaseNativeRendererPlugin_h */
