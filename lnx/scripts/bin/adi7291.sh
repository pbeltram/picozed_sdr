#!/bin/sh

ADCIIO_DEVICE="device0"

# Arguments sanity check
[ $# -lt 1 ] && {
    echo "Usage: $0 <adi7291_iio>"
    echo "   xilinx_adc_iio: ADC IIO deviceN (e.g. /sys/bus/iio/devices/iio:${ADCIIO_DEVICE})."
    exit 1
}
[ $# -gt 1 ] && {
    echo "Usage: $0 <adi7291_iio>"
    echo "   xilinx_adc_iio: ADC IIO deviceN (e.g. /sys/bus/iio/devices/iio:${ADCIIO_DEVICE})."
    exit 1
}

ADI7291_ADCIIO=/sys/bus/iio/devices/iio:$1

function read_temp()
{
    VAL=$1
    RAW=`cat ${ADI7291_ADCIIO}/in_${VAL}_raw`
    SCALE=`cat ${ADI7291_ADCIIO}/in_temp0_scale`
    RES=`echo - | awk "{print $SCALE*$RAW}"`
    echo "$VAL=$RES mC"
}

function read_vcc()
{
    VAL=$1
    RAW=`cat ${ADI7291_ADCIIO}/in_${VAL}_raw`
    SCALE=`cat ${ADI7291_ADCIIO}/in_voltage_scale`
    RES=`echo - | awk "{print $SCALE*$RAW}"`
    echo "$VAL=$RES mV"
}

cat ${ADI7291_ADCIIO}/name

read_temp "temp0"
read_temp "temp0_mean"

read_vcc "voltage0"
read_vcc "voltage1"
read_vcc "voltage2"
read_vcc "voltage3"
read_vcc "voltage4"
read_vcc "voltage5"
read_vcc "voltage6"
read_vcc "voltage7"

