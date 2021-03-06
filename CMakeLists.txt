# for Android

cmake_minimum_required (VERSION 3.2)
project (detectzawgyi C CXX)

# Includes
include_directories (${detectzawgyi_SOURCE_DIR})
include_directories (${detectzawgyi_SOURCE_DIR}/libicundk/include)

# Source files
set (SOURCES
  zawgyi_detector.cpp
)

# Headers
set (HEADERS
  public/detectzawgyi.h
)

# Library
add_library(libicundk STATIC IMPORTED)
set_target_properties(libicundk PROPERTIES IMPORTED_LOCATION
    ${detectzawgyi_SOURCE_DIR}/libicundk/lib/${ANDROID_ABI}/libicundk.a)

if (BUILD_SHARED)
  add_library (detectzawgyi SHARED ${SOURCES} ${HEADERS})
  message(STATUS "Building shared version...")
else()
  add_library (detectzawgyi STATIC ${SOURCES} ${HEADERS})
  message(STATUS "Building static version...")
endif()

target_link_libraries(detectzawgyi android log libicundk)
