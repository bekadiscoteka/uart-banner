vlib work
vlog -work work tb.v
vsim work.stimulus
add wave -r sim:/stimulus/*
run -all



