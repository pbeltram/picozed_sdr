
---  
**Build BOOT.bin and image.ub**
See ```make help```

---
**Picozed SDR default QSPI partitioning**  
```  
Creating 5 MTD partitions on "spi32765.0":
0x00000000-0x02000000 : "qspi-all"         32M
0x00000000-0x00100000 : "qspi-fsbl-uboot"   1M
0x00100000-0x00020000 : "qspi-uboot-env"  128k
0x00120000-0x000e0000 : "qspi-nvmfs"      896k
0x00200000-0x01e00000 : "qspi-linux"       30M
```

---
**Expected SD card layout (4GByte SD card /dev/sdf example)**
```
Device     Boot   Start     End Sectors  Size Id Type
/dev/sdf1  *       2048  526335  524288  256M  c W95 FAT32 (LBA)
/dev/sdf2        526336 3672063 3145728  1,5G 83 Linux
/dev/sdf3       3672064 7741439 4069376    2G 83 Linux
```  

**/dev/sdf1 on /media/$USER/boot type vfat**  
Format as FAT32.  
Contains BOOT.bin and image.ub.  
Min size: 64MByte.  

**/dev/sdf2 on /media/$USER/rootfs type ext4**  
Format as EXT4.  
Contains Linux rootfs.  
Min size: 256MByte.  

**/dev/sdf3 on /media/$USER/userfs type ext4**  
Format as EXT4.  
NOTE: Mounted as /opt directory.  

---

**Copy local build binaries**
```  
cp ../../devicetree/system.dtb .
cp ../../linux/linux-rpt/arch/arm/boot/zImage .
cp ../../u-boot/u-boot-rpt/u-boot.elf .
```  

---

**Copy Boot files to SD card**  

```  
md5sum ./bin/BOOT.BIN
md5sum ./bin/image.ub
md5sum ./boot.scr
cp ./bin/BOOT.BIN /media/$USER/boot/
cp ./bin/image.ub /media/$USER/boot/
cp ./boot.scr /media/$USER/boot/
md5sum /media/$USER/boot/BOOT.BIN
md5sum /media/$USER/boot/image.ub
md5sum /media/$USER/boot/boot.scr
```  

or via scp utility to ```picozed``` host:  
```  
md5sum ./bin/BOOT.BIN
md5sum ./bin/image.ub
md5sum ./boot.scr
scp ./bin/BOOT.BIN root@picozed:/media/sd-mmcblk0p1/
scp ./bin/image.ub root@picozed:/media/sd-mmcblk0p1/
scp ./boot.scr root@picozed:/media/sd-mmcblk0p1/
Check on Picozed:
md5sum /media/sd-mmcblk0p1/BOOT.BIN
md5sum /media/sd-mmcblk0p1/image.ub
md5sum /media/sd-mmcblk0p1/boot.scr
```  

**Copy Linux rootfs to SD card**  
  
**NOTE: Double check your SD card device partition path (```/dev/sdX2```)!**  
**NOTE: Format will destroy data on ```/dev/sdX2``` partition!**  
**NOTE: Commands executed below can destroy your PC disk data, if directed to wrong device partition!**  
**NOTE: If you don't know what you are doing, than don't do it!**  
**Execution of commands below is your solely responsability. You have been warned!**  
  
```
sudo mount
sudo umount /dev/sdX2
sudo mkfs.ext4 /dev/sdX2
sudo e2label /dev/sdX2 rootfs
udisksctl mount -b /dev/sdX2
sudo su -c 'tar xvf ./rootfs.tar.gz -C /media/$SUDO_USER/rootfs/'
```  

---

