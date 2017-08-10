LOCAL_PATH := $(call my-dir)/pixman

LIBPIXMAN_SRC= \
           $(LOCAL_PATH)/pixman/pixman.c                       \
	       $(LOCAL_PATH)/pixman/pixman-access.c                \
	       $(LOCAL_PATH)/pixman/pixman-access-accessors.c      \
		   $(LOCAL_PATH)/pixman/pixman-arm.c                   \
		   $(LOCAL_PATH)/pixman/pixman-combine32.c             \
		   $(LOCAL_PATH)/pixman/pixman-combine-float.c         \
		   $(LOCAL_PATH)/pixman/pixman-filter.c                \
		   $(LOCAL_PATH)/pixman/pixman-glyph.c                 \
		   $(LOCAL_PATH)/pixman/pixman-mips.c                  \
		   $(LOCAL_PATH)/pixman/pixman-ppc.c                   \
		   $(LOCAL_PATH)/pixman/pixman-x86.c                   \
	       $(LOCAL_PATH)/pixman/pixman-gradient-walker.c       \
	       $(LOCAL_PATH)/pixman/pixman-region16.c              \
	       $(LOCAL_PATH)/pixman/pixman-region32.c              \
	       $(LOCAL_PATH)/pixman/pixman-image.c                 \
	       $(LOCAL_PATH)/pixman/pixman-implementation.c        \
	       $(LOCAL_PATH)/pixman/pixman-general.c               \
	       $(LOCAL_PATH)/pixman/pixman-fast-path.c             \
	       $(LOCAL_PATH)/pixman/pixman-solid-fill.c            \
	       $(LOCAL_PATH)/pixman/pixman-conical-gradient.c      \
	       $(LOCAL_PATH)/pixman/pixman-linear-gradient.c       \
	       $(LOCAL_PATH)/pixman/pixman-radial-gradient.c       \
	       $(LOCAL_PATH)/pixman/pixman-bits-image.c            \
	       $(LOCAL_PATH)/pixman/pixman-utils.c                 \
	       $(LOCAL_PATH)/pixman/pixman-edge.c                  \
	       $(LOCAL_PATH)/pixman/pixman-edge-accessors.c        \
	       $(LOCAL_PATH)/pixman/pixman-trap.c                  \
		   $(LOCAL_PATH)/pixman/pixman-mmx.c                   \
	       $(LOCAL_PATH)/pixman/pixman-timer.c                 \
	       $(LOCAL_PATH)/pixman/pixman-matrix.c                \
	       $(LOCAL_PATH)/pixman/pixman-noop.c                  \

ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
	LOCAL_SRC_FILES += pixman/pixman/pixman-arm-simd.c \
		$(LOCAL_PATH)/pixman/pixman-arm-simd-asm.S \
		$(LOCAL_PATH)/pixman/pixman-arm-neon.c \
		$(LOCAL_PATH)/pixman/pixman-arm-neon-asm.S \
		$(LOCAL_PATH)/pixman/pixman-arm-neon-asm-bilinear.S \
	LIBPIXMAN_CFLAGS += -DUSE_ARM_NEON -DUSE_ARM_SIMD

endif
LIBPIXMAN_CFLAGS:=-D_USE_MATH_DEFINES -DPIXMAN_NO_TLS -DPACKAGE="android-cairo" -include "limits.h"



include $(CLEAR_VARS)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/pixman \
		   $(LOCAL_PATH)/../pixman-extra \
		   $(LOCAL_PATH)

LOCAL_MODULE    := pixman
LOCAL_CFLAGS    := -O2 $(LIBPIXMAN_CFLAGS) \
        -Wno-missing-field-initializers
#LOCAL_LDFLAGS   := 
LOCAL_SRC_FILES := $(LIBPIXMAN_SRC)
LOCAL_STATIC_LIBRARIES := cpufeatures

include $(BUILD_STATIC_LIBRARY)
$(call import-module,android/cpufeatures)
