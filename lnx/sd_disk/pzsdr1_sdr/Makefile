# Makefile for boot binaries

override SRC_TOP:=..

XILSRC=~/opt/Xilinx/Vitis/2020.2/settings64.sh

.PHONY : all help build_all build_lx build_boot clean distclean

all: help

help:
	@echo "usage: make [target]"
	@echo
	@echo "  target:"
	@echo "         help             # This info."
	@echo "         clean            # Delete build directory files."
	@echo "         distclean        # Delete all generated files."
	@echo "         build_lx         # Builds bin/image.ub using rootfs.its file."
	@echo "         build_boot       # Builds bin/BOOT.BIN using boot.bif file."
	@echo "         build_all        # Builds boot_boot and build_lx."
	@echo
	@echo "  Examples:"
	@echo "         make build_lx # Builds bin/image.ub."
	@echo
	@echo "         make build_boot # Builds bin/BOOT.BIN."
	@echo
	@echo "         make build_all # Builds build_boot and build_lx."
	@echo

build_all: build_lx build_boot

build_lx: clean
	@echo "==> Building image.ub"
	-mkdir -p ./build
	-mkdir -p ./bin
	cp ./zImage ./build
	cp ./system.dtb ./build
	mkimage -f ./rootfs.its ./bin/image.ub
	md5sum ./bin/image.ub

build_boot: clean
	@echo "==> Building BOOT.BIN"
	-mkdir -p ./build
	-mkdir -p ./bin
	cp ./zynq_fsbl.elf ./build
	cp ./system.bit ./build
	cp ./u-boot.elf ./build
	source $(XILSRC); bootgen -arch zynq -image ./boot.bif -w on -o ./bin/BOOT.BIN -log trace
	md5sum ./bin/BOOT.BIN

clean:
	-rm -rf build

distclean: clean
	-rm -rf bin

