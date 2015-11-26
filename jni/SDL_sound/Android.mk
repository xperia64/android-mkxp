LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := SDL2_sound

LOCAL_C_INCLUDES := $(LOCAL_PATH)  $(LOCAL_PATH)/../SDL/include $(LOCAL_PATH)/include $(LOCAL_PATH)/decoders $(LOCAL_PATH)/../vorbis-include			                                       
LOCAL_CFLAGS := -O3 -DHAVE_CONFIG_H

LOCAL_CPP_EXTENSION := .cpp

LOCAL_SRC_FILES := $(notdir $(wildcard $(LOCAL_PATH)/*.c)) \
						$(LOCAL_PATH)/decoders/aiff.c \
						$(LOCAL_PATH)/decoders/au.c \
						$(LOCAL_PATH)/decoders/ogg.c \
						$(LOCAL_PATH)/decoders/raw.c \
						$(LOCAL_PATH)/decoders/wav.c

#LOCAL_STATIC_LIBRARIES := ogg vorbis

LOCAL_LDLIBS :=

include $(BUILD_STATIC_LIBRARY)


