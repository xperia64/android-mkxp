LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)


LOCAL_MODULE:= mkxp
LOCAL_CPPFLAGS:=-DGLES2_HEADER -DFULL_GAME_PATH=\"/sdcard/mkxp/Game\" -DFULL_MKXP_PATH=\"/sdcard/mkxp/mkxp.conf\"
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../OpenAL $(LOCAL_PATH)/../SDL_sound \
	$(LOCAL_PATH)/../libsigc++ $(LOCAL_PATH) \
	$(LOCAL_PATH)/../boost_headers $(LOCAL_PATH)/../pixman/pixman/pixman \
	$(LOCAL_PATH)/../OpenAL/include/AL $(LOCAL_PATH)/../physfs/src \
	$(LOCAL_PATH)/../vorbis-include $(LOCAL_PATH)/src $(LOCAL_PATH)/../ruby/include
LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/src/main.cpp \
	$(LOCAL_PATH)/src/audio.cpp \
	$(LOCAL_PATH)/src/bitmap.cpp \
	$(LOCAL_PATH)/src/eventthread.cpp \
	$(LOCAL_PATH)/src/filesystem.cpp \
	$(LOCAL_PATH)/src/font.cpp \
	$(LOCAL_PATH)/src/input.cpp \
	$(LOCAL_PATH)/src/plane.cpp \
	$(LOCAL_PATH)/src/scene.cpp \
	$(LOCAL_PATH)/src/sprite.cpp \
	$(LOCAL_PATH)/src/table.cpp \
	$(LOCAL_PATH)/src/tilequad.cpp \
	$(LOCAL_PATH)/src/viewport.cpp \
	$(LOCAL_PATH)/src/window.cpp \
	$(LOCAL_PATH)/src/texpool.cpp \
	$(LOCAL_PATH)/src/shader.cpp \
	$(LOCAL_PATH)/src/glstate.cpp \
	$(LOCAL_PATH)/src/tilemap.cpp \
	$(LOCAL_PATH)/src/autotiles.cpp \
	$(LOCAL_PATH)/src/graphics.cpp \
	$(LOCAL_PATH)/src/gl-debug.cpp \
	$(LOCAL_PATH)/src/etc.cpp \
	$(LOCAL_PATH)/src/config.cpp \
	$(LOCAL_PATH)/src/settingsmenu.cpp \
	$(LOCAL_PATH)/src/keybindings.cpp \
	$(LOCAL_PATH)/src/tileatlas.cpp \
	$(LOCAL_PATH)/src/sharedstate.cpp \
	$(LOCAL_PATH)/src/gl-fun.cpp \
	$(LOCAL_PATH)/src/gl-meta.cpp \
	$(LOCAL_PATH)/src/vertex.cpp \
	$(LOCAL_PATH)/src/soundemitter.cpp \
	$(LOCAL_PATH)/src/sdlsoundsource.cpp \
	$(LOCAL_PATH)/src/alstream.cpp \
	$(LOCAL_PATH)/src/audiostream.cpp \
	$(LOCAL_PATH)/src/rgssad.cpp \
	$(LOCAL_PATH)/src/bundledfont.cpp \
	$(LOCAL_PATH)/src/vorbissource.cpp \
	$(LOCAL_PATH)/src/windowvx.cpp \
	$(LOCAL_PATH)/src/tilemapvx.cpp \
	$(LOCAL_PATH)/src/tileatlasvx.cpp \
	$(LOCAL_PATH)/src/autotilesvx.cpp \
	$(LOCAL_PATH)/src/midisource.cpp \
	$(LOCAL_PATH)/src/fluid-fun.cpp \
	$(LOCAL_PATH)/binding-mri/binding-mri.cpp \
	$(LOCAL_PATH)/binding-mri/binding-util.cpp \
	$(LOCAL_PATH)/binding-mri/bitmap-binding.cpp \
	$(LOCAL_PATH)/binding-mri/table-binding.cpp \
	$(LOCAL_PATH)/binding-mri/etc-binding.cpp \
	$(LOCAL_PATH)/binding-mri/font-binding.cpp \
	$(LOCAL_PATH)/binding-mri/graphics-binding.cpp \
	$(LOCAL_PATH)/binding-mri/input-binding.cpp \
	$(LOCAL_PATH)/binding-mri/sprite-binding.cpp \
	$(LOCAL_PATH)/binding-mri/viewport-binding.cpp \
	$(LOCAL_PATH)/binding-mri/plane-binding.cpp \
	$(LOCAL_PATH)/binding-mri/window-binding.cpp \
	$(LOCAL_PATH)/binding-mri/tilemap-binding.cpp \
	$(LOCAL_PATH)/binding-mri/audio-binding.cpp \
	$(LOCAL_PATH)/binding-mri/module_rpg.cpp \
	$(LOCAL_PATH)/binding-mri/filesystem-binding.cpp \
	$(LOCAL_PATH)/binding-mri/windowvx-binding.cpp \
	$(LOCAL_PATH)/binding-mri/tilemapvx-binding.cpp \

LOCAL_SHARED_LIBRARIES:=OpenAL ogg
LOCAL_STATIC_LIBRARIES:=vorbis physfs sigc++ pixman boost_program_options ruby SDL2_static SDL2_ttf SDL2_sound SDL2_image 
LOCAL_LDLIBS:=-lz -llog -ldl -lm
include $(BUILD_SHARED_LIBRARY)
