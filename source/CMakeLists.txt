include(FetchContent)

add_library(
    glorytun_library

    argz.c
    argz.h
    bench.c
    bind.c
    common.c
    common.h
    ctl.c
    ctl.h
    iface.c
    iface.h
    ip.h
    keygen.c
    list.c
    main.c
    path.c
    set.c
    show.c
    tun.c
    tun.h
    version.c
)
target_include_directories(
    glorytun_library
    PUBLIC
    ../source
)
# TODO somehow may libsodium a static library "libsodium.a" and then have CMake use it
FetchContent_Declare(
    libsodium
    URL https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
)
if (NOT libsodium_POPULATED)
    FetchContent_Populate(libsodium)

    execute_process(
        COMMAND ${libsodium_SOURCE_DIR}/configure --host=${CMAKE_SYSTEM_PROCESSOR}
        WORKING_DIRECTORY ${libsodium_BINARY_DIR}
    )
    execute_process(
        COMMAND make
        WORKING_DIRECTORY ${libsodium_BINARY_DIR}
    )
    execute_process(
        COMMAND make install
        WORKING_DIRECTORY ${libsodium_BINARY_DIR}
    )
endif ()

target_include_directories(
    glorytun_library
    PUBLIC
    ${libsodium_SOURCE_DIR}/src/libsodium/include
    ${libsodium_SOURCE_DIR}/src/libsodium/include/sodium
    ${libsodium_BINARY_DIR}/src/libsodium/include
)
target_link_libraries(
    glorytun_library
    PUBLIC
    ${libsodium_BINARY_DIR}/libsodium.a
)

if (PROJECT_IS_TOP_LEVEL)
    add_executable(
        glorytun_executable

        main.c
    )
    target_link_libraries(
        glorytun_executable
        PRIVATE
        glorytun_library
    )
endif ()