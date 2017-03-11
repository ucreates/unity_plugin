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
#include "png.h"
#include "PngNativeTextureAssetPlugin.h"
PngNativeTextureAssetPlugin::PngNativeTextureAssetPlugin() {}
PngNativeTextureAssetPlugin::~PngNativeTextureAssetPlugin() {}
bool PngNativeTextureAssetPlugin::load(const char* textureAssetPath, int textureWidth, int textureHeight, bool useAlphaChannel) {
    FILE* fp = fopen(textureAssetPath, "rb");
    if (NULL == fp) {
        return false;
    }
    unsigned char header[PngNativeTextureAssetPlugin::HEADER_SIZE_PER_BYTE];
    fread(header, 1, PngNativeTextureAssetPlugin::HEADER_SIZE_PER_BYTE, fp);
    png_structp pngPtr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    if (NULL == pngPtr) {
        fclose(fp);
        return false;
    }
    png_infop pngStartInfoPtr = png_create_info_struct(pngPtr);
    if (NULL == pngStartInfoPtr) {
        png_destroy_read_struct(&pngPtr, (png_infopp)NULL, (png_infopp)NULL);
        fclose(fp);
        return false;
    }
    png_infop pngEndInfoPtr = png_create_info_struct(pngPtr);
    if (NULL == pngEndInfoPtr) {
        png_destroy_read_struct(&pngPtr, &pngStartInfoPtr, (png_infopp)NULL);
        fclose(fp);
        return false;
    }
    int ret = setjmp(png_jmpbuf(pngPtr));
    if (0 != ret) {
        png_destroy_read_struct(&pngPtr, &pngStartInfoPtr, &pngEndInfoPtr);
        fclose(fp);
        return false;
    }
    png_init_io(pngPtr, fp);
    png_set_sig_bytes(pngPtr, PngNativeTextureAssetPlugin::HEADER_SIZE_PER_BYTE);
    png_read_info(pngPtr, pngStartInfoPtr);
    this->width = png_get_image_width(pngPtr, pngStartInfoPtr);
    this->height = png_get_image_height(pngPtr, pngStartInfoPtr);
    int colorType = png_get_color_type(pngPtr, pngStartInfoPtr);
    png_read_update_info(pngPtr, pngStartInfoPtr);
    int dataBufferSize = sizeof(unsigned char*) * this->height;
    unsigned char** stridePtr = (unsigned char**)malloc(dataBufferSize);
    png_size_t strideBufferSize = png_get_rowbytes(pngPtr, pngStartInfoPtr);
    for (int y = 0; y < this->height; y++) {
        stridePtr[y] = (unsigned char*)malloc(strideBufferSize);
    }
    png_read_image(pngPtr, stridePtr);
    int colorPerPixel = 0;
    if (PNG_COLOR_TYPE_RGB == colorType) {
        colorPerPixel = BaseNativeTextureAssetPlugin::RGB_SIZE_PER_PIXEL;
        this->alphaChannel = false;
    } else if (PNG_COLOR_TYPE_RGBA == colorType) {
        colorPerPixel = BaseNativeTextureAssetPlugin::ARGB_SIZE_PER_PIXEL;
        this->alphaChannel = true;
    } else {
        return false;
    }
    dataBufferSize = this->width * this->height * colorPerPixel;
    this->data = (unsigned char*)malloc(dataBufferSize);
    int idx = 0;
    for (int y = 0; y < this->height; y++) {
        unsigned char* strideBuffer = stridePtr[y];
        for (int x = 0; x < this->width; x++) {
            unsigned char* color = &strideBuffer[x * colorPerPixel];
            int ridx = idx;
            int gidx = idx + 1;
            int bidx = idx + 2;
            this->data[ridx] = color[0];
            this->data[gidx] = color[1];
            this->data[bidx] = color[2];
            if (PNG_COLOR_TYPE_RGBA == colorType) {
                int aidx = idx + 3;
                this->data[aidx] = color[3];
            }
            idx += colorPerPixel;
        }
    }
    for (int y = 0; y < this->height; y++) {
        free(stridePtr[y]);
    }
    free(stridePtr);
    png_destroy_read_struct(&pngPtr, &pngStartInfoPtr, &pngEndInfoPtr);
    fclose(fp);
    return true;
}
