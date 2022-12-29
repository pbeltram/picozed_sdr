
---  
**Setup Petalinux build environment**  
```
. ~/opt/Xilinx/petalnx/2020.2/components/yocto/buildtools/environment-setup-x86_64-petalinux-linux
source ~/opt/Xilinx/petalnx/2020.2/settings.sh
cd ~/gitrepos/picozed_sdr/petalnx/
```  

---  
**Build pzsdr1_sdr Petalinux project**  
**NOTE:** Console terminal Width/Height for petalinux-config must be min 20 lines 80 columns!  
```  
cd ./pzsdr1_sdr
petalinux-config --get-hw-description=../pzsdr1_sdr_xsa
petalinux-config -c rootfs
petalinux-build -x mrproper
make -C ../../lnx/u-boot/ clean
make -C ../../lnx/linux/ clean
petalinux-build
```  

---  
**Create Zynq BOOT.BIN**  
```  
petalinux-package --boot --format BIN --fsbl ./images/linux/zynq_fsbl.elf --fpga ./images/linux/system.bit --u-boot ./images/linux/u-boot.elf --dtb no --force --output ./images/linux/BOOT.BIN
```  

---

