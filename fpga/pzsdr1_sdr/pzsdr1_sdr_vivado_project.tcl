################################################################################
# Vivado tcl script to create project
#
# Usage:
# vivado -mode batch -source pzsdr1_sdr_vivado_project.tcl
################################################################################

################################################################################
# defines
################################################################################

set part xc7z020clg400-1
set project_name pzsdr1_sdr
set path_sdc ./sdc
set path_bd ./bd
set path_src ./hdl
set path_run ./project_${project_name}

################################################################################
# setup project
################################################################################

create_project $project_name -part $part -force $path_run
#set_property ip_repo_paths [concat [get_property ip_repo_paths [current_project]] {../ip-repo}] [current_project]
set_property ip_repo_paths [concat [get_property ip_repo_paths [current_project]] {../hdl-analog/library}] [current_project]
update_ip_catalog -rebuild

################################################################################
# create PS BD (processing system block design)
################################################################################
add_files -norecurse $path_src/sync_bits.v
add_files -norecurse $path_src/ad_bus_mux.v
add_files -norecurse $path_src/util_pulse_gen.v

# file was created from GUI using "write_bd_tcl -force system_${project_name}.tcl"
# create System BD
source $path_bd/system_${project_name}.tcl
regenerate_bd_layout
validate_bd_design
save_bd_design

################################################################################
# read files
################################################################################

add_files -fileset constrs_1 -norecurse $path_sdc/${project_name}.xdc $path_sdc/${project_name}_pins.xdc

################################################################################
# configure project
################################################################################

# generate IP files
generate_target all [get_files system.bd]

make_wrapper -files [get_files $path_run/$project_name.srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse $path_run/$project_name.srcs/sources_1/bd/system/hdl/system_wrapper.v

add_files -norecurse $path_src/system_top.v
add_files -norecurse $path_src/ad_iobuf.v
update_compile_order -fileset sources_1

set_property top system_top [current_fileset]


