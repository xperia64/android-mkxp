# libsigc++/jni/Android.mk

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
 

LOCAL_MODULE     := libsigc++                 # name of your module

LOCAL_CPP_EXTENSION := .cc

LOCAL_CFLAGS := -O3
LOCAL_SRC_FILES := sigc++/signal.cc sigc++/signal_base.cc sigc++/trackable.cc \
    sigc++/functors/slot_base.cc sigc++/adaptors/lambda/lambda.cc \
    sigc++/connection.cc sigc++/functors/slot.cc

LOCAL_C_INCLUDES := sigc++

#include $(BUILD_SHARED_LIBRARY)            # uncomment this line to build a shared library
include $(BUILD_STATIC_LIBRARY)           # here, we are building a static library
