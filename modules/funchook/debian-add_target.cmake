set("module_name" "funchook")
set("target_name" "modules.${module_name}-${platform}")
set("flag_directory_path" "${CMAKE_CURRENT_BINARY_DIR}/platform")
set("flag_file_path" "${flag_directory_path}/${platform}.flag")

add_custom_command(
    OUTPUT "${flag_file_path}"
    COMMAND docker ARGS run --rm --volume-driver=\"local\" --volume=\"${CMAKE_CURRENT_SOURCE_DIR}/src\":/mnt/src:ro --volume=\"${CMAKE_CURRENT_SOURCE_DIR}/docker-bin\":/mnt/bin:ro --volume=\"${CMAKE_BINARY_DIR}/prefix/${platform}\":/mnt/prefix:rw \"${docker_image}\" /bin/sh -e /mnt/bin/debian.sh \"${architecture}\" "${p5-hh4hl.sandbox.ci.travis/uid}" "${p5-hh4hl.sandbox.ci.travis/gid}"
    COMMAND "${CMAKE_COMMAND}" ARGS -E make_directory "${flag_directory_path}"
    COMMAND "${CMAKE_COMMAND}" ARGS -E touch "${flag_file_path}"
    DEPENDS "prefix-directory"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/docker-bin/debian.sh"
)

add_custom_target("${target_name}" ALL DEPENDS "${flag_file_path}"
    SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/docker-bin/debian.sh"
)
