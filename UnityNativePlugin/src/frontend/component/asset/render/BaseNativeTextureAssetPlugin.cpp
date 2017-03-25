//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include <stdlib.h>
#include "BaseNativeTextureAssetPlugin.h"
BaseNativeTextureAssetPlugin::BaseNativeTextureAssetPlugin() {
    this->texturePtr = NULL;
    this->data = NULL;
    this->width = 0;
    this->height = 0;
    this->alphaChannel = false;
    this->enableDestroy = false;
#if UNITY_ANDROID
    this->jniData = NULL;
#endif
}
BaseNativeTextureAssetPlugin::~BaseNativeTextureAssetPlugin() {
    if (NULL != this->data) {
        free(this->data);
        this->data = NULL;
    }
#if UNITY_ANDROID
    if (NULL != this->jniData) {
        free(this->jniData);
        this->jniData = NULL;
    }
#endif
}
void* BaseNativeTextureAssetPlugin::getTexturePtr() { return this->texturePtr; }
GLuint BaseNativeTextureAssetPlugin::getTextureId() { return (GLuint)(size_t) this->texturePtr; }
bool BaseNativeTextureAssetPlugin::load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) { return true; }
unsigned char* BaseNativeTextureAssetPlugin::getData() { return this->data; }
int BaseNativeTextureAssetPlugin::getWidth() { return this->width; }
int BaseNativeTextureAssetPlugin::getHeight() { return this->height; }
bool BaseNativeTextureAssetPlugin::enableAlphaChannel() { return this->alphaChannel; }
bool BaseNativeTextureAssetPlugin::isDestroy() { return this->enableDestroy; }
void BaseNativeTextureAssetPlugin::setTexturePtr(void* unityTexturePtr) {
    this->texturePtr = unityTexturePtr;
    return;
}
void BaseNativeTextureAssetPlugin::setData(unsigned char* textureData) {
    this->data = textureData;
    return;
}
void BaseNativeTextureAssetPlugin::setSize(int textureWidth, int textureHeight) {
    this->width = textureWidth;
    this->height = textureHeight;
    return;
}
void BaseNativeTextureAssetPlugin::setEnableAlphaChannel(bool useAlphaChannel) {
    this->alphaChannel = useAlphaChannel;
    return;
}
void BaseNativeTextureAssetPlugin::setUnityGfxRenderer(UnityGfxRenderer rendererType) {
    this->unityGfxRenderer = rendererType;
    return;
}
void BaseNativeTextureAssetPlugin::destroy() {
    this->enableDestroy = true;
    return;
}
#if UNITY_IPHONE
bool BaseNativeTextureAssetPlugin::load(const unsigned char* textureData, int textureWidth, int textureHeight, bool useAlphaChannel) { return true; }
#endif
#if UNITY_ANDROID
bool BaseNativeTextureAssetPlugin::load(JNIEnv* env, jobject selfObject, const jbyteArray textureData, jint bufferSize, jint textureWidth, jint textureHeight, bool useAlphaChannel) { return true; }
#endif
