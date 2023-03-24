cmake_minimum_required(VERSION 3.21)

include($ENV{PICO_SDK_IMPORT})

project(pico_sdk_project C CXX ASM)

pico_sdk_init()

add_executable(app
    src/main.c
    )

target_link_libraries(app
    pico_stdlib
    )

pico_add_extra_outputs(app)
