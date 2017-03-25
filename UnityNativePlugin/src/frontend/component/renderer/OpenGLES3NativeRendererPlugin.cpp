//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "OpenGLES3NativeRendererPlugin.h"
#include "TextureAssetValidatorPlugin.h"
OpenGLES3NativeRendererPlugin::OpenGLES3NativeRendererPlugin() {}
OpenGLES3NativeRendererPlugin::~OpenGLES3NativeRendererPlugin() {}
void OpenGLES3NativeRendererPlugin::render(void* texturePtr, int width, int height, unsigned char* data, bool useAlphaChannel) {
    GLuint textureId = (GLuint)(size_t)texturePtr;
    this->render(textureId, width, height, data, useAlphaChannel);
    return;
}
void OpenGLES3NativeRendererPlugin::render(unsigned int textureId, int width, int height, unsigned char* data, bool useAlphaChannel) {
    GLenum format = GL_RGB;
    if (false != useAlphaChannel) {
        format = GL_RGBA;
    }
    glBindTexture(GL_TEXTURE_2D, textureId);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, width, height, format, GL_UNSIGNED_BYTE, data);
    return;
}
void OpenGLES3NativeRendererPlugin::render(BaseNativeTextureAssetPlugin* textureAsset) {
    if (false == TextureAssetValidatorPlugin::isValid(textureAsset)) {
        return;
    }
    GLuint textureId = textureAsset->getTextureId();
    int width = textureAsset->getWidth();
    int height = textureAsset->getHeight();
    unsigned char* data = textureAsset->getData();
    bool useAlphaChannel = textureAsset->enableAlphaChannel();
    this->render(textureId, width, height, data, useAlphaChannel);
    return;
}
