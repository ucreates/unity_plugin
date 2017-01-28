//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "NativeTextureAssetCollection.h"
NativeTextureAssetCollection* NativeTextureAssetCollection::instance = NULL;
NativeTextureAssetCollection::NativeTextureAssetCollection() { this->nativeTextureAssetMap = new std::map<int, BaseNativeTextureAssetPlugin*>(); }
NativeTextureAssetCollection::~NativeTextureAssetCollection() {
    for (std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = this->nativeTextureAssetMap->begin(); it != this->nativeTextureAssetMap->end(); ++it) {
        delete it->second;
        it->second = NULL;
    }
}
NativeTextureAssetCollection* NativeTextureAssetCollection::getInstance() {
    if (NULL == NativeTextureAssetCollection::instance) {
        NativeTextureAssetCollection::instance = new NativeTextureAssetCollection();
    }
    return NativeTextureAssetCollection::instance;
}
BaseNativeTextureAssetPlugin* NativeTextureAssetCollection::findByInstanceId(int instanceId) {
    std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = this->nativeTextureAssetMap->find(instanceId);
    if (this->nativeTextureAssetMap->end() == it) {
        return NULL;
    }
    return it->second;
}
bool NativeTextureAssetCollection::add(int instanceId, BaseNativeTextureAssetPlugin* nativeTextureAsset) {
    std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = this->nativeTextureAssetMap->find(instanceId);
    if (this->nativeTextureAssetMap->end() != it) {
        return false;
    }
    this->nativeTextureAssetMap->insert(std::map<int, BaseNativeTextureAssetPlugin*>::value_type(instanceId, nativeTextureAsset));
    return true;
}
void NativeTextureAssetCollection::clear() {
    for (std::map<int, BaseNativeTextureAssetPlugin*>::iterator it = this->nativeTextureAssetMap->begin(); it != this->nativeTextureAssetMap->end(); ++it) {
        it->second->destroy();
    }
}
void NativeTextureAssetCollection::destroy() {
    if (NULL == NativeTextureAssetCollection::instance) {
        return;
    }
    delete NativeTextureAssetCollection::instance;
    NativeTextureAssetCollection::instance = NULL;
    return;
}
std::map<int, BaseNativeTextureAssetPlugin*>* NativeTextureAssetCollection::getCollection() { return this->nativeTextureAssetMap; }
