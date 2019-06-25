#! /bin/sh


TARGETS="armeabi-v7a arm64-v8a x86 x86_64"
#TARGETS="armeabi-v7a"

DIR=`pwd`
BUILD_DIR=$DIR/build
OUT_DIR=$DIR/out/android
LIB_DIR=$OUT_DIR/lib
INC_DIR=$OUT_DIR/include
LIBNAME=libdetectzawgyi.so

cp CMakeLists.txt.android CMakeLists.txt
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

for TARGET in ${TARGETS}
do
  echo "TARGET: $TARGET"
  mkdir $TARGET
  cd $TARGET
  cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake -DANDROID_NDK=$ANDROID_NDK -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI="$TARGET" -DANDROID_STL="c++_static" -DANDROID_PLATFORM=16 -DANDROID_ARM_NEON=true -DBUILD_SHARED=true ../..
  cmake --build .
  mkdir -p $LIB_DIR/$TARGET
  cp $LIBNAME $LIB_DIR/$TARGET
  cd -
done

mkdir -p $INC_DIR
cp $DIR/public/detectzawgyi.h $INC_DIR

#cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake -DANDROID_NDK=$ANDROID_NDK -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI="armeabi-v7a with NEON" -DANDROID_STL="c++_static" -DANDROID_PLATFORM=14 -DCMAKE_INCLUDE_PATH="$DIR/libicundk/include" ..
#cmake --build . --config Release --target install
#cmake --build .