//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include <regex.h>
#include "ExtensionPlugin.h"
bool ExtensionPlugin::hasExtension(const char* filePath, const char* extensionName) {
    regex_t regexBuffer;
    int ret = regcomp(&regexBuffer, extensionName, REG_EXTENDED | REG_NEWLINE);
    if (0 != ret) {
        regfree(&regexBuffer);
        return false;
    }
    regmatch_t patternMatch[1];
    int size = sizeof(patternMatch) / sizeof(regmatch_t);
    ret = regexec(&regexBuffer, filePath, size, patternMatch, 0);
    if (0 != ret) {
        regfree(&regexBuffer);
        return false;
    }
    regfree(&regexBuffer);
    return true;
}
