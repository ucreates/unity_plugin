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
#if UNITY_ANDROID
#include "TextureAssetValidatorPlugin.h"
MetalNativeRendererPlugin::MetalNativeRendererPlugin() {}
MetalNativeRendererPlugin::~MetalNativeRendererPlugin() {}
void MetalNativeRendererPlugin::render(void* texturePtr, int width, int height, unsigned char* data, bool useAlphaChannel) { return; }
void MetalNativeRendererPlugin::render(BaseNativeTextureAssetPlugin* textureAsset) { return; }
#endif
