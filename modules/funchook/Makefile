.DEFAULT: all
.PHONY: all

override MAKEFILE := $(realpath $(abspath $(firstword $(MAKEFILE_LIST))))
override SRC_DIR := $(realpath $(abspath $(dir $(MAKEFILE))))
override CURRENT_DIR := $(realpath $(abspath .))

all: prefix
all: prefix/debian-stable-x86.tar.xz prefix/debian-stable-x86_64.tar.xz
all: prefix/debian-testing-x86.tar.xz prefix/debian-testing-x86_64.tar.xz

prefix:
	mkdir -p "$(CURRENT_DIR)/prefix"

prefix/debian-stable-x86.tar.xz: prefix
	docker run --rm --volume="$(SRC_DIR)":/mnt/parent --volume="$(CURRENT_DIR)/prefix":/mnt/prefix debian:stable /bin/sh -e /mnt/parent/docker/debian.sh "/mnt/parent/src" "/mnt/$@" "x86"

prefix/debian-stable-x86_64.tar.xz: prefix
	docker run --rm --volume="$(SRC_DIR)":/mnt/parent --volume="$(CURRENT_DIR)/prefix":/mnt/prefix debian:stable /bin/sh -e /mnt/parent/docker/debian.sh "/mnt/parent/src" "/mnt/$@" "x86_64"

prefix/debian-testing-x86.tar.xz: prefix
	docker run --rm --volume="$(SRC_DIR)":/mnt/parent --volume="$(CURRENT_DIR)/prefix":/mnt/prefix debian:testing /bin/sh -e /mnt/parent/docker/debian.sh "/mnt/parent/src" "/mnt/$@" "x86"

prefix/debian-testing-x86_64.tar.xz: prefix
	docker run --rm --volume="$(SRC_DIR)":/mnt/parent --volume="$(CURRENT_DIR)/prefix":/mnt/prefix debian:testing /bin/sh -e /mnt/parent/docker/debian.sh "/mnt/parent/src" "/mnt/$@" "x86_64"
