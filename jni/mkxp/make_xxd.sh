#!/bin/sh
for i in $(ls shader); do
	xxd -i "shader/$i" "shader/$i.xxd"
done
for i in $(ls assets); do
	xxd -i "assets/$i" "assets/$i.xxd"
done
