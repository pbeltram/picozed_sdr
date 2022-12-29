
---
### Linux kernel build  

This directory is configured in Petalinux build for Linux kernel build.  
Original git repo is forked from ```analogdevicesinc/linux``` git repo branch ```master-xilinx-2020.2```.  
Picozed SDR changes are made and kept in ```pb_pzsdr_2020.2_devel``` branch.  

---

**Build arm**  

```
source ~/opt/Xilinx/Vitis/2020.2/settings64.sh
make CONFIG=zynq_pzsdr1_defconfig LX_ARCH=arm LX_CROSS_COMPILE=arm-linux-gnueabihf- clean
make CONFIG=zynq_pzsdr1_defconfig LX_ARCH=arm LX_CROSS_COMPILE=arm-linux-gnueabihf-
```  

---

