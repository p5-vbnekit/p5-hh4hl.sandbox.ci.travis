#!/bin/sh -e

m_sources="$1"
m_prefix="$2"
m_architecture="$3"

test -n "${m_sources}"
test -n "${m_prefix}"
test -n "${m_architecture}"

test -d "${m_sources}"

case "${m_architecture}" in
  "x86")
    m_cmake_flags="-DCMAKE_C_FLAGS=-m32 -DCMAKE_ASM_FLAGS=-m32"
    m_apt_packages="gcc-multilib"
    ;;
  "x86_64")
    m_cmake_flags=
    m_apt_packages=
    ;;
  *)
    echo "unsupported atchitecture" >&2
    exit 1
esac

do_prepare() {
  export DEBIAN_FRONTEND=noninteractive

  apt update
  apt install apt-utils -y
  apt full-upgrade -y

  apt install -y xz-utils cmake make gcc ${m_apt_packages}
}


do_build() {
  m_build_directory="/tmp/build/${m_architecture}"
  m_prefix_directory="/tmp/prefix/${m_architecture}"
  mkdir -p "${m_build_directory}" "${m_prefix_directory}/lib" "${m_prefix_directory}/include"
  (cd "${m_build_directory}" && cmake "${m_sources}" -DCMAKE_BUILD_TYPE=Release ${m_cmake_flags} && make -j -Orecurse)
  cp "${m_build_directory}"/*.a "${m_prefix_directory}/lib/"
  cp -r "${m_sources}/include" "${m_prefix_directory}/"
  (cd "${m_prefix_directory}" && tar -c . | xz -9 > "${m_prefix}")
}

do_prepare
do_build
