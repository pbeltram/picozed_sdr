# Zynq UltraScale+ U-Boot Makefile 

UBOOT_DIR := u-boot-rpt

CONFIG=zynq_pzsdr1_defconfig
LX_CROSS_COMPILE?=arm-none-eabi-

UBOOT := $(UBOOT_DIR)/u-boot
INSTALL_DIR ?= .

OBJECTS=$(UBOOT)

.PHONY : all install clean

all: $(OBJECTS)

$(UBOOT): | $(UBOOT_DIR)
	@echo
	@echo Building U-Boot \($(CONFIG)\) ...
	@echo
	make -C $(UBOOT_DIR) mrproper
	make -C $(UBOOT_DIR) $(CONFIG)
	make -C $(UBOOT_DIR) CROSS_COMPILE=$(LX_CROSS_COMPILE) all
	make -C $(UBOOT_DIR) CROSS_COMPILE=$(LX_CROSS_COMPILE) env

install: $(OBJECTS)
	cp $(UBOOT) $(INSTALL_DIR)/u-boot.elf

envinstall: all
	mkdir -p $(INSTALL_DIR)/bin/
	cp $(UBOOT_DIR)/tools/env/fw_printenv $(INSTALL_DIR)/bin
	cp $(UBOOT_DIR)/tools/env/fw_printenv $(INSTALL_DIR)/bin/fw_setenv

clean:
	make -C $(UBOOT_DIR) mrproper
	-rm -rf $(UBOOT_DIR)/oe-logs
	-rm -rf $(UBOOT_DIR)/oe-workdir
	-rm -rf $(UBOOT_DIR)/include/configs/platform-auto.h
	-rm -rf $(UBOOT_DIR)/include/configs/platform-top.h

