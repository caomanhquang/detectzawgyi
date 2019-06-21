cmake_minimum_required (VERSION 3.2)
project (detectzawgyi C CXX)

# Includes
include_directories (${detectzawgyi_SOURCE_DIR})

# Source files
set (SOURCES
  zawgyi_detector.cpp
)

# Headers
set (HEADERS
  public/detectzawgyi.h
)

# Library
if (BUILD_SHARED)
  add_library (detectzawgyi SHARED ${SOURCES} ${HEADERS})
  message(STATUS "Building shared version...")
else()
  add_library (detectzawgyi STATIC ${SOURCES} ${HEADERS})
  message(STATUS "Building static version...")
endif()

# Debug symbols set in XCode project
# Comment the line below when build for Android, uncomment it when build for iOS
set_xcode_property (detectzawgyi GCC_GENERATE_DEBUGGING_SYMBOLS YES "All")

# Installation
set (CMAKE_INSTALL_PREFIX "${detectzawgyi_SOURCE_DIR}/out")
install (TARGETS detectzawgyi DESTINATION lib)
install (FILES ${HEADERS} DESTINATION include)
