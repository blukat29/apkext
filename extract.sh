#!/bin/sh

tooldir=$( dirname $( readlink -f $0 ) )/tools; echo $tooldir
dname="$( dirname $1 )"; echo $dname
extdir=$dname/$( basename $1 .apk ); echo $extdir

echo "[+] Extracting resources"
java -jar $tooldir/apktool.jar d $1 -o $extdir/unpacked

echo "[+] Extracting apk archive"
mkdir -p $extdir
rm -rf $extdir/raw
mkdir -p $extdir/raw
unzip -d $extdir/raw $1

echo "[+] Converting classes.dex to jar"
$tooldir/dex2jar-2.0/d2j-dex2jar.sh $extdir/raw/classes.dex -o $extdir/classes.jar

echo "[+] Extracting jar file"
rm -rf $extdir/cls
mkdir -p $extdir/cls
unzip -d $extdir/cls $extdir/classes.jar

echo "[+] Decompiling class files"
rm -rf $extdir/src
mkdir -p $extdir/src
$tooldir/jad/jad -r -d $extdir/src -s java $extdir/cls/**/*.class

echo ""
echo "[+] Resources are in $extdir/unpacked"
echo "[+] Decompiled classes in $extdir/src"

