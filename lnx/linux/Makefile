# Linux kernel Makefile

override SRC_TOP:=..

XLINUX_DIR := linux-rpt
NUM_CPU := $(shell grep -c ^processor /proc/cpuinfo)
INSTALL_DIR ?= .

CONFIG=zynq_pzsdr1_defconfig
LX_ARCH?=arm
LX_CROSS_COMPILE?=arm-linux-gnueabihf-
KIMAGE=$(XLINUX_DIR)/arch/arm/boot/zImage

# Versioning system
BUILD_NUMBER ?= 1
REVISION ?= devbuild
VER ?= 00.00
VERSION=$(VER)-$(BUILD_NUMBER)

export BUILD_NUMBER
export REVISION
export VERSION

.PHONY : all install clean

all: $(KIMAGE)

$(KIMAGE): | $(XLINUX_DIR)
	echo $(shell echo $(BUILD_NUMBER) - 1 | bc ) > $(XLINUX_DIR)/.version
	make -C $(XLINUX_DIR) ARCH=$(LX_ARCH) mrproper
	make -C $(XLINUX_DIR) ARCH=$(LX_ARCH) $(CONFIG)
	make -j $$(($(NUM_CPU)+1)) -C $(XLINUX_DIR) $(CONFIG) ARCH=$(LX_ARCH) CROSS_COMPILE=$(LX_CROSS_COMPILE) all
	make -j $$(($(NUM_CPU)+1)) -C $(XLINUX_DIR) $(CONFIG) ARCH=$(LX_ARCH) CROSS_COMPILE=$(LX_CROSS_COMPILE) Image
	make -j $$(($(NUM_CPU)+1)) -C $(XLINUX_DIR) $(CONFIG) ARCH=$(LX_ARCH) CROSS_COMPILE=$(LX_CROSS_COMPILE) modules

clean:
	-make -C $(XLINUX_DIR) $(CONFIG) ARCH=$(LX_ARCH) clean
	-make -C $(XLINUX_DIR) $(CONFIG) ARCH=$(LX_ARCH) mrproper
	-rm -rf $(XLINUX_DIR)/oe-logs
	-rm -rf $(XLINUX_DIR)/oe-workdir

install: $(KIMAGE)
	cp $(KIMAGE) $(INSTALL_DIR)

