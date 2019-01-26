transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/FPGA/cpu/imem.vhd}

vlog -vlog01compat -work work +incdir+D:/FPGA/cpu {D:/FPGA/cpu/imem_tb.v}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  imem_tb

add wave *
view structure
view signals
run -all
