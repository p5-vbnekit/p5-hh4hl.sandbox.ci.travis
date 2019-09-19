cmake_minimum_required(VERSION 3.1.0)

project("p5-hh4hl.sandbox.ci.travis")

add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/prefix/"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/prefix"
)

add_custom_command(OUTPUT "prefix.tar.xz"
    COMMAND sh -e "${CMAKE_SOURCE_DIR}/tools/make-prefix.tar.xz.sh"
    DEPENDS "${CMAKE_BINARY_DIR}/prefix/" "modules-all"
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)

add_custom_target("prefix-directory" ALL DEPENDS "${CMAKE_BINARY_DIR}/prefix/")
add_custom_target("prefix-tarball" ALL DEPENDS "prefix.tar.xz")

include("uid+gid.cmake")

if(NOT DEFINED "p5-hh4hl.sandbox.ci.travis/platforms")
    function("define_platforms")
        set("platforms" "")
        list(APPEND "platforms" "mingw-x86" "mingw-x86_64" "debian_stable-x86" "debian_stable-x86_64" "debian_testing-x86" "debian_testing-x86_64")
        set("p5-hh4hl.sandbox.ci.travis/platforms" ${platforms} CACHE STRING "build platforms" FORCE)
    endfunction("define_platforms")
    define_platforms()
endif(NOT DEFINED "p5-hh4hl.sandbox.ci.travis/platforms")

add_subdirectory("modules")
