#! /bin/sh

i386="SIMULATOR"
x86_64="SIMULATOR64"
arm="OS"

DIR=`pwd`
CMAKEOUT=$DIR/out
BUILD_DIR=$DIR/build
OUT_DIR=$DIR/out/ios
LIB_DIR=$OUT_DIR/lib
LIBNAME=libdetectzawgyi.a

cp CMakeLists.txt.ios CMakeLists.txt
if [ $? -ne 0 ]; then
  exit 1
fi

if [ -d $BUILD_DIR ]; then
  rm -rf $BUILD_DIR
fi
if [ -d $OUT_DIR ]; then
  rm -rf $OUT_DIR
fi
mkdir -p $BUILD_DIR
cd $BUILD_DIR

for platform in $arm $x86_64 $i386; do
  echo "platform: $platform"
  cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=../ios-cmake/ios.toolchain.cmake -DIOS_DEPLOYMENT_TARGET=9.0 -DIOS_PLATFORM=$platform
  cmake --build . --config Release --target install
  mkdir -p $LIB_DIR/$platform
  mv $CMAKEOUT/lib/$LIBNAME $LIB_DIR/$platform/
  rm -rf $BUILD_DIR/*
done

mv $CMAKEOUT/include $OUT_DIR
rm -rf $CMAKEOUT/lib

LIPO=$(xcrun -sdk iphoneos -find lipo)
$LIPO -create $LIB_DIR/$arm/$LIBNAME $LIB_DIR/$x86_64/$LIBNAME $LIB_DIR/$i386/$LIBNAME -output $LIB_DIR/$LIBNAME
$LIPO -info $LIB_DIR/$LIBNAME