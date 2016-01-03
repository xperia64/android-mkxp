LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := fluidsynth
SRCDIR := ./src

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/bindings
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/drivers
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/midi
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/rvoice
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/sfloader
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/synth
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/utils
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../glib
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../glib/glib
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../glib/android

LOCAL_CFLAGS := -O3 -DHAVE_STRING_H -DHAVE_STDLIB_H -DHAVE_STDIO_H -DHAVE_MATH_H -DHAVE_ERRNO_H -DHAVE_UNISTD_H -DHAVE_FCNTL_H -DHAVE_SYS_TYPES_H -DHAVE_SYS_STAT_H -DHAVE_PTHREAD_H -DHAVE_LIMITS_H -DHAVE_ARPA_INET_H -DHAVE_SYS_SOCKET_H -DDEFAULT_SOUNDFONT=\"\" -DVERSION=\"1.0.0\" \
				

LOCAL_CPP_EXTENSION := .cpp

LOCAL_SRC_FILES := \
	$(SRCDIR)/bindings/fluid_cmd.c \
	$(SRCDIR)/drivers/fluid_adriver.c \
	$(SRCDIR)/drivers/fluid_mdriver.c \
	$(SRCDIR)/bindings/fluid_filerenderer.c \
	$(SRCDIR)/bindings/fluid_ladspa.c \
	$(SRCDIR)/bindings/fluid_rtkit.c \
	$(SRCDIR)/midi/fluid_midi.c \
	$(SRCDIR)/midi/fluid_midi_router.c \
	$(SRCDIR)/midi/fluid_seq.c \
	$(SRCDIR)/midi/fluid_seqbind.c \
	$(SRCDIR)/rvoice/fluid_adsr_env.c \
	$(SRCDIR)/rvoice/fluid_chorus.c \
	$(SRCDIR)/rvoice/fluid_iir_filter.c \
	$(SRCDIR)/rvoice/fluid_lfo.c \
	$(SRCDIR)/rvoice/fluid_rev.c \
	$(SRCDIR)/rvoice/fluid_rvoice.c \
	$(SRCDIR)/rvoice/fluid_rvoice_dsp.c \
	$(SRCDIR)/rvoice/fluid_rvoice_event.c \
	$(SRCDIR)/rvoice/fluid_rvoice_mixer.c \
	$(SRCDIR)/sfloader/fluid_defsfont.c \
	$(SRCDIR)/sfloader/fluid_ramsfont.c \
	$(SRCDIR)/synth/fluid_chan.c \
	$(SRCDIR)/synth/fluid_event.c \
	$(SRCDIR)/synth/fluid_gen.c \
	$(SRCDIR)/synth/fluid_mod.c \
	$(SRCDIR)/synth/fluid_synth.c \
	$(SRCDIR)/synth/fluid_tuning.c \
	$(SRCDIR)/synth/fluid_voice.c \
	$(SRCDIR)/utils/fluid_conv.c \
	$(SRCDIR)/utils/fluid_hash.c \
	$(SRCDIR)/utils/fluid_list.c \
	$(SRCDIR)/utils/fluid_ringbuffer.c \
	$(SRCDIR)/utils/fluid_settings.c \
	$(SRCDIR)/utils/fluid_sys.c \
	$(SRCDIR)/fluidsynth.c \

LOCAL_SHARED_LIBRARIES := libglib-2.0 libgthread-2.0
LOCAL_STATIC_LIBRARIES := 

LOCAL_LDLIBS := -llog




include $(BUILD_SHARED_LIBRARY)

