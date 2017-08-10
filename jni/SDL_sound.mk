LOCAL_PATH := $(call my-dir)/SDL_sound

include $(CLEAR_VARS)

LOCAL_MODULE := SDL2_sound

LOCAL_C_INCLUDES := $(LOCAL_PATH)  $(LOCAL_PATH)/include $(LOCAL_PATH)/decoders $(LOCAL_PATH)/decoders/libmpg123
LOCAL_CFLAGS := -O3 -DHAVE_CONFIG_H -DREAL_IS_FLOAT -DOPT_GENERIC -DMPG123_NO_CONFIGURE -DSOUND_SUPPORTS_MPG123

LOCAL_CPP_EXTENSION := .cpp

LOCAL_SRC_FILES := $(notdir $(wildcard $(LOCAL_PATH)/*.c)) \
						$(LOCAL_PATH)/decoders/aiff.c \
						$(LOCAL_PATH)/decoders/au.c \
						$(LOCAL_PATH)/decoders/ogg.c \
						$(LOCAL_PATH)/decoders/raw.c \
						$(LOCAL_PATH)/decoders/wav.c \
						$(LOCAL_PATH)/decoders/mpg123.c \
						$(LOCAL_PATH)/decoders/libmpg123/compat.c \
						$(LOCAL_PATH)/decoders/libmpg123/parse.c \
						$(LOCAL_PATH)/decoders/libmpg123/frame.c \
						$(LOCAL_PATH)/decoders/libmpg123/format.c \
						$(LOCAL_PATH)/decoders/libmpg123/decode_2to1.c \
						$(LOCAL_PATH)/decoders/libmpg123/decode_4to1.c \
						$(LOCAL_PATH)/decoders/libmpg123/decode_ntom.c \
						$(LOCAL_PATH)/decoders/libmpg123/equalizer.c \
						$(LOCAL_PATH)/decoders/libmpg123/icy.c \
						$(LOCAL_PATH)/decoders/libmpg123/icy2utf8.c \
						$(LOCAL_PATH)/decoders/libmpg123/id3.c \
						$(LOCAL_PATH)/decoders/libmpg123/layer1.c \
						$(LOCAL_PATH)/decoders/libmpg123/layer2.c \
						$(LOCAL_PATH)/decoders/libmpg123/layer3.c \
						$(LOCAL_PATH)/decoders/libmpg123/optimize.c \
						$(LOCAL_PATH)/decoders/libmpg123/readers.c \
						$(LOCAL_PATH)/decoders/libmpg123/tabinit.c \
						$(LOCAL_PATH)/decoders/libmpg123/stringbuf.c \
						$(LOCAL_PATH)/decoders/libmpg123/libmpg123.c \
						$(LOCAL_PATH)/decoders/libmpg123/index.c \
						$(LOCAL_PATH)/decoders/libmpg123/dct64.c \
						$(LOCAL_PATH)/decoders/libmpg123/decode.c 


LOCAL_STATIC_LIBRARIES := ogg vorbis SDL2_static

LOCAL_LDLIBS :=

include $(BUILD_STATIC_LIBRARY)


