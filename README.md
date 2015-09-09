# apkext

One-click tool for extracting apk files.

### What this uses
- apktools (http://ibotpeaches.github.io/Apktool/)
- dex2jar (https://github.com/pxb1988/dex2jar)
- jad (http://varaneckas.com/jad/)

### What this does
- extract resources
- Baksmali codes
- Decompile classes into .java files

### How to use
```
./install.sh
```
```
./extract.sh <apk file>
```
Note: apk file name must end with `.apk`

Extracted files are generated in the same directory with the apk file.
e.g. if you extract `Example.apk`, then files are extracted under `Example/`

