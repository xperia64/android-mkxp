LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := vorbis

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../vorbis-include

LOCAL_CFLAGS := -ffast-math -fsigned-char
ifeq ($(TARGET_ARCH),arm)
	LOCAL_CFLAGS += -march=armv6 -marm -mfloat-abi=softfp -mfpu=vfp
endif
LOCAL_STATIC_LIBRARIES := ogg

LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/mdct.c		\
	$(LOCAL_PATH)/smallft.c	\
	$(LOCAL_PATH)/block.c		\
	$(LOCAL_PATH)/envelope.c	\
	$(LOCAL_PATH)/window.c	\
	$(LOCAL_PATH)/lsp.c		\
	$(LOCAL_PATH)/lpc.c		\
	$(LOCAL_PATH)/analysis.c	\
	$(LOCAL_PATH)/synthesis.c	\
	$(LOCAL_PATH)/psy.c		\
	$(LOCAL_PATH)/info.c		\
	$(LOCAL_PATH)/floor1.c	\
	$(LOCAL_PATH)/floor0.c	\
	$(LOCAL_PATH)/res0.c		\
	$(LOCAL_PATH)/mapping0.c	\
	$(LOCAL_PATH)/registry.c	\
	$(LOCAL_PATH)/codebook.c	\
	$(LOCAL_PATH)/sharedbook.c	\
	$(LOCAL_PATH)/lookup.c	\
	$(LOCAL_PATH)/bitrate.c	\
	$(LOCAL_PATH)/vorbisfile.c	\
	$(LOCAL_PATH)/vorbisenc.c

include $(BUILD_STATIC_LIBRARY)
