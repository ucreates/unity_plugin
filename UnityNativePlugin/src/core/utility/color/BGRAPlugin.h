//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#ifndef BGRAPlugin_h
#define BGRAPlugin_h
class BGRAPlugin {
   public:
    static unsigned char* convertToRGBA(const unsigned char* originSrc, unsigned char* destSrc, int width, int height, int pixelPerBytes);
};
#endif /* BGRAPlugin_h */
