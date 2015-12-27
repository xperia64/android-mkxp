#!/bin/sh
rm "shader/*.xxd*"
for i in $(ls shader); do
	xxd -i "shader/$i" "shader/$i.xxd"
done
rm "assets/*.xxd*"
for i in $(ls assets); do
	xxd -i "assets/$i" "assets/$i.xxd"
done
