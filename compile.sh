#!/bin/sh
cd jni/mkxp
./make_xxd.sh
cd ..
if [ -z "$1" ]; then
   ndk-build -j3
else
   ndk-build "$1"
fi
cd ..
ant debug
adb install -r bin/mkxp-debug.apk
adb shell monkey -p org.ancurio.mkxp -c android.intent.category.LAUNCHER 1
