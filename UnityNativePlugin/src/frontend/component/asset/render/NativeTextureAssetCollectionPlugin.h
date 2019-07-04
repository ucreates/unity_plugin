//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef NativeTextureAssetCollectionPlugin_h
#define NativeTextureAssetCollectionPlugin_h
#include <map>
#include "BaseNativeTextureAssetPlugin.h"
class NativeTextureAssetCollectionPlugin {
   public:
    ~NativeTextureAssetCollectionPlugin();
    static NativeTextureAssetCollectionPlugin* getInstance();
    bool add(int instanceId, BaseNativeTextureAssetPlugin* nativeTextureAsset);
    BaseNativeTextureAssetPlugin* findByInstanceId(int instanceId);
    void clear();
    static void destroy();
    std::map<int, BaseNativeTextureAssetPlugin*>* getCollection();
   private:
    std::map<int, BaseNativeTextureAssetPlugin*>* nativeTextureAssetMap;
    static NativeTextureAssetCollectionPlugin* instance;
    NativeTextureAssetCollectionPlugin();
};
#endif /* NativeTextureAssetCollectionPlugin_h */
