//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef MetalNativeRendererPlugin_h
#define MetalNativeRendererPlugin_h
#include "PlatformBase.h"
#include "BaseNativeRendererPlugin.h"
class MetalNativeRendererPlugin : public BaseNativeRendererPlugin {
   public:
    MetalNativeRendererPlugin();
    virtual ~MetalNativeRendererPlugin();
    void render(void* texturePtr, int width, int height, unsigned char* data, bool useAlphaChannel) override;
    void render(BaseNativeTextureAssetPlugin* textureAsset) override;
};
#endif /* MetalNativeRendererPlugin_h */
