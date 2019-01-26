transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/sm.v}
vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/regfile.v}
vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/reg16.v}
vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/muxreg16.v}
vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/cpu.v}
vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/alu.v}
vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/imem.v}
vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/dmem.v}
vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/count16rle.v}

vlog -vlog01compat -work work +incdir+G:/FPGA/cpu_pipeline {G:/FPGA/cpu_pipeline/cpu2_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  cpu_tb

add wave *
view structure
view signals
run -all
