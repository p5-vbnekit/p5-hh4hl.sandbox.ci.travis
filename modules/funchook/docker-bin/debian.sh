#!/bin/sh -e

set +e

m_cmake_flags=
m_apt_packages=
m_architecture="$1"
m_uid="$2"
m_gid="$3"

case "${m_architecture}" in
  "x86")
    m_cmake_flags="-DCMAKE_C_FLAGS=-m32 -DCMAKE_ASM_FLAGS=-m32"
    m_apt_packages="gcc-multilib"
    ;;
  "x86_64")
    ;;
  *)
    echo "unsupported atchitecture: \"${m_architecture}\"" >&2
    exit 1
esac

m_src_directory="/mnt/src"
m_build_directory="/tmp/build"
m_prefix_directory="/tmp/prefix"

export PS4="docker: `basename $0`: executing command: "
set -x

test -n "$m_uid"
test -n "$m_gid"

export DEBIAN_FRONTEND=noninteractive

apt update -y
apt install apt-utils -y
apt full-upgrade -y

apt install -y xz-utils cmake make gcc ${m_apt_packages}

mkdir -p "${m_build_directory}" "${m_prefix_directory}/lib" "${m_prefix_directory}/include"
(cd "${m_build_directory}" && cmake "${m_src_directory}" -DCMAKE_BUILD_TYPE=Release ${m_cmake_flags} && make -j -Orecurse)
cp "${m_build_directory}"/*.a "${m_prefix_directory}/lib/"
cp -r "${m_src_directory}/include" "${m_prefix_directory}/"
(cd "${m_prefix_directory}/" && tar --create --owner=":${m_uid}" --group=":${m_gid}" .) > /tmp/prefix.tar
(cd /mnt/prefix && tar -xf /tmp/prefix.tar)
