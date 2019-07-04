//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "MetalNativeRendererPlugin.h"
#if UNITY_IPHONE
#import <Metal/Metal.h>
#include <stddef.h>
#include "IUnityGraphicsMetal.h"
#include "TextureAssetValidatorPlugin.h"
MetalNativeRendererPlugin::MetalNativeRendererPlugin() {}
MetalNativeRendererPlugin::~MetalNativeRendererPlugin() {}
void MetalNativeRendererPlugin::render(void* texturePtr, int width, int height, unsigned char* data, bool useAlphaChannel) {
    int stride = width * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
    id<MTLTexture> texture = (__bridge id<MTLTexture>)texturePtr;
    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
    [texture replaceRegion:region mipmapLevel:0 withBytes:data bytesPerRow:stride];
    return;
}
void MetalNativeRendererPlugin::render(BaseNativeTextureAssetPlugin* textureAsset) {
    if (false == TextureAssetValidatorPlugin::isValid(textureAsset)) {
        return;
    }
    void* texturePtr = (void*)textureAsset->getTexturePtr();
    int width = textureAsset->getWidth();
    int height = textureAsset->getHeight();
    unsigned char* data = textureAsset->getData();
    bool useAlphaChannel = textureAsset->enableAlphaChannel();
    this->render(texturePtr, width, height, data, useAlphaChannel);
    return;
}
#endif
