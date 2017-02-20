LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    ./libcharset/localcharset.c \
    garray.c        \
    gasyncqueue.c   \
    gatomic.c       \
    gbacktrace.c    \
    gbase64.c       \
    gbitlock.c      \
    gbookmarkfile.c \
    gbuffer.c       \
    gcache.c        \
    gchecksum.c     \
    gcompletion.c   \
    gconvert.c      \
    gdataset.c      \
    gdate.c         \
    gdatetime.c     \
    gdir.c          \
    gerror.c        \
    gfileutils.c    \
    ghash.c         \
    ghook.c         \
    ghostutils.c    \
    giochannel.c    \
    gkeyfile.c      \
    glist.c         \
    gmain.c         \
    gmappedfile.c   \
    gmarkup.c       \
    gmem.c          \
    gmessages.c     \
    gnode.c         \
    goption.c       \
    gpattern.c      \
    gpoll.c         \
    gprimes.c       \
    gqsort.c        \
    gqueue.c        \
    grel.c          \
    grand.c         \
    gregex.c        \
    gscanner.c      \
    gsequence.c     \
    gshell.c        \
    gslice.c        \
    gslist.c        \
    gstdio.c        \
    gstrfuncs.c     \
    gstring.c       \
    gtestutils.c    \
    gthread.c       \
    gthreadpool.c   \
    gtimer.c        \
    gtimezone.c     \
    gtree.c         \
    guniprop.c      \
    gutf8.c         \
    gunibreak.c     \
    gunicollate.c   \
    gunidecomp.c    \
    gurifuncs.c     \
    gutils.c        \
    gvariant.c      \
    gvariant-core.c \
    gvariant-parser.c \
    gvariant-serialiser.c \
    gvarianttypeinfo.c \
    gvarianttype.c  \
    gprintf.c       \
    giounix.c       \
    gspawn.c

LOCAL_MODULE := libglib-2.0

LOCAL_C_INCLUDES := 			\
	$(GLIB_TOP)			\
	$(GLIB_TOP)/android		\
	$(GLIB_TOP)/android-internal	\
	$(LOCAL_PATH)/android-internal	\
	$(LOCAL_PATH)/libcharset       	\
	$(LOCAL_PATH)/gnulib           	\
	$(LOCAL_PATH)/pcre

# ./glib private macros, copy from Makefile.am
LOCAL_CFLAGS := \
	-DLIBDIR=\"$(libdir)\"		\
	-DHAVE_CONFIG_H			\
	-DG_LOG_DOMAIN=\"GLib\"		\
	-DPCRE_STATIC			\
	-DG_DISABLE_DEPRECATED		\
	-DGLIB_COMPILATION

ifeq ($(TARGET_ARCH_ABI), armeabi)
	LOCAL_CFLAGS += -DARCH_32BIT
else ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
	LOCAL_CFLAGS += -DARCH_32BIT
else ifeq ($(TARGET_ARCH_ABI), x86)
	LOCAL_CFLAGS += -DARCH_32BIT
else ifeq ($(TARGET_ARCH_ABI), mips)
	LOCAL_CFLAGS += -DARCH_32BIT
endif

ifeq ($(GLIB_BUILD_STATIC),true)
include $(BUILD_STATIC_LIBRARY)
else
LOCAL_STATIC_LIBRARIES := libpcre
LOCAL_LDLIBS :=				\
	-llog

include $(BUILD_SHARED_LIBRARY)
endif

include $(LOCAL_PATH)/pcre/Android.mk
