//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef TextureAssetValidatorPlugin_h
#define TextureAssetValidatorPlugin_h
#include "BaseNativeTextureAssetPlugin.h"
class TextureAssetValidatorPlugin {
   public:
    static bool isValid(BaseNativeTextureAssetPlugin* textureAsset);
};
#endif /* TextureAssetValidatorPlugin_h */
