//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include <sstream>
#include "PlatformBase.h"
#if UNITY_ANDROID
#include <android/log.h>
#endif
#include "LogPlugin.h"
#include "TagPlugin.h"
void LogPlugin::info(std::string info) {
    LogPlugin::info(info.c_str());
    return;
}
void LogPlugin::info(int info) {
    std::stringstream stringStream;
    stringStream << info;
    LogPlugin::info(stringStream.str());
    return;
}
void LogPlugin::info(const char* info) {
#if UNITY_IPHONE
    char log[UINT16_MAX];
    sprintf(log, "%s::%s\n", TagPlugin::UNITY_PLUGIN_IDENTIFIER, info);
    printf("%s", log);
#elif UNITY_ANDROID
    __android_log_print(ANDROID_LOG_DEBUG, TagPlugin::UNITY_PLUGIN_IDENTIFIER, "%s", info);
#endif
    return;
}
void LogPlugin::info(unsigned const char* info) {
#if UNITY_IPHONE
    char log[UINT16_MAX];
    sprintf(log, "%s::%s\n", TagPlugin::UNITY_PLUGIN_IDENTIFIER, info);
    printf("%s", log);
#elif UNITY_ANDROID
    __android_log_print(ANDROID_LOG_DEBUG, TagPlugin::UNITY_PLUGIN_IDENTIFIER, "%s", info);
#endif
    return;
}
