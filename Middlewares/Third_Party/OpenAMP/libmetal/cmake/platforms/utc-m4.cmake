set (CMAKE_SYSTEM_NAME "Generic"             CACHE STRING "")
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER CACHE STRING "")
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER CACHE STRING "")
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER CACHE STRING "")

set (WITH_DOC OFF)

set (CMAKE_SYSTEM_PROCESSOR "arm"              CACHE STRING "")
set (MACHINE "cortexm" CACHE STRING "")

set (CROSS_PREFIX           "arm-none-eabi-" CACHE STRING "")

set(CMAKE_C_CXX_COMMON_FLAGS  "${CMAKE_C_CXX_COMMON_FLAGS} -Wall -Wextra -Werror -Wno-unused-variable -Wno-unused-parameter -Wno-psabi")
set(LTO_OPTS " -flto -ffat-lto-objects -fuse-linker-plugin")
set(FAST_OPTS "-O2 -funroll-loops")
set(SAVE_STACK_OPTS "-fno-omit-frame-pointer -fno-shrink-wrap -fno-defer-pop -fno-ira-share-save-slots -fno-ira-share-spill-slots -fno-combine-stack-adjustments")
set(STM32_FLAGS "${STM32_FLAGS} -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -mabi=aapcs")

set(CMAKE_CXX_FLAGS                "${CMAKE_CXX_FLAGS} ${CMAKE_C_CXX_COMMON_FLAGS} ${STM32_FLAGS} -fno-rtti -fno-exceptions -fno-threadsafe-statics -Wnoexcept")
set(CMAKE_CXX_FLAGS_DEBUG          "${CMAKE_CXX_FLAGS_DEBUG} -O0 -g")
set(CMAKE_CXX_FLAGS_RELEASE        "${CMAKE_CXX_FLAGS_RELEASE} -DNDEBUG ${FAST_OPTS} ${LTO_OPTS} -s")
set(CMAKE_C_FLAGS                  "${CMAKE_C_FLAGS} ${CMAKE_C_CXX_COMMON_FLAGS} ${STM32_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -flto --specs=nosys.specs")

set(CMAKE_C_COMPILER "${CROSS_PREFIX}gcc")
set(CMAKE_CXX_COMPILER "${CROSS_PREFIX}g++")
