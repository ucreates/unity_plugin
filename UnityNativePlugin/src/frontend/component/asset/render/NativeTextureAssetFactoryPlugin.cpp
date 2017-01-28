//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "NativeTextureAssetFactoryPlugin.h"
#include "RawNativeTextureAssetPlugin.h"
#include "ExtensionPlugin.h"
BaseNativeTextureAssetPlugin* NativeTextureAssetFactoryPlugin::factoryMethod(const char* textureAssetPath) {
    BaseNativeTextureAssetPlugin* textureAsset = NULL;
    if (false != ExtensionPlugin::hasExtension(textureAssetPath, ".raw")) {
        textureAsset = new RawNativeTextureAssetPlugin();
    }
    return textureAsset;
}
