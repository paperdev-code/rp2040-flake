cmake_minimum_required(VERSION 3.21)

# compile_commands for c/c++ lsp
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)
set(PICO_BOARD "pico")

project(pico_sdk_project C CXX ASM)
set(CMAKE_C_STANDARD 17)

pico_sdk_init()

add_executable(app
    src/main.c
    )

pico_stdio_enable_usb(app 0)
pico_stdio_enable_usb(app 0)

target_link_libraries(app
    pico_stdlib
    )

pico_add_extra_outputs(app)
