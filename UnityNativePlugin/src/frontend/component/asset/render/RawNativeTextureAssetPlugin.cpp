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
#if UNITY_IPHONE
bool RawNativeTextureAssetPlugin::load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) {
    int bufferSize = 0;
    if (false != useAlphaChannel) {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
    } else {
        if (this->unityGfxRenderer == kUnityGfxRendererMetal) {
            bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
        } else {
            bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
        }
    }
    FILE* fp = fopen(textureAssetPath, "rb");
    if (NULL == fp) {
        return false;
    }
    this->width = textureWidth;
    this->height = textureHeight;
    this->alphaChannel = useAlphaChannel;
    if (this->unityGfxRenderer == kUnityGfxRendererMetal) {
        if (false != useAlphaChannel) {
            this->data = (unsigned char*)malloc(bufferSize);
            fread(this->data, sizeof(char), bufferSize, fp);
            fclose(fp);
        } else {
            int tmpBufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
            unsigned char* tmpData = (unsigned char*)malloc(tmpBufferSize);
            this->data = (unsigned char*)malloc(bufferSize);
            fread(tmpData, sizeof(char), bufferSize, fp);
            fclose(fp);
            int dataIdx = 0;
            int tmpDataIdx = 0;
            for (int y = 0; y < this->height; y++) {
                for (int x = 0; x < this->width; x++) {
                    int tridx = tmpDataIdx;
                    int tgidx = tmpDataIdx + 1;
                    int tbidx = tmpDataIdx + 2;
                    int dridx = dataIdx;
                    int dgidx = dataIdx + 1;
                    int dbidx = dataIdx + 2;
                    int daidx = dataIdx + 3;
                    this->data[dridx] = tmpData[tridx];
                    this->data[dgidx] = tmpData[tgidx];
                    this->data[dbidx] = tmpData[tbidx];
                    this->data[daidx] = 0xff;
                    tmpDataIdx += BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
                    dataIdx += BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
                }
            }
            free(tmpData);
        }
    } else {
        this->data = (unsigned char*)malloc(bufferSize);
        fread(this->data, sizeof(char), bufferSize, fp);
        fclose(fp);
    }
    return true;
}
#endif
#if UNITY_ANDROID
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
#endif
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
