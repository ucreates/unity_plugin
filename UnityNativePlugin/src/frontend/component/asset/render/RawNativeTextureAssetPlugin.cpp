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
#include <string>
#include "RawNativeTextureAssetPlugin.h"
#include "BGRAPlugin.h"
RawNativeTextureAssetPlugin::RawNativeTextureAssetPlugin() {}
RawNativeTextureAssetPlugin::~RawNativeTextureAssetPlugin() {}
bool RawNativeTextureAssetPlugin::load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) {
    int bufferSize = 0;
    if (false != useAlphaChannel) {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
    } else {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
    }
    FILE* fp = fopen(textureAssetPath, "rb");
    if (NULL == fp) {
        return false;
    }
    this->data = (unsigned char*)malloc(bufferSize);
    fread(this->data, sizeof(char), bufferSize, fp);
    fclose(fp);
    this->width = textureWidth;
    this->height = textureHeight;
    this->alphaChannel = useAlphaChannel;
    return true;
}
#if UNITY_IPHONE
bool RawNativeTextureAssetPlugin::load(const unsigned char* textureData, int textureWidth, int textureHeight, bool useAlphaChannel) {
    int bufferSize = 0;
    int sizePerPixel = 0;
    if (false != useAlphaChannel) {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
        sizePerPixel = BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
    } else {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
        sizePerPixel = BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
    }
    if (NULL == textureData || 0 == bufferSize) {
        return false;
    }
    if (NULL == this->data) {
        this->data = (unsigned char*)malloc(bufferSize);
    }
    memcpy(this->data, textureData, bufferSize);
    this->width = textureWidth;
    this->height = textureHeight;
    this->alphaChannel = true;
    return true;
}
#endif
