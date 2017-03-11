//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef PngNativeTextureAssetPlugin_h
#define PngNativeTextureAssetPlugin_h
#include "BaseNativeTextureAssetPlugin.h"
class PngNativeTextureAssetPlugin : public BaseNativeTextureAssetPlugin {
   public:
    static const int TEXTURE_TYPE = 4;
    static const int HEADER_SIZE_PER_BYTE = 8;
    PngNativeTextureAssetPlugin();
    virtual ~PngNativeTextureAssetPlugin();
    bool load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) override;
};
#endif /* PngNativeTextureAssetPlugin_h */
