LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
NDK_APP_DST_DIR="${PWD}/../../Assets/Plugins/Android/"
LOCAL_MODULE = UnityNativePlugin
LOCAL_SRC_FILES := UnityNativePlugin.cpp 
LOCAL_SRC_FILES += $(shell find $(LOCAL_PATH)/core/ -name '*.cpp')
LOCAL_SRC_FILES += $(shell find $(LOCAL_PATH)/frontend/ -name '*.cpp')
LOCAL_SRC_FILES := $(subst jni/,, $(LOCAL_SRC_FILES))
LOCAL_C_INCLUDES := $(shell find $(LOCAL_PATH)/ -type d)
LOCAL_LDLIBS    := -llog -lGLESv1_CM -lGLESv2
include $(BUILD_SHARED_LIBRARY)
