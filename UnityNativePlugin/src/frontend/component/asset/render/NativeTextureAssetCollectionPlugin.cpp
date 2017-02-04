//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "NativeTextureAssetCollectionPlugin.h"
NativeTextureAssetCollectionPlugin* NativeTextureAssetCollectionPlugin::instance = NULL;
NativeTextureAssetCollectionPlugin::NativeTextureAssetCollectionPlugin() { this->nativeTextureAssetMap = new std::map<int, BaseNativeTextureAssetPlugin*>(); }
NativeTextureAssetCollectionPlugin::~NativeTextureAssetCollectionPlugin() {
    for (std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = this->nativeTextureAssetMap->begin(); it != this->nativeTextureAssetMap->end(); ++it) {
        delete it->second;
        it->second = NULL;
    }
}
NativeTextureAssetCollectionPlugin* NativeTextureAssetCollectionPlugin::getInstance() {
    if (NULL == NativeTextureAssetCollectionPlugin::instance) {
        NativeTextureAssetCollectionPlugin::instance = new NativeTextureAssetCollectionPlugin();
    }
    return NativeTextureAssetCollectionPlugin::instance;
}
BaseNativeTextureAssetPlugin* NativeTextureAssetCollectionPlugin::findByInstanceId(int instanceId) {
    std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = this->nativeTextureAssetMap->find(instanceId);
    if (this->nativeTextureAssetMap->end() == it) {
        return NULL;
    }
    return it->second;
}
bool NativeTextureAssetCollectionPlugin::add(int instanceId, BaseNativeTextureAssetPlugin* nativeTextureAsset) {
    std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = this->nativeTextureAssetMap->find(instanceId);
    if (this->nativeTextureAssetMap->end() != it) {
        return false;
    }
    this->nativeTextureAssetMap->insert(std::map<int, BaseNativeTextureAssetPlugin*>::value_type(instanceId, nativeTextureAsset));
    return true;
}
void NativeTextureAssetCollectionPlugin::clear() {
    for (std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = this->nativeTextureAssetMap->begin(); it != this->nativeTextureAssetMap->end(); ++it) {
        it->second->destroy();
    }
}
void NativeTextureAssetCollectionPlugin::destroy() {
    if (NULL == NativeTextureAssetCollectionPlugin::instance) {
        return;
    }
    delete NativeTextureAssetCollectionPlugin::instance;
    NativeTextureAssetCollectionPlugin::instance = NULL;
    return;
}
std::map<int, BaseNativeTextureAssetPlugin*>* NativeTextureAssetCollectionPlugin::getCollection() { return this->nativeTextureAssetMap; }
