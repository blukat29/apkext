#!/bin/sh

msg()
{
  echo -n "\033[1;32m"
  echo -n $1
  echo "\033[0;m"
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
java -jar $tooldir/apktool.jar d $1 -o $extdir/unpacked

msg "[+] Extracting apk archive"
mkdir -p $extdir
rm -rf $extdir/raw
mkdir -p $extdir/raw
unzip -d $extdir/raw $1

msg "[+] Converting classes.dex to jar"
$tooldir/dex2jar-2.0/d2j-dex2jar.sh $extdir/raw/classes.dex -o $extdir/classes.jar

msg "[+] Extracting jar file"
rm -rf $extdir/cls
mkdir -p $extdir/cls
unzip -d $extdir/cls $extdir/classes.jar

msg "[+] Decompiling class files"
rm -rf $extdir/src
mkdir -p $extdir/src
$tooldir/jad/jad -r -d $extdir/src -s java $extdir/cls/**/*.class

msg ""
msg "[+] Resources are in $extdir/unpacked"
msg "[+] Decompiled classes in $extdir/src"

