# Simulation script for ModelSim

# Turn on transcript
transcript on

# Quit the previous simulation (ignore error if none is loaded)
catch {quit -sim}

# Compilation of VHDL files (respect order of dependencies)
vcom u_acc.vhd
vcom u_alu.vhd
vcom u_rom.vhd
vcom u_ram.vhd
vcom u_ir.vhd
vcom u_pc.vhd
vcom u_control_unit.vhd
vcom top.vhd
vcom tb_top.vhd

# Run simulation
vsim -voptargs=+acc work.testbench(sim_behv)

# Reference the configuration file for waves in the variable wavefile
set wavefile "./wave_old.do"

if {[file exists $wavefile]} {
    # Add signals described in the file in the windows
    puts ">> Loading the file $wavefile"
    do $wavefile
} else {
    # Add recursive signals in the windows
    puts ">> $wavefile not found : automatic signal addition"
    add wave -r *
}

# Run simulation
run 500 ns

# Display the simulation on the entire window
wave zoom full

