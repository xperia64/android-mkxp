LOCAL_PATH := $(call my-dir)/ogg

include $(CLEAR_VARS)

LOCAL_MODULE := ogg

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../vorbis-include

LOCAL_CFLAGS := -ffast-math -fsigned-char
ifeq ($(TARGET_ARCH),arm)
	LOCAL_CFLAGS += -march=armv6 -marm -mfloat-abi=softfp -mfpu=vfp
endif


LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/src/bitwise.c \
	$(LOCAL_PATH)/src/framing.c

include $(BUILD_STATIC_LIBRARY)
