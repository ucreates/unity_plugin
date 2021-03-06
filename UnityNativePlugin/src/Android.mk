LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
NDK_APP_DST_DIR="${PWD}/../../UnityPlugin/Assets/Plugins/Android/"
LOCAL_MODULE    := libyuv
LOCAL_SRC_FILES := ../lib/android/libyuv.so
include $(PREBUILT_SHARED_LIBRARY)
include $(CLEAR_VARS)
NDK_APP_DST_DIR="${PWD}/../../UnityPlugin/Assets/Plugins/Android/"
LOCAL_MODULE    := libjpeg
LOCAL_SRC_FILES := ../lib/android/libjpeg.so
include $(PREBUILT_SHARED_LIBRARY)
include $(CLEAR_VARS)
NDK_APP_DST_DIR="${PWD}/../../UnityPlugin/Assets/Plugins/Android/"
LOCAL_MODULE    := libpng
LOCAL_SRC_FILES := ../lib/android/libpng.so
include $(PREBUILT_SHARED_LIBRARY)
include $(CLEAR_VARS)
NDK_APP_DST_DIR="${PWD}/../../UnityPlugin/Assets/Plugins/Android/"
LOCAL_MODULE = UnityNativePlugin
LOCAL_SRC_FILES := UnityNativePlugin.cpp 
LOCAL_SRC_FILES += $(shell find $(LOCAL_PATH)/core/ -name '*.cpp')
LOCAL_SRC_FILES += $(shell find $(LOCAL_PATH)/frontend/ -name '*.cpp')
LOCAL_SRC_FILES := $(subst jni/,, $(LOCAL_SRC_FILES))
LOCAL_C_INCLUDES := $(shell find $(LOCAL_PATH)/ -type d)
LOCAL_C_INCLUDES += $(shell find $(LOCAL_PATH)/../lib -type d)
LOCAL_LDLIBS    := -llog -lGLESv1_CM -lGLESv2 -lGLESv3
LOCAL_SHARED_LIBRARIES += libyuv libjpeg libpng
include $(BUILD_SHARED_LIBRARY)
