//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#pragma once
#include "PlatformBase.h"
#if UNITY_ANDROID
#include <jni.h>
#endif
#include "IUnityGraphics.h"
#include "BaseNativeRendererPlugin.h"
#include "BaseNativeTextureAssetPlugin.h"
IUnityInterfaces* interfaces = NULL;
IUnityGraphics* graphics = NULL;
BaseNativeRendererPlugin* nativeRenderer = NULL;
static BaseNativeTextureAssetPlugin* cameraNativeTextureAsset = NULL;
extern "C" {
void UNITY_INTERFACE_EXPORT UNITY_INTERFACE_API UnityPluginLoad(IUnityInterfaces* unityInterfaces);
void UNITY_INTERFACE_EXPORT UNITY_INTERFACE_API UnityPluginUnload();
void UNITY_INTERFACE_EXPORT CreateNativeRendererPlugin();
void UNITY_INTERFACE_EXPORT DestroyNativeRendererPlugin();
void UNITY_INTERFACE_EXPORT LoadTextureByNativeTextureAssetPlugin(int instanceId, char* textureAssetPath, int width = 0, int height = 0, bool useAlphaChannel = false);
int UNITY_INTERFACE_EXPORT GetTextureWidthByNativeTextureAssetPlugin(int instanceId);
int UNITY_INTERFACE_EXPORT GetTextureHeightByNativeTextureAssetPlugin(int instanceId);
bool UNITY_INTERFACE_EXPORT EnableAlphaChannelByNativeTextureAssetPlugin(int instanceId);
void UNITY_INTERFACE_EXPORT DestroyTextureByNativeTextureAssetPlugin(int instanceId);
void UNITY_INTERFACE_EXPORT SetTextureIdToNativeTextureAssetPlugin(int instanceId, void* unityNativeTexturePtr);
void UNITY_INTERFACE_EXPORT CreatePreviewFrameNativeCameraTextureAssetPlugin();
void UNITY_INTERFACE_EXPORT DestroyPreviewFrameNativeCameraTextureAssetPlugin();
void UNITY_INTERFACE_EXPORT SetTextureIdToNativeCameraTextureAssetPlugin(int instanceId, void* unityNativeTexturePtr);
bool UNITY_INTERFACE_EXPORT EnableTextureByNativeTextureAssetPlugin(int instanceId);
void UNITY_INTERFACE_EXPORT RenderTextureByNativeRendererPlugin(int eventID);
void UNITY_INTERFACE_EXPORT RenderCameraPreviewFrameByNativeRendererPlugin(int eventID);
UnityRenderingEvent UNITY_INTERFACE_EXPORT GetRenderTextureCallbackByNativeRendererPlugin();
UnityRenderingEvent UNITY_INTERFACE_EXPORT GetRenderCameraPreviewFrameCallbackByNativeRendererPlugin();
void UNITY_INTERFACE_API OnGraphicsDeviceEvent(UnityGfxDeviceEventType eventType);
#if UNITY_IPHONE
void UNITY_INTERFACE_EXPORT SetPreviewFrameToNativeCameraTextureAssetPlugin(unsigned char* previewFrameData, int width, int height);
#endif
#if UNITY_ANDROID
JNIEXPORT void JNICALL Java_com_gateway_UnityAndroidPlugin_SetPreviewFrameToNativeCameraTextureAssetPlugin(JNIEnv* env, jobject selfObject, jbyteArray imageData, jint bufferSize, jint width, jint height);
#endif
}
