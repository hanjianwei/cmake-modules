#########################
#   project settings    #
#########################
set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} CACHE STRING "You may add additional search paths here. Use ; to separate multiple paths.")
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} CACHE STRING "You may add additional search paths here. Use ; to separate multiple paths.")

# output directories
set(OUTPUT_BIN_DIR ${PROJECT_BINARY_DIR}/bin)
make_directory(${OUTPUT_BIN_DIR})

set(OUTPUT_LIB_DIR ${PROJECT_BINARY_DIR}/lib)
make_directory(${OUTPUT_LIB_DIR})

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_LIB_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_BIN_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_BIN_DIR})

set(CMAKE_DEBUG_POSTFIX "d")


##########################################
#   Platform and compiler configruation  #
##########################################
# Only support MSVC10, GCC and Clang
if(WIN32)
    if(MSVC_VERSION < 1600)
        message(FATAL_ERROR "Only Visual Studio 2010 and later supported!")
    endif()
endif()

# Treat warning as errors
set(TREAT_WARNINGS_AS_ERRORS ON CACHE BOOL "Treat warnings as errors")

# C++ 11 support
set(CXX11_SUPPORT OFF CACHE BOOL "Use C++ 11")

# Linking model
option(BUILD_SHARED_LIBS "Set to ON to build project for dynamic linking.  Use OFF for static." ON)

if(NOT MSVC AND CXX11_SUPPORT)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
endif()

if(MSVC)
    add_definitions(-DNOMINMAX)
    add_definitions(-D_SCL_SECURE_NO_WARNINGS)
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    if(TREAT_WARNINGS_AS_ERRORS)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /WX")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /WX")
    endif()
elseif(CMAKE_COMPILER_IS_GNUCXX)
    if(TREAT_WARNINGS_AS_ERRORS)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror")
    endif()
else() # Clang
    if(TREAT_WARNINGS_AS_ERRORS)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Weverything -Werror")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Weverything -Werror")
    endif()
endif()

