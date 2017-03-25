//======================================================================
// Project Name    : unity plugin
//
// Copyright © 2017 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
#include "NativeRendererFactoryPlugin.h"
#include "OpenGLES2NativeRendererPlugin.h"
#include "OpenGLES3NativeRendererPlugin.h"
#include "MetalNativeRendererPlugin.h"
BaseNativeRendererPlugin* NativeRendererFactoryPlugin::factoryMethod(UnityGfxRenderer remdererType) {
    BaseNativeRendererPlugin* renderer = NULL;
    switch (remdererType) {
        case kUnityGfxRendererOpenGLES20:
            renderer = new OpenGLES2NativeRendererPlugin();
            break;
        case kUnityGfxRendererOpenGLES30:
            renderer = new OpenGLES3NativeRendererPlugin();
            break;
        case kUnityGfxRendererMetal:
            renderer = new MetalNativeRendererPlugin();
            break;
        default:
            break;
    }
    return renderer;
}
