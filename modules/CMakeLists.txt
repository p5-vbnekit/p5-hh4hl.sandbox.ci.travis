function("add_subdirs")
    file(GLOB "subfiles" RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/*/CMakeLists.txt")
    foreach("subfile" ${subfiles})
      get_filename_component("subdirectory" "${subfile}" DIRECTORY)
      add_subdirectory("${subdirectory}")
    endforeach("subfile" ${subfiles})
endfunction("add_subdirs")

add_custom_target("modules-all" ALL)

foreach("platform" ${p5-hh4hl.sandbox.ci.travis/platforms})
    add_custom_target("modules-all-${platform}" ALL)
    add_dependencies("modules-all" "modules-all-${platform}")
endforeach("platform" ${p5-hh4hl.sandbox.ci.travis/platforms})

add_subdirs()
