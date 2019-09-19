.DEFAULT: all
.PHONY: all funchook

override MAKEFILE := $(realpath $(abspath $(firstword $(MAKEFILE_LIST))))
override SRC_DIR := $(realpath $(abspath $(dir $(MAKEFILE))))
override CURRENT_DIR := $(realpath $(abspath .))

override SUBDIRS := $(patsubst $(SRC_DIR)/%/,%,$(dir $(wildcard $(SRC_DIR)/*/Makefile)))

.PHONY: $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	mkdir -p "$(CURRENT_DIR)/$@"
	$(MAKE) -C "$(CURRENT_DIR)/$@" -f "$(SRC_DIR)/$@/Makefile"
