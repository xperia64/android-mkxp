LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(TARGET_ARCH_ABI),armeabi)
  # ARMv5, used fixed point math
  LOCAL_CFLAGS += -marm -DOPENAL_FIXED_POINT -DOPENAL_FIXED_POINT_SHIFT=16
endif
ifeq ($(TARGET_ARCH_ABI), armeabi)
	LOCAL_CFLAGS += -DARCH_32BIT
else ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
	LOCAL_CFLAGS += -DARCH_32BIT
else ifeq ($(TARGET_ARCH_ABI), x86)
	LOCAL_CFLAGS += -DARCH_32BIT
else ifeq ($(TARGET_ARCH_ABI), mips)
	LOCAL_CFLAGS += -DARCH_32BIT
endif

LOCAL_MODULE:= OpenAL
MAX_SOURCES_LOW ?= 4
MAX_SOURCES_START ?= 8
MAX_SOURCES_HIGH ?= 64
LOCAL_CFLAGS += -DMAX_SOURCES_LOW=$(MAX_SOURCES_LOW) -DMAX_SOURCES_START=$(MAX_SOURCES_START) -DMAX_SOURCES_HIGH=$(MAX_SOURCES_HIGH) -DAL_ALEXT_PROTOTYPES -DANDROID -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -DHAVE_GCC_VISIBLITY -O3 -DPOST_FROYO

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include \
					$(LOCAL_PATH)/OpenAL32/Include


LOCAL_SRC_FILES :=  \
                    $(LOCAL_PATH)/Alc/android.c              \
                    $(LOCAL_PATH)/OpenAL32/alAuxEffectSlot.c \
                    $(LOCAL_PATH)/OpenAL32/alBuffer.c        \
                    $(LOCAL_PATH)/OpenAL32/alDatabuffer.c    \
                    $(LOCAL_PATH)/OpenAL32/alEffect.c        \
                    $(LOCAL_PATH)/OpenAL32/alError.c         \
                    $(LOCAL_PATH)/OpenAL32/alExtension.c     \
                    $(LOCAL_PATH)/OpenAL32/alFilter.c        \
                    $(LOCAL_PATH)/OpenAL32/alListener.c      \
                    $(LOCAL_PATH)/OpenAL32/alSource.c        \
                    $(LOCAL_PATH)/OpenAL32/alState.c         \
                    $(LOCAL_PATH)/OpenAL32/alThunk.c         \
                    $(LOCAL_PATH)/Alc/ALc.c                  \
                    $(LOCAL_PATH)/Alc/alcConfig.c            \
                    $(LOCAL_PATH)/Alc/alcEcho.c              \
                    $(LOCAL_PATH)/Alc/alcModulator.c         \
                    $(LOCAL_PATH)/Alc/alcReverb.c            \
                    $(LOCAL_PATH)/Alc/alcRing.c              \
                    $(LOCAL_PATH)/Alc/alcThread.c            \
                    $(LOCAL_PATH)/Alc/ALu.c                  \
                    $(LOCAL_PATH)/Alc/bs2b.c                 \
                    $(LOCAL_PATH)/Alc/null.c                 \
                    $(LOCAL_PATH)/Alc/panning.c              \
                    $(LOCAL_PATH)/Alc/mixer.c                \
                    $(LOCAL_PATH)/Alc/audiotrack.c           \
		    $(LOCAL_PATH)/Alc/opensles.c

#LOCAL_LDLIBS := -llog
include $(BUILD_STATIC_LIBRARY)

