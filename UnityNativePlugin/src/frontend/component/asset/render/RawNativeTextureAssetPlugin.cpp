//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include <stdio.h>
#include <stdlib.h>
#include "RawNativeTextureAssetPlugin.h"
RawNativeTextureAssetPlugin::RawNativeTextureAssetPlugin() {}
RawNativeTextureAssetPlugin::~RawNativeTextureAssetPlugin() {}
bool RawNativeTextureAssetPlugin::load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) {
    int bufferSize = 0;
    if (false != useAlphaChannel) {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
    } else {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
    }
    this->data = (unsigned char*)malloc(bufferSize);
    FILE* fp = fopen(textureAssetPath, "rb");
    if (NULL == fp) {
        return false;
    }
    fread(this->data, sizeof(char), bufferSize, fp);
    fclose(fp);
    this->width = textureWidth;
    this->height = textureHeight;
    this->alphaChannel = useAlphaChannel;
    return true;
}
