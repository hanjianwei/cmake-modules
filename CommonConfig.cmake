#
# project settings
#
set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} CACHE STRING "You may add additional search paths here. Use ; to separate multiple paths.")
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} CACHE STRING "You may add additional search paths here. Use ; to separate multiple paths.")

# output directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

set(CMAKE_DEBUG_POSTFIX "d")

#
# Platform and compiler configruation
#

# Linking model
option(BUILD_SHARED_LIBS "Set to ON to build project for dynamic linking.  Use OFF for static." ON)

#
# Compiler support
#   Only MSVC, GNUCXX and Clang are supported
#
if((NOT MSVC) AND (NOT CMAKE_COMPILER_IS_GNUCXX) AND (NOT (CMAKE_CXX_COMPILER_ID STREQUAL Clang)))
    message(FATAL_ERROR "Unsupported compiler " ${CMAKE_CXX_COMPILER_ID})
endif()

#
# C++ 11 support
#
set(CXX11_SUPPORT ON CACHE BOOL "Use C++ 11")

if(CXX11_SUPPORT)
    if(MSVC)
        if(MSVC_VERSION VERSION_LESS 1600)
            message(FATAL_ERROR "Visual Studio 2010 above required to support C++11")
        endif()
    elseif(CMAKE_COMPILER_IS_GNUCXX)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
    endif()
endif()

#
# Warning level
#
set(TREAT_WARNINGS_AS_ERRORS OFF CACHE BOOL "Treat warnings as errors")

if(TREAT_WARNINGS_AS_ERRORS)
    if(MSVC)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /WX")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /WX")
    elseif(CMAKE_COMPILER_IS_GNUCXX)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror")
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL Clang)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Weverything -Werror")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Weverything -Werror")
    endif()
endif()
