//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef NativeTextureAssetCollection_h
#define NativeTextureAssetCollection_h
#include <map>
#include "BaseNativeTextureAssetPlugin.h"
class NativeTextureAssetCollection {
   public:
    ~NativeTextureAssetCollection();
    static NativeTextureAssetCollection* getInstance();
    bool add(int instanceId, BaseNativeTextureAssetPlugin* nativeTextureAsset);
    BaseNativeTextureAssetPlugin* findByInstanceId(int instanceId);
    void clear();
    static void destroy();
    std::map<int, BaseNativeTextureAssetPlugin*>* getCollection();
   private:
    std::map<int, BaseNativeTextureAssetPlugin*>* nativeTextureAssetMap;
    static NativeTextureAssetCollection* instance;
    NativeTextureAssetCollection();
};
#endif /* NativeTextureAssetCollection_h */
