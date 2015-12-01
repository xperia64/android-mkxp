#!/bin/sh
cd jni
ndk-build -j3
cd ..
ant debug
adb install -r bin/mkxp-debug.apk
adb shell monkey -p org.ancurio.mkxp -c android.intent.category.LAUNCHER 1
