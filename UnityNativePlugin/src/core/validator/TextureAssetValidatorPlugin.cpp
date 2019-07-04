//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "TextureAssetValidatorPlugin.h"
bool TextureAssetValidatorPlugin::isValid(BaseNativeTextureAssetPlugin* textureAsset) {
    if (NULL == textureAsset || NULL == textureAsset->getData() || 0 == textureAsset->getWidth() || 0 == textureAsset->getHeight()) {
        return false;
    }
    return true;
}
