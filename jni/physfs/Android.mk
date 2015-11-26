LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE:= physfs 
LOCAL_SRC_FILES:=src/lzma/C/7zCrc.c \
	src/lzma/C/Archive/7z/7zBuffer.c \
	src/lzma/C/Archive/7z/7zHeader.c \
	src/lzma/C/Archive/7z/7zDecode.c \
	src/lzma/C/Archive/7z/7zExtract.c \
	src/lzma/C/Archive/7z/7zIn.c \
	src/lzma/C/Archive/7z/7zItem.c \
	src/lzma/C/Archive/7z/7zMethodID.c \
	src/lzma/C/Compress/Lzma/LzmaDecode.c \
	src/lzma/C/Compress/Branch/BranchARM.c \
	src/lzma/C/Compress/Branch/BranchX86.c \
	src/lzma/C/Compress/Branch/BranchX86_2.c \
	src/physfs.c \
	src/physfs_byteorder.c \
	src/physfs_unicode.c \
	src/platform_unix.c \
	src/platform_posix.c \
	src/archiver_dir.c \
	src/archiver_unpacked.c \
	src/archiver_lzma.c \
	src/archiver_zip.c \
	src/archiver_iso9660.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(LOCAL_PATH)
include $(BUILD_STATIC_LIBRARY)

