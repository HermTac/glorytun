# Downloads latest libsodium source
FetchContent_Declare(
    libsodium_source
    URL https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
)

if (NOT libsodium_source_POPULATED)
    FetchContent_Populate(libsodium_source)

    # Builds libsodium source into static library
    execute_process(
        OUTPUT_QUIET
        COMMAND ${libsodium_source_SOURCE_DIR}/configure --host=${CMAKE_SYSTEM_PROCESSOR}
        WORKING_DIRECTORY ${libsodium_source_BINARY_DIR}
    )
    execute_process(
        OUTPUT_QUIET
        COMMAND make
        WORKING_DIRECTORY ${libsodium_source_BINARY_DIR}
    )
endif ()

# Creates CMake target for libsodium
add_library(
    libsodium
    INTERFACE
)
target_include_directories(
    libsodium
    INTERFACE
    ${libsodium_source_BINARY_DIR}/src/libsodium/include
    ${libsodium_source_SOURCE_DIR}/src/libsodium/include
    ${libsodium_source_SOURCE_DIR}/src/libsodium/include/sodium
)
target_link_libraries(
    libsodium
    INTERFACE
    ${libsodium_source_BINARY_DIR}/src/libsodium/.libs/libsodium.a
)