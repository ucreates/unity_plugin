//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef JpegNativeTextureAssetPlugin_h
#define JpegNativeTextureAssetPlugin_h
#include "BaseNativeTextureAssetPlugin.h"
class JpegNativeTextureAssetPlugin : public BaseNativeTextureAssetPlugin {
   public:
    static const int TEXTURE_TYPE = 3;
    static const int LIBJPEG_VERSION = 62;
#if UNITY_IPHONE
    static const int DUMMY_DECOMPRESS_STRUCT_SIZE = 600;
#endif
#if UNITY_ANDROID
    static const int DUMMY_DECOMPRESS_STRUCT_SIZE = 480;
#endif
    JpegNativeTextureAssetPlugin();
    virtual ~JpegNativeTextureAssetPlugin();
    bool load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) override;
};
#endif /* JpegNativeTextureAssetPlugin_h */
