#!/bin/bash

tooldir=$( dirname $( readlink -f $0 ) )/tools

if [ $# -lt 2 ]; then
  echo "USAGE: apkext App/unpacked/ new.apk"
  exit
fi

dname="$( dirname $1 )";
fname=$2

if [ "$(uname)" == "Darwin" ]; then
  aapt_path=$tooldir/prebuilt/aapt/macosx/aapt
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  aapt_path=$tooldir/prebuilt/aapt/linux/aapt
fi
java -jar $tooldir/apktool.jar --frame-path $tooldir/framework -aapt $aapt_path b $1 -o $2

