// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (

  inout   [14:0]  ddr_addr,
  inout   [ 2:0]  ddr_ba,
  inout           ddr_cas_n,
  inout           ddr_ck_n,
  inout           ddr_ck_p,
  inout           ddr_cke,
  inout           ddr_cs_n,
  inout   [ 3:0]  ddr_dm,
  inout   [31:0]  ddr_dq,
  inout   [ 3:0]  ddr_dqs_n,
  inout   [ 3:0]  ddr_dqs_p,
  inout           ddr_odt,
  inout           ddr_ras_n,
  inout           ddr_reset_n,
  inout           ddr_we_n,

  inout           fixed_io_ddr_vrn,
  inout           fixed_io_ddr_vrp,
  inout   [53:0]  fixed_io_mio,
  inout           fixed_io_ps_clk,
  inout           fixed_io_ps_porb,
  inout           fixed_io_ps_srstb,

  inout           iic_main_scl_io,
  inout           iic_main_sda_io,

  input           rx_clk_in_p,
  input           rx_clk_in_n,
  input           rx_frame_in_p,
  input           rx_frame_in_n,
  input   [ 5:0]  rx_data_in_p,
  input   [ 5:0]  rx_data_in_n,
  output          tx_clk_out_p,
  output          tx_clk_out_n,
  output          tx_frame_out_p,
  output          tx_frame_out_n,
  output  [ 5:0]  tx_data_out_p,
  output  [ 5:0]  tx_data_out_n,

  output          enable,
  output          txnrx,
  input           clkin_i,

  input   [3-1:0]  pb_gpio_i,
  input            fan_spin_i,
  output           fan_o,
  output           led_o,

  inout           clksel_io,
  inout           resetb_io,
  inout           sync_io,
  inout           en_agc_io,
  inout   [4-1:0] ctrl_out_io,
  inout   [8-1:0] ctrl_in_io,

  output          spi0_clk_o,
  output          spi0_csn_0_o,
  output          spi0_sdo_o,
  input           spi0_sdi_i
);

wire [0:0] led;
assign led_o = led[0];

// GPIO sliceing
wire [64-1:0]  gpio_i;
wire [64-1:0]  gpio_o;
wire [64-1:0]  gpio_t;

wire up_enable;
wire up_txnrx;

// board gpio - 31-0
assign gpio_i[31:21] = gpio_o[31:21];
assign gpio_i[20] = fan_spin_i;
assign gpio_i[19] = gpio_o[19];
assign fan_o = gpio_o[19];
assign gpio_i[18:16] = pb_gpio_i;
assign gpio_i[15: 0] = 16'd1091; //Firmware ID.

// ad9361 gpio - 63-32
assign gpio_i[63:52] = gpio_o[63:52];
assign up_enable = gpio_o[47];
assign up_txnrx  = gpio_o[48];
assign gpio_i[50:47] = gpio_o[50:47];

ad_iobuf 
#(
  .DATA_WIDTH (16)
) 
i_iobuf 
(
  .dio_t ({gpio_t[51], gpio_t[46:32]}),
  .dio_i ({gpio_o[51], gpio_o[46:32]}),
  .dio_o ({gpio_i[51], gpio_i[46:32]}),
  .dio_p ({clksel_io,        // 51:51
           resetb_io,        // 46:46
           sync_io,          // 45:45
           en_agc_io,        // 44:44
           ctrl_out_io,      // 43:40
           ctrl_in_io})      // 39:32
);

// instantiations
system_wrapper i_system_wrapper 
(
  .ddr_addr (ddr_addr),
  .ddr_ba (ddr_ba),
  .ddr_cas_n (ddr_cas_n),
  .ddr_ck_n (ddr_ck_n),
  .ddr_ck_p (ddr_ck_p),
  .ddr_cke (ddr_cke),
  .ddr_cs_n (ddr_cs_n),
  .ddr_dm (ddr_dm),
  .ddr_dq (ddr_dq),
  .ddr_dqs_n (ddr_dqs_n),
  .ddr_dqs_p (ddr_dqs_p),
  .ddr_odt (ddr_odt),
  .ddr_ras_n (ddr_ras_n),
  .ddr_reset_n (ddr_reset_n),
  .ddr_we_n (ddr_we_n),

  .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
  .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
  .fixed_io_mio (fixed_io_mio),
  .fixed_io_ps_clk (fixed_io_ps_clk),
  .fixed_io_ps_porb (fixed_io_ps_porb),
  .fixed_io_ps_srstb (fixed_io_ps_srstb),

  .rx_clk_in_n (rx_clk_in_n),
  .rx_clk_in_p (rx_clk_in_p),
  .rx_data_in_n (rx_data_in_n),
  .rx_data_in_p (rx_data_in_p),
  .rx_frame_in_n (rx_frame_in_n),
  .rx_frame_in_p (rx_frame_in_p),

  .tx_clk_out_n (tx_clk_out_n),
  .tx_clk_out_p (tx_clk_out_p),
  .tx_data_out_n (tx_data_out_n),
  .tx_data_out_p (tx_data_out_p),
  .tx_frame_out_n (tx_frame_out_n),
  .tx_frame_out_p (tx_frame_out_p),

  .enable  (enable),
  .txnrx   (txnrx),
  .clkin_i (clkin_i),
    
  .led_o   (led),

  .gpio_i (gpio_i),
  .gpio_o (gpio_o),
  .gpio_t (gpio_t),

  .iic_main_scl_io (iic_main_scl_io),
  .iic_main_sda_io (iic_main_sda_io),

  .spi0_clk_o   (spi0_clk_o),
  .spi0_csn_0_o (spi0_csn_0_o),
  .spi0_sdi_i   (spi0_sdi_i),
  .spi0_sdo_o   (spi0_sdo_o),
    
  .up_enable_i (up_enable),
  .up_txnrx_i  (up_txnrx)
);

endmodule

// ***************************************************************************
// ***************************************************************************
