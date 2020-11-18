# myanmar-tools custom build for iOS and Android

This is a C++ library to detect a string is Zawgyi (a non-unicode font which is very popular in Myanmar) or not.

Original source code is here: https://github.com/google/myanmar-tools/tree/master/clients/cpp

CMake toolchain is here: https://github.com/leetal/ios-cmake

## Build for iOS<br/>
Build with Xcode 10.2.1<br/>
Just run script `./build-ios.sh`, library and header file are generated in `./out/ios` directory 

## Build for Android<br/>
Build with android-ndk-r20<br/>
libicundk was already built from original source code here https://gitlab.com/koying/libicundk<br/>
Just run script `./build-android.sh`, library and header file are generated in `./out/android` directory 
