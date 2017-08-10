# To get a huge advantage on compilation time,
# copy all makefiles to their subfolders after
# cloning and rename each to Android.mk and
# then uncomment the following lines and 
# comment the rest.

#include $(call all-subdir-makefiles)

L_PATH := $(call my-dir)

include $(L_PATH)/mkxp.mk
include $(L_PATH)/mkxp-wrapper/Android.mk
include $(L_PATH)/physfs.mk
include $(L_PATH)/libogg.mk
include $(L_PATH)/pixman.mk
include $(L_PATH)/SDL.mk
include $(L_PATH)/SDL_ttf.mk
include $(L_PATH)/SDL_image.mk
include $(L_PATH)/SDL_sound.mk

include $(L_PATH)/boost.program_options/Android.mk
include $(L_PATH)/fluidsynth/Android.mk
include $(L_PATH)/glib/Android.mk
include $(L_PATH)/libsigc++/Android.mk
include $(L_PATH)/OpenAL/Android.mk
include $(L_PATH)/ruby/Android.mk
include $(L_PATH)/libvorbis/Android.mk