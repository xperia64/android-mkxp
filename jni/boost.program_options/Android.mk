LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE:= boost_program_options
LOCAL_SRC_FILES:=cmdline.cpp \
	config_file.cpp \
	convert.cpp \
	options_description.cpp \
	parsers.cpp \
	positional_options.cpp \
	split.cpp \
	utf8_codecvt_facet.cpp \
	value_semantic.cpp \
	variables_map.cpp
LOCAL_C_INCLUDES := $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../boost_headers

include $(BUILD_STATIC_LIBRARY)

