LOCAL_PATH:= $(call my-dir)/physfs

include $(CLEAR_VARS)

LOCAL_MODULE:= physfs 
LOCAL_SRC_FILES:=src/lzma/C/7zCrc.c \
	$(LOCAL_PATH)/src/lzma/C/Archive/7z/7zBuffer.c \
	$(LOCAL_PATH)/src/lzma/C/Archive/7z/7zHeader.c \
	$(LOCAL_PATH)/src/lzma/C/Archive/7z/7zDecode.c \
	$(LOCAL_PATH)/src/lzma/C/Archive/7z/7zExtract.c \
	$(LOCAL_PATH)/src/lzma/C/Archive/7z/7zIn.c \
	$(LOCAL_PATH)/src/lzma/C/Archive/7z/7zItem.c \
	$(LOCAL_PATH)/src/lzma/C/Archive/7z/7zMethodID.c \
	$(LOCAL_PATH)/src/lzma/C/Compress/Lzma/LzmaDecode.c \
	$(LOCAL_PATH)/src/lzma/C/Compress/Branch/BranchARM.c \
	$(LOCAL_PATH)/src/lzma/C/Compress/Branch/BranchX86.c \
	$(LOCAL_PATH)/src/lzma/C/Compress/Branch/BranchX86_2.c \
	$(LOCAL_PATH)/src/physfs.c \
	$(LOCAL_PATH)/src/physfs_byteorder.c \
	$(LOCAL_PATH)/src/physfs_unicode.c \
	$(LOCAL_PATH)/src/platform_unix.c \
	$(LOCAL_PATH)/src/platform_posix.c \
	$(LOCAL_PATH)/src/archiver_dir.c \
	$(LOCAL_PATH)/src/archiver_unpacked.c \
	$(LOCAL_PATH)/src/archiver_lzma.c \
	$(LOCAL_PATH)/src/archiver_zip.c \
	$(LOCAL_PATH)/src/archiver_iso9660.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)

include $(BUILD_STATIC_LIBRARY)