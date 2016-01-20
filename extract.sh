#!/bin/sh

msg()
{
  echo "\033[1;32m$1\033[0;m"
}

tooldir=$( dirname $( readlink -f $0 ) )/tools

if [ $# -lt 1 ]; then
  echo "USAGE: apkext App.apk"
  echo "  Note: The name of the apk file must end with '.apk'"
  exit
fi

dname="$( dirname $1 )";
extdir=$dname/$( basename $1 .apk )

if [ -d $extdir ]; then
  echo "Directory $extdir already exists."
  echo "Remove or rename it and then retry."
  exit
fi

msg "[+] Extracting under $extdir"

msg "[+] Extracting resources"
java -jar $tooldir/apktool.jar d $1 --frame-path $tooldir/framework -o $extdir/unpacked

msg "[+] Extracting classes.dex"
unzip $1 classes.dex -d $extdir/

msg "[+] Converting classes.dex to jar"
$tooldir/dex2jar-2.0/d2j-dex2jar.sh $extdir/classes.dex -o $extdir/classes.jar
rm $extdir/classes.dex

msg "[+] Decompiling jar files"
rm -rf $extdir/src
mkdir -p $extdir/src
java -jar $tooldir/procyon.jar -jar $extdir/classes.jar -o $extdir/src

msg ""
msg "[+] Resources and smali are in $extdir/unpacked"
msg "[+] Decompiled classes in $extdir/src"

