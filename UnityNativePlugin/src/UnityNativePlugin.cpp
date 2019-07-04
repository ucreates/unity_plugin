//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "UnityNativePlugin.h"
#include "NativeRendererFactoryPlugin.h"
#include "NativeTextureAssetCollectionPlugin.h"
#include "NativeTextureAssetFactoryPlugin.h"
#include "YuvNativeTextureAssetPlugin.h"
void UNITY_INTERFACE_EXPORT UNITY_INTERFACE_API UnityPluginLoad(IUnityInterfaces* unityInterfaces) {
    interfaces = unityInterfaces;
    if (NULL == interfaces) {
        return;
    }
    graphics = interfaces->Get<IUnityGraphics>();
    if (NULL == graphics) {
        return;
    }
    graphics->RegisterDeviceEventCallback(OnGraphicsDeviceEvent);
    OnGraphicsDeviceEvent(kUnityGfxDeviceEventInitialize);
    return;
}
void UNITY_INTERFACE_EXPORT UNITY_INTERFACE_API UnityPluginUnload() {
    if (NULL == graphics) {
        return;
    }
    graphics->UnregisterDeviceEventCallback(OnGraphicsDeviceEvent);
    return;
}
void UNITY_INTERFACE_API OnGraphicsDeviceEvent(UnityGfxDeviceEventType eventType) {
    if (eventType == kUnityGfxDeviceEventShutdown) {
        if (NULL != nativeRenderer) {
            delete nativeRenderer;
            nativeRenderer = NULL;
        }
        if (NULL != cameraNativeTextureAsset) {
            delete cameraNativeTextureAsset;
            cameraNativeTextureAsset = NULL;
        }
        NativeTextureAssetCollectionPlugin::destroy();
        return;
    }
}
void UNITY_INTERFACE_EXPORT CreateNativeRendererPlugin() {
    if (NULL != nativeRenderer) {
        return;
    }
    if (NULL == graphics) {
        graphics = interfaces->Get<IUnityGraphics>();
        if (NULL == graphics) {
            return;
        }
    }
    UnityGfxRenderer rendererType = graphics->GetRenderer();
    nativeRenderer = NativeRendererFactoryPlugin::factoryMethod(rendererType);
    return;
}
void UNITY_INTERFACE_EXPORT DestroyNativeRendererPlugin() {
    if (NULL == nativeRenderer) {
        return;
    }
    delete nativeRenderer;
    nativeRenderer = NULL;
    return;
}
void UNITY_INTERFACE_EXPORT LoadTextureByNativeTextureAssetPlugin(int instanceId, char* textureAssetPath, int width, int height, bool useAlphaChannel) {
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL != textureAsset) {
        return;
    }
    UnityGfxRenderer rendererType = graphics->GetRenderer();
    textureAsset = NativeTextureAssetFactoryPlugin::factoryMethod(textureAssetPath);
    textureAsset->setUnityGfxRenderer(rendererType);
    textureAsset->load(textureAssetPath, width, height, useAlphaChannel);
    collection->add(instanceId, textureAsset);
    return;
}
int UNITY_INTERFACE_EXPORT GetTextureWidthByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return 0;
    }
    return textureAsset->getWidth();
}
int UNITY_INTERFACE_EXPORT GetTextureHeightByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return 0;
    }
    return textureAsset->getHeight();
}
bool UNITY_INTERFACE_EXPORT EnableAlphaChannelByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return false;
    }
    return textureAsset->enableAlphaChannel();
}
void UNITY_INTERFACE_EXPORT DestroyTextureByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset || false != textureAsset->isDestroy()) {
        return;
    }
    textureAsset->destroy();
    return;
}
void UNITY_INTERFACE_EXPORT SetTextureIdToNativeTextureAssetPlugin(int instanceId, void* unityNativeTexturePtr) {
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return;
    }
    textureAsset->setTexturePtr(unityNativeTexturePtr);
    return;
}
bool UNITY_INTERFACE_EXPORT EnableTextureByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return false;
    }
    return true;
}
void UNITY_INTERFACE_EXPORT CreatePreviewFrameNativeCameraTextureAssetPlugin() {
    if (NULL != cameraNativeTextureAsset) {
        return;
    }
    UnityGfxRenderer rendererType = graphics->GetRenderer();
    cameraNativeTextureAsset = NativeTextureAssetFactoryPlugin::factoryMethod(YuvNativeTextureAssetPlugin::TEXTURE_TYPE);
    cameraNativeTextureAsset->setUnityGfxRenderer(rendererType);
    return;
}
void UNITY_INTERFACE_EXPORT DestroyPreviewFrameNativeCameraTextureAssetPlugin() {
    if (NULL == cameraNativeTextureAsset) {
        return;
    }
    delete cameraNativeTextureAsset;
    cameraNativeTextureAsset = NULL;
    NativeTextureAssetCollectionPlugin::destroy();
    return;
}
void UNITY_INTERFACE_EXPORT SetTextureIdToNativeCameraTextureAssetPlugin(int instanceId, void* unityNativeTexturePtr) {
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL != textureAsset) {
        return;
    }
    UnityGfxRenderer rendererType = graphics->GetRenderer();
    textureAsset = NativeTextureAssetFactoryPlugin::factoryMethod(YuvNativeTextureAssetPlugin::TEXTURE_TYPE);
    textureAsset->setTexturePtr(unityNativeTexturePtr);
    textureAsset->setUnityGfxRenderer(rendererType);
    collection->add(instanceId, textureAsset);
    return;
}
void UNITY_INTERFACE_API RenderTextureByNativeRendererPlugin(int eventID) {
    if (NULL == nativeRenderer) {
        return;
    }
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    std::map<int, BaseNativeTextureAssetPlugin*>* textureAssetMap = collection->getCollection();
    for (std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = textureAssetMap->begin(); it != textureAssetMap->end();) {
        BaseNativeTextureAssetPlugin* textureAsset = it->second;
        if (false != textureAsset->isDestroy()) {
            delete textureAsset;
            textureAsset = NULL;
            std::map<int, BaseNativeTextureAssetPlugin*>::iterator eraseIt = it;
            ++it;
            textureAssetMap->erase(eraseIt);
            continue;
        }
        nativeRenderer->render(textureAsset);
        ++it;
    }
    return;
}
void UNITY_INTERFACE_EXPORT RenderCameraPreviewFrameByNativeRendererPlugin(int eventID) {
    if (NULL == nativeRenderer || NULL == cameraNativeTextureAsset) {
        return;
    }
    unsigned char* cameraCaptureData = cameraNativeTextureAsset->getData();
    if (NULL == cameraCaptureData) {
        return;
    }
    int cameraCaptureWidth = cameraNativeTextureAsset->getWidth();
    int cameraCaptureHeight = cameraNativeTextureAsset->getHeight();
    NativeTextureAssetCollectionPlugin* collection = NativeTextureAssetCollectionPlugin::getInstance();
    std::map<int, BaseNativeTextureAssetPlugin*>* textureAssetMap = collection->getCollection();
    for (std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = textureAssetMap->begin(); it != textureAssetMap->end();) {
        BaseNativeTextureAssetPlugin* textureAsset = it->second;
        void* texturePtr = textureAsset->getTexturePtr();
        nativeRenderer->render(texturePtr, cameraCaptureWidth, cameraCaptureHeight, cameraCaptureData, true);
        ++it;
    }
    return;
}
UnityRenderingEvent UNITY_INTERFACE_EXPORT GetRenderTextureCallbackByNativeRendererPlugin() { return RenderTextureByNativeRendererPlugin; }
UnityRenderingEvent UNITY_INTERFACE_EXPORT GetRenderCameraPreviewFrameCallbackByNativeRendererPlugin() { return RenderCameraPreviewFrameByNativeRendererPlugin; }
#if UNITY_IPHONE
void UNITY_INTERFACE_EXPORT SetPreviewFrameToNativeCameraTextureAssetPlugin(unsigned char* previewFrameData, int width, int height) {
    if (NULL == cameraNativeTextureAsset) {
        return;
    }
    cameraNativeTextureAsset->load(previewFrameData, width, height, true);
    return;
}
#endif
#if UNITY_ANDROID
JNIEXPORT void JNICALL Java_com_gateway_UnityAndroidPlugin_SetPreviewFrameToNativeCameraTextureAssetPlugin(JNIEnv* env, jobject selfObject, jbyteArray previewFrameData, jint bufferSize, jint width, jint height) {
    if (false != env->IsSameObject(previewFrameData, NULL) || NULL == cameraNativeTextureAsset) {
        return;
    }
    cameraNativeTextureAsset->load(env, selfObject, previewFrameData, bufferSize, width, height, true);
    return;
}
#endif
