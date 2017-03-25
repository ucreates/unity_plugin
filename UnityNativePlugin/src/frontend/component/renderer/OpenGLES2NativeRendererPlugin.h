//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef OpenGLES2NativeRendererPlugin_h
#define OpenGLES2NativeRendererPlugin_h
#include "PlatformBase.h"
#if UNITY_IPHONE
#include <OpenGLES/ES2/gl.h>
#endif
#if UNITY_ANDROID
#include <android/api-level.h>
#if __ANDROID_API__ >= 18
#include <GLES3/gl3.h>
#elif __ANDROID_API__ >= 8
#include <GLES2/gl2.h>
#else
#include <GLES/gl.h>
#endif
#endif
#include "BaseNativeRendererPlugin.h"
class OpenGLES2NativeRendererPlugin : public BaseNativeRendererPlugin {
   public:
    OpenGLES2NativeRendererPlugin();
    virtual ~OpenGLES2NativeRendererPlugin();
    void render(void* texturePtr, int width, int height, unsigned char* data, bool useAlphaChannel) override;
    void render(unsigned int textureId, int width, int height, unsigned char* data, bool useAlphaChannel) override;
    void render(BaseNativeTextureAssetPlugin* textureAsset) override;
};
#endif /* OpenGLES2NativeRendererPlugin_h */
