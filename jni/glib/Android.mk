# This file is the top android makefile for all sub-modules.

LOCAL_PATH := $(call my-dir)

GLIB_TOP := $(LOCAL_PATH)

GLIB_BUILD_STATIC := $(BUILD_STATIC)

GLIB_C_INCLUDES :=			\
	$(GLIB_TOP)			\
	$(GLIB_TOP)/glib		\
	$(GLIB_TOP)/android

GTHREAD_C_INCLUDES :=			\
	$(GLIB_C_INCLUDES)		\
	$(GLIB_TOP)/gthread

GLIB_SHARED_LIBRARIES :=		\
	libgthread-2.0			\
	libglib-2.0

GLIB_STATIC_LIBRARIES :=		\
	$(GLIB_SHARED_LIBRARIES)	\
	libpcre

include $(CLEAR_VARS)

include $(GLIB_TOP)/glib/Android.mk
include $(GLIB_TOP)/gthread/Android.mk

