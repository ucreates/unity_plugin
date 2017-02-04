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
#include "string.h"
#include "video_common.h"
#include "convert.h"
#include "convert_argb.h"
#include "PlatformBase.h"
#include "YuvNativeTextureAssetPlugin.h"
YuvNativeTextureAssetPlugin::YuvNativeTextureAssetPlugin() {}
YuvNativeTextureAssetPlugin::~YuvNativeTextureAssetPlugin() {}
#if UNITY_IPHONE
bool YuvNativeTextureAssetPlugin::load(const unsigned char* textureData, int textureWidth, int textureHeight, bool useAlphaChannel) {
    int bufferSize = 0;
    if (false != useAlphaChannel) {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
    } else {
        bufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
    }
    if (NULL == textureData || 0 == bufferSize) {
        return false;
    }
    if (NULL == this->data) {
        this->data = (unsigned char*)malloc(bufferSize);
    }
    int stride = 0;
    if (false != useAlphaChannel) {
        stride = textureWidth * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
    } else {
        stride = textureWidth * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
    }
    int ret = libyuv::ConvertToARGB(textureData, bufferSize, this->data, stride, 0, 0, textureWidth, textureHeight, textureWidth, textureHeight, libyuv::RotationMode::kRotate0, libyuv::FourCC::FOURCC_NV21);
    if (-1 == ret) {
        memset(this->data, 0, bufferSize);
        this->width = 0;
        this->height = 0;
        this->alphaChannel = false;
        return false;
    }
    this->width = textureWidth;
    this->height = textureHeight;
    this->alphaChannel = useAlphaChannel;
    return true;
}
#endif
#if UNITY_ANDROID
bool YuvNativeTextureAssetPlugin::load(JNIEnv* env, jobject selfObject, const jbyteArray textureData, jint bufferSize, jint textureWidth, jint textureHeight, bool useAlphaChannel) {
    if (NULL == textureData) {
        return false;
    }
    int dataBufferSize = 0;
    if (false != useAlphaChannel) {
        dataBufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
    } else {
        dataBufferSize = textureWidth * textureHeight * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
    }
    if (NULL == this->data) {
        this->data = (unsigned char*)calloc(dataBufferSize, sizeof(unsigned char));
    }
    if (NULL == this->jniData) {
        this->jniData = (unsigned char*)calloc(bufferSize, sizeof(unsigned char));
    }
    env->GetByteArrayRegion(textureData, 0, bufferSize, (jbyte*)this->jniData);
    unsigned char* puv = (unsigned char*)(this->jniData + textureWidth * textureHeight);
    int ret = 0;
    if (false != useAlphaChannel) {
        ret = libyuv::Android420ToRGBA(this->jniData, puv, 2, this->data, textureWidth, textureHeight);
    } else {
        ret = libyuv::Android420ToRGB(this->jniData, puv, 2, this->data, textureWidth, textureHeight);
    }
    if (-1 == ret) {
        memset(this->data, 0, dataBufferSize);
        this->width = 0;
        this->height = 0;
        this->alphaChannel = false;
        return false;
    }
    this->width = textureWidth;
    this->height = textureHeight;
    this->alphaChannel = useAlphaChannel;
    return true;
}
#endif
