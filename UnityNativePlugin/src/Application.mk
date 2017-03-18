LOCAL_PATH = $(call my-dir)
APP_STL          := stlport_static
APP_OPTIM        := release
APP_ABI          := armeabi
APP_PLATFORM     := android-18
APP_CPPFLAGS     := -frtti -DCC_ENABLE_CHIPMUNK_INTEGRATION=1 -std=c++11 -fsigned-char
APP_BUILD_SCRIPT := $(LOCAL_PATH)/Android.mk
