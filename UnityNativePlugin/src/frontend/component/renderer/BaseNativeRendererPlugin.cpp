//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "BaseNativeRendererPlugin.h"
BaseNativeRendererPlugin::BaseNativeRendererPlugin() {}
BaseNativeRendererPlugin::~BaseNativeRendererPlugin() {}
void BaseNativeRendererPlugin::render(unsigned int textureId, int width, int height, unsigned char* data, bool useAlphaChannel) { return; }
void BaseNativeRendererPlugin::render(void* texturePtr, int width, int height, unsigned char* data, bool useAlphaChannel) { return; }
void BaseNativeRendererPlugin::render(BaseNativeTextureAssetPlugin* textureAsset) { return; }
