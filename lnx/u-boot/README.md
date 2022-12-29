
---
**U-Boot petalinux build**  

This directory is configured in Petalinux build for U-Boot build.  
u-boot-rpt origin is forked from ```Xilinx/u-boot-xlxn``` git repo from tag ```xlnx_rebase_v2020.01_2020.2```.  
Picozed SDR changes are made and kept in ```pb_pzsdr_2020.2_devel``` branch.  

---

**Build for arm**  

```
source ~/opt/Xilinx/Vitis/2020.2/settings64.sh
make CONFIG=zynq_pzsdr1_defconfig LX_CROSS_COMPILE=arm-none-eabi- clean
make CONFIG=zynq_pzsdr1_defconfig LX_CROSS_COMPILE=arm-none-eabi-
```  

---

