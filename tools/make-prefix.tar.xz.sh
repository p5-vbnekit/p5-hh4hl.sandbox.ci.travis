#!/bin/sh -e

(cd prefix && tar -c .) | xz -9 > prefix.tar.xz
