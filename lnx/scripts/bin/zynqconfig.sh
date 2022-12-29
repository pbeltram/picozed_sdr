#-------------------------------------------------------------------------------
#!/bin/sh
PATH=$PATH:.:/opt/bin

/etc/init.d/iiod stop

#insmod /opt/somedriver.ko                                                                                

echo 268435456 > /sys/module/industrialio_buffer_dma/parameters/max_block_size #256Mbytes
cat /sys/module/industrialio_buffer_dma/parameters/max_block_size

/etc/init.d/iiod start

echo "Zynq config done."




