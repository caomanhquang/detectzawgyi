#! /bin/sh

i386="SIMULATOR"
x86_64="SIMULATOR64"
arm="OS"

DIR=`pwd`
BUILD_DIR=$DIR/build
OUT_DIR=$DIR/out
LIB_DIR=$OUT_DIR/lib
LIBNAME=libdetectzawgyi.a

if [ -d "build" ]; then
  rm -rf build
fi
if [ -d "out" ]; then
  rm -rf out
fi
mkdir build
cd build

for platform in $arm $x86_64 $i386; do
  echo "platform: $platform"
  cmake .. -G Xcode -DCMAKE_TOOLCHAIN_FILE=../ios-cmake/ios.toolchain.cmake -DIOS_DEPLOYMENT_TARGET=9.0 -DIOS_PLATFORM=$platform
  cmake --build . --config Release --target install
  mkdir -p $LIB_DIR/$platform
  mv $LIB_DIR/$LIBNAME $LIB_DIR/$platform/
  rm -rf $BUILD_DIR/*
done

LIPO=$(xcrun -sdk iphoneos -find lipo)
$LIPO -create $LIB_DIR/$arm/$LIBNAME $LIB_DIR/$x86_64/$LIBNAME $LIB_DIR/$i386/$LIBNAME -output $LIB_DIR/$LIBNAME
$LIPO -info $LIB_DIR/$LIBNAME