
![Alt text](./picozed_sdr.jpg?raw=true "PicoZED 1x1 SDR with Analog Devices AD9364-BBCZ")  

This repository contains files to build working PicoZED 1x1 SDR system.  
Project results are build using Xilinx 2020.2 tools (Vivado and Petalinux).  

Project is composed of:  
- FPGA design ported from latest Analog Pluto to PicoZED 1x1 SDR HW (functional equivalent).  
- Bootstrap files (fsbl, rootfs, u-boot) build via Petalinux.  
- Linux v5.4 kernel and needed device drivers.  
- Linux OS file system with all needed files (libiio and iio daemon).  
- Python example to test SDR TX and RX on remote network connected PC host.  

Look for ```README.md``` file in each project subdirectory for further instructions.  

Part of project are also external Linux kernel and U-Boot git forks, so don't forget to initialize submodules:  

```git submodule update --init --recursive```  

WBR Primoz
