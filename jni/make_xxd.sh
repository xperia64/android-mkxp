#!/bin/sh
rm -f mkxp/shader/*.xxd*
for i in $(ls mkxp/shader); do
	xxd -i "mkxp/shader/$i" "mkxp/shader/$i.xxd"
done
rm -f mkxp/assets/*.xxd*
for i in $(ls mkxp/assets); do
	xxd -i "mkxp/assets/$i" "mkxp/assets/$i.xxd"
done
