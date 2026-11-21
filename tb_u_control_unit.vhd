library IEEE;


use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;




entity testbench is
end entity testbench;


architecture sim_behv of testbench is
	component control_unit is
	port(
		control_unit_in: in std_logic_vector(7 downto 0);
		clk: in std_logic;
		rstb: in std_logic;
		acc_ld: out std_logic;
		alu_sel: out std_logic_vector(2 downto 0);
		ram_we: out std_logic;
		ram_read: out std_logic;
		rom_read: out std_logic;
		ir_ld: out std_logic;
		pc_ld: out std_logic;
		pc_inc: out std_logic
	);
	end component control_unit;


	signal control_unit_in: std_logic_vector(7 downto 0);
	signal clk: std_logic := '0';
	signal rstb: std_logic := '1';
	signal acc_ld: std_logic;
	signal ram_we: std_logic;
	signal ram_read: std_logic;
	signal rom_read: std_logic;
	signal ir_ld: std_logic;
	signal pc_ld: std_logic;
	signal pc_inc: std_logic;
	signal alu_sel: std_logic_vector(2 downto 0);
begin
	UUT: control_unit port map(
		clk => clk,
		rstb => rstb,
		acc_ld => acc_ld,
		ram_we => ram_we,
		ram_read => ram_read,
		rom_read => rom_read,
		ir_ld => ir_ld,
		pc_ld => pc_ld,
		pc_inc => pc_inc,
		alu_sel => alu_sel,
		control_unit_in => control_unit_in
	);

	clk <= not clk after 10 ns;
	
	stimuli:process
		begin
		wait for 5 ns;
		rstb <= '0';
		control_unit_in <= "00010001";
		wait;
	end process stimuli;


end architecture sim_behv;
