//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef RawNativeTextureAssetPlugin_h
#define RawNativeTextureAssetPlugin_h
#include "BaseNativeTextureAssetPlugin.h"
class RawNativeTextureAssetPlugin : public BaseNativeTextureAssetPlugin {
   public:
    RawNativeTextureAssetPlugin();
    virtual ~RawNativeTextureAssetPlugin();
    bool load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) override;
};
#endif /* RawNativeTextureAssetPlugin_h */
