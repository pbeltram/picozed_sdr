# clocks

create_clock -name rx_clk     -period 8.000 [get_ports rx_clk_in_p]
create_clock -name ad9361_clk -period 8.000 [get_pins i_system_wrapper/system_i/axi_ad9361/clk]
create_clock -name clkin      -period 7.000 [get_ports clkin_i]

# constraints

set_false_path -from [get_pins {i_system_wrapper/system_i/axi_ad9361/inst/i_rx/i_up_adc_common/up_adc_gpio_out_int_reg[0]/C}]
set_false_path -from [get_pins {i_system_wrapper/system_i/axi_ad9361/inst/i_tx/i_up_dac_common/up_dac_gpio_out_int_reg[0]/C}]

set_property ASYNC_REG TRUE [get_cells -hier -filter {name =~ */cdc_sync_active/inst/cdc_sync_stage1_reg*}]
set_property ASYNC_REG TRUE [get_cells -hier -filter {name =~ */cdc_sync_active/inst/cdc_sync_stage2_reg*}]

set_false_path  -to [get_cells -hierarchical -filter {name =~ */cdc_sync_active/inst/cdc_sync_stage1_reg** && IS_SEQUENTIAL}]
set_false_path  -to [get_cells -hierarchical -filter {name =~ */cdc_sync_active/inst/cdc_sync_stage2_reg** && IS_SEQUENTIAL}]
