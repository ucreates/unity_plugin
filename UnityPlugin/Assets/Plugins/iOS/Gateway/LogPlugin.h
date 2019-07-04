//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef LogPlugin_h
#define LogPlugin_h
#include <string>
class LogPlugin {
   public:
    static void info(std::string info);
    static void info(int info);
    static void info(const char* info);
    static void info(unsigned const char* info);
};
#endif /* LogPlugin_h */
