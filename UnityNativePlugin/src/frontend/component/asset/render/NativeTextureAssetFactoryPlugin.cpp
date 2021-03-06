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
#include "YuvNativeTextureAssetPlugin.h"
#include "JpegNativeTextureAssetPlugin.h"
#include "PngNativeTextureAssetPlugin.h"
#include "ExtensionPlugin.h"
BaseNativeTextureAssetPlugin* NativeTextureAssetFactoryPlugin::factoryMethod(const char* textureAssetPath) {
    BaseNativeTextureAssetPlugin* textureAsset = NULL;
    if (false != ExtensionPlugin::hasExtension(textureAssetPath, ".raw")) {
        textureAsset = new RawNativeTextureAssetPlugin();
    } else if (false != ExtensionPlugin::hasExtension(textureAssetPath, ".jpg")) {
        textureAsset = new JpegNativeTextureAssetPlugin();
    } else if (false != ExtensionPlugin::hasExtension(textureAssetPath, ".png")) {
        textureAsset = new PngNativeTextureAssetPlugin();
    }
    return textureAsset;
}
BaseNativeTextureAssetPlugin* NativeTextureAssetFactoryPlugin::factoryMethod(const int textureType) {
    BaseNativeTextureAssetPlugin* textureAsset = NULL;
    switch (textureType) {
        case RawNativeTextureAssetPlugin::TEXTURE_TYPE:
            textureAsset = new RawNativeTextureAssetPlugin();
            break;
        case YuvNativeTextureAssetPlugin::TEXTURE_TYPE:
            textureAsset = new YuvNativeTextureAssetPlugin();
            break;
        case JpegNativeTextureAssetPlugin::TEXTURE_TYPE:
            textureAsset = new JpegNativeTextureAssetPlugin();
            break;
        case PngNativeTextureAssetPlugin::TEXTURE_TYPE:
            textureAsset = new PngNativeTextureAssetPlugin();
            break;
        default:
            break;
    }
    return textureAsset;
}
