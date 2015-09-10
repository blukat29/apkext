#/bin/sh
cd $( dirname $0 )
mkdir -p tools
cd tools
if [ ! -d dex2jar-2.0 ]; then
  wget https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip -O dex2jar.zip
  unzip dex2jar.zip
  rm dex2jar.zip
  chmod +x dex2jar-2.0/*.sh
fi

if [ ! -d jad ]; then
  if [ "$(uname)" == "Darwin" ]; then
    wget http://varaneckas.com/jad/jad158g.mac.intel.zip -O jad.zip
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    wget http://varaneckas.com/jad/jad158e.linux.static.zip -O jad.zip
  fi
  unzip -d jad jad.zip
  rm jad.zip
fi

if [ ! -f apktool.jar ]; then
  wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.0.1.jar -O apktool.jar
fi

