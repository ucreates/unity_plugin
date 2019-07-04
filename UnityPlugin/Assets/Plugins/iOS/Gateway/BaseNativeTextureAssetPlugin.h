//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef BaseNativeTextureAssetPlugin_h
#define BaseNativeTextureAssetPlugin_h
#include "PlatformBase.h"
#include "IUnityGraphics.h"
#if UNITY_IPHONE
#include <OpenGLES/ES2/gl.h>
#endif
#if UNITY_ANDROID
#include <jni.h>
#include <android/api-level.h>
#if __ANDROID_API__ >= 18
#include <GLES3/gl3.h>
#elif __ANDROID_API__ >= 8
#include <GLES2/gl2.h>
#else
#include <GLES/gl.h>
#endif
#endif
class BaseNativeTextureAssetPlugin {
   public:
    static const int RGB_SIZE_PER_PIXEL = 3;
    static const int ARGB_SIZE_PER_PIXEL = 4;
    BaseNativeTextureAssetPlugin();
    virtual ~BaseNativeTextureAssetPlugin();
    virtual bool load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel);
    void destroy();
    void* getTexturePtr();
    GLuint getTextureId();
    unsigned char* getData();
    int getWidth();
    int getHeight();
    bool enableAlphaChannel();
    bool isDestroy();
    void setTexturePtr(void* unityTexturePtr);
    void setData(unsigned char* textureData);
    void setSize(int textureWidth, int textureHeight);
    void setEnableAlphaChannel(bool useAlphaChannel);
    void setUnityGfxRenderer(UnityGfxRenderer rendererType);
#if UNITY_IPHONE
    virtual bool load(const unsigned char* textureData, int textureWidth, int textureHeight, bool useAlphaChannel);
#endif
#if UNITY_ANDROID
    virtual bool load(JNIEnv* env, jobject selfObject, const jbyteArray textureData, jint bufferSize, jint textureWidth, jint textureHeight, bool useAlphaChannel);
#endif
   protected:
    void* texturePtr;
    unsigned char* data;
    int width;
    int height;
    bool alphaChannel;
    bool enableDestroy;
    UnityGfxRenderer unityGfxRenderer;
#if UNITY_ANDROID
    unsigned char* jniData;
#endif
};
#endif /* BaseNativeTextureAssetPlugin_h */
