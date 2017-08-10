#LOCAL_PATH:= $(call my-dir)

L_PATH := $(call my-dir)
include $(L_PATH)/physfs.mk
include $(L_PATH)/libogg.mk
include $(L_PATH)/pixman.mk
include $(L_PATH)/SDL.mk
include $(L_PATH)/SDL_ttf.mk
include $(L_PATH)/boost.program_options/Android.mk
include $(L_PATH)/fluidsynth/Android.mk
include $(L_PATH)/glib/Android.mk
include $(L_PATH)/libsigc++/Android.mk
include $(L_PATH)/mkxp/Android.mk
include $(L_PATH)/mkxp-wrapper/Android.mk
include $(L_PATH)/OpenAL/Android.mk
include $(L_PATH)/ruby/Android.mk
include $(L_PATH)/SDL_image.mk
include $(L_PATH)/SDL_sound.mk
include $(L_PATH)/libvorbis/Android.mk

#include $(call all-subdir-makefiles)

#include $(L_PATH)/SDL_ttf/Android.mk
#include $(L_PATH)/SDL_ttf/Android.mk

#include $(LOCAL_PATH)/mkxp/Android.mk
