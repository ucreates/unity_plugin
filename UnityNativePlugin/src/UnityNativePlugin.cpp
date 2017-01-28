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
#include "NativeTextureAssetCollection.h"
#include "NativeTextureAssetFactoryPlugin.h"
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
        if (NULL != nativeRendererPlugin) {
            delete nativeRendererPlugin;
            nativeRendererPlugin = NULL;
        }
        NativeTextureAssetCollection::destroy();
        return;
    }
}
void UNITY_INTERFACE_EXPORT CreateNativeRendererPlugin() {
    graphics = interfaces->Get<IUnityGraphics>();
    UnityGfxRenderer rendererType = graphics->GetRenderer();
    if (NULL != nativeRendererPlugin) {
        return;
    }
    nativeRendererPlugin = NativeRendererFactoryPlugin::factoryMethod(rendererType);
    return;
}
void UNITY_INTERFACE_EXPORT DestroyNativeRendererPlugin() {
    if (NULL == nativeRendererPlugin) {
        return;
    }
    delete nativeRendererPlugin;
    nativeRendererPlugin = NULL;
    return;
}
void UNITY_INTERFACE_EXPORT LoadTextureByNativeTextureAssetPlugin(int instanceId, char* textureAssetPath, int width, int height, bool useAlphaChannel) {
    NativeTextureAssetCollection* collection = NativeTextureAssetCollection::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL != textureAsset) {
        return;
    }
    textureAsset = NativeTextureAssetFactoryPlugin::factoryMethod(textureAssetPath);
    textureAsset->load(textureAssetPath, width, height, useAlphaChannel);
    collection->add(instanceId, textureAsset);
    return;
}
int UNITY_INTERFACE_EXPORT GetTextureWidthByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollection* collection = NativeTextureAssetCollection::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return 0;
    }
    return textureAsset->getWidth();
}
int UNITY_INTERFACE_EXPORT GetTextureHeightByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollection* collection = NativeTextureAssetCollection::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return 0;
    }
    return textureAsset->getHeight();
}
bool UNITY_INTERFACE_EXPORT EnableAlphaChannelByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollection* collection = NativeTextureAssetCollection::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return false;
    }
    return textureAsset->enableAlphaChannel();
}
void UNITY_INTERFACE_EXPORT DestroyTextureByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollection* collection = NativeTextureAssetCollection::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset || false != textureAsset->isDestroy()) {
        return;
    }
    textureAsset->destroy();
    return;
}
void UNITY_INTERFACE_EXPORT SetTextureIdToNativeTextureAssetPlugin(int instanceId, void* unityNativeTexturePtr) {
    NativeTextureAssetCollection* collection = NativeTextureAssetCollection::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return;
    }
    GLuint textureId = (GLuint)(size_t)unityNativeTexturePtr;
    textureAsset->setTextureId(textureId);
    return;
}
bool UNITY_INTERFACE_EXPORT EnableTextureByNativeTextureAssetPlugin(int instanceId) {
    NativeTextureAssetCollection* collection = NativeTextureAssetCollection::getInstance();
    BaseNativeTextureAssetPlugin* textureAsset = collection->findByInstanceId(instanceId);
    if (NULL == textureAsset) {
        return false;
    }
    return true;
}
void UNITY_INTERFACE_API RenderTextureByNativeRendererPlugin(int eventID) {
    if (NULL == nativeRendererPlugin) {
        return;
    }
    NativeTextureAssetCollection* collection = NativeTextureAssetCollection::getInstance();
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
        nativeRendererPlugin->render(textureAsset);
        ++it;
    }
    return;
}
UnityRenderingEvent UNITY_INTERFACE_EXPORT GetRenderTextureCallbackByNativeRendererPlugin() { return RenderTextureByNativeRendererPlugin; }
