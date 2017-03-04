//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include "jpeglib.h"
#include "JpegNativeTextureAssetPlugin.h"
JpegNativeTextureAssetPlugin::JpegNativeTextureAssetPlugin() {}
JpegNativeTextureAssetPlugin::~JpegNativeTextureAssetPlugin() {}
bool JpegNativeTextureAssetPlugin::load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) {
    FILE* fp = fopen(textureAssetPath, "rb");
    if (NULL == fp) {
        return false;
    }
    unsigned char sof[2];
    unsigned char dimension[4];
    while (true) {
        fread(sof, 1, 2, fp);
        if (sof[0] == 0xff && (sof[1] == 0xc0 || sof[1] == 0xc2)) {
            fread(dimension, 1, 3, fp);
            fread(dimension, 1, 4, fp);
            unsigned char upper = dimension[2];
            unsigned char downer = dimension[3];
            this->width = upper << 8 | downer;
            upper = dimension[0];
            downer = dimension[1];
            this->height = upper << 8 | downer;
            break;
        }
    }
    fseek(fp, 0, SEEK_SET);
    static auto callback = [](j_common_ptr common)->void {
        char buffer[JMSG_LENGTH_MAX];
        (*common->err->format_message)(common, buffer);
        // embed your log message for some errors in libjpeg.
        return;
    };
    jpeg_decompress_struct decompressInfo;
    jpeg_error_mgr jerr;
    decompressInfo.err = jpeg_std_error(&jerr);
    decompressInfo.err->output_message = callback;
    jpeg_CreateDecompress(&decompressInfo, JpegNativeTextureAssetPlugin::LIBJPEG_VERSION, JpegNativeTextureAssetPlugin::DUMMY_DECOMPRESS_STRUCT_SIZE);
    jpeg_stdio_src(&decompressInfo, fp);
    int ret = jpeg_read_header(&decompressInfo, TRUE);
    if (JPEG_HEADER_OK != ret) {
        return false;
    }
    jpeg_start_decompress(&decompressInfo);
#if UNITY_IPHONE
    if (JCS_RGB != decompressInfo.out_color_space) {
        return false;
    }
#endif
#if UNITY_ANDROID
    if (3 != decompressInfo.out_color_space) {
        return false;
    }
#endif
    int bufferSize = this->width * this->height * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
    int stride = sizeof(char) * this->width * BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
    unsigned char* bufferPerStride = (unsigned char*)malloc(stride);
    this->data = (unsigned char*)malloc(bufferSize);
    this->alphaChannel = false;
    int didx = 0;
    for (int y = 0; y < this->height; y++) {
        int sidx = 0;
        jpeg_read_scanlines(&decompressInfo, &bufferPerStride, 1);
        for (int x = 0; x < this->width; x++) {
            int tr = didx;
            int tg = didx + 1;
            int tb = didx + 2;
            int fr = sidx;
            int fg = sidx + 1;
            int fb = sidx + 2;
            this->data[tr] = bufferPerStride[fr];
            this->data[tg] = bufferPerStride[fg];
            this->data[tb] = bufferPerStride[fb];
            didx += BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
            sidx += BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
        }
    }
    free(bufferPerStride);
    jpeg_finish_decompress(&decompressInfo);
    jpeg_destroy_decompress(&decompressInfo);
    fclose(fp);
    return true;
}
