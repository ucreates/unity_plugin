//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef YuvNativeTextureAssetPlugin_h
#define YuvNativeTextureAssetPlugin_h
#include "BaseNativeTextureAssetPlugin.h"
class YuvNativeTextureAssetPlugin : public BaseNativeTextureAssetPlugin {
   public:
    static const int TEXTURE_TYPE = 2;
    YuvNativeTextureAssetPlugin();
    virtual ~YuvNativeTextureAssetPlugin();
#if UNITY_IPHONE
    bool load(const unsigned char* textureData, int textureWidth, int textureHeight, bool useAlphaChannel) override;
#endif
#if UNITY_ANDROID
    bool load(JNIEnv* env, jobject selfObject, const jbyteArray textureData, jint bufferSize, jint textureWidth, jint textureHeight, bool useAlphaChannel) override;
#endif
};
#endif /* YuvNativeTextureAssetPlugin_h */
