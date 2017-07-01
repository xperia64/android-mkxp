LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := mkxp_wrapper

LOCAL_CPP_EXTENSION := .cpp

LOCAL_SRC_FILES:= wrapper.c

LOCAL_LDLIBS = -llog
include $(BUILD_SHARED_LIBRARY)
