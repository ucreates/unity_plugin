//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "BGRAPlugin.h"
unsigned char* BGRAPlugin::convertToRGBA(const unsigned char* originSrc, unsigned char* destSrc, int width, int height, int pixelPerBytes) {
    int offset = 0;
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            int ridx = offset;
            int gidx = offset + 1;
            int bidx = offset + 2;
            int aidx = offset + 3;
            destSrc[ridx] = originSrc[bidx];
            destSrc[gidx] = originSrc[gidx];
            destSrc[bidx] = originSrc[ridx];
            destSrc[aidx] = originSrc[aidx];
            offset += pixelPerBytes;
        }
    }
    return destSrc;
}
