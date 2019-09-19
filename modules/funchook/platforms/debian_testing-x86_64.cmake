function("add_target")
    set("architecture" "x86_64")
    set("docker_image" "debian:testing")
    set("platform" "debian_testing-${architecture}")
    set("target_name" "p5-hh4hl.sandbox.ci.travis.modules.funchook-${platform}")

    include("${CMAKE_CURRENT_SOURCE_DIR}/debian-add_target.cmake")
endfunction("add_target")
