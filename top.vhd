library IEEE;
use IEEE.std_logic_1164.ALL;


entity CPU is
	port(
		clk: in std_logic;
		rstb: in std_logic;
		cpu_out: out std_logic_vector(7 downto 0)
	);
end entity CPU;


architecture structural of CPU is
	
	component ALU is
	port(
		alu_sel: in std_logic_vector(2 downto 0);
		alu_in_A: in std_logic_vector(7 downto 0);
		alu_in_B: in std_logic_vector(7 downto 0);
		alu_out: out std_logic_vector(7 downto 0)
	);
	end component ALU;

	signal alu_sel : std_logic_vector(2 downto 0);


	component Accumulateur is 
	port(
		clk: in std_logic;
		rstb: in std_logic;
		acc_ld: in std_logic;
		acc_in: in std_logic_vector(7 downto 0);
		acc_out: out std_logic_vector(7 downto 0)
	);
	end component Accumulateur;

	signal acc_ld: std_logic;
	signal acc_in: std_logic_vector(7 downto 0);
	signal acc_out: std_logic_vector(7 downto 0);

	component IR is
	port(
		ir_in: in std_logic_vector(15 downto 0);
		ir_ld: in std_logic; 
		ir_out: out std_logic_vector(15 downto 0);
		clk: in std_logic;
		rstb: in std_logic
	); 
	end component IR;

	signal ir_in : std_logic_vector(15 downto 0);
	signal ir_ld : std_logic;
	signal ir_out : std_logic_vector(15 downto 0);

	component PC is
	port(	
		clk: in std_logic;
		rstb: in std_logic;
		pc_ld: in std_logic;
		pc_inc: in std_logic;
		pc_addr_in: in std_logic_vector(7 downto 0);
		pc_addr_out: out std_logic_vector(7 downto 0)
	);
	end component PC;

	signal pc_ld: std_logic;
	signal pc_inc: std_logic;
	signal pc_addr_in: std_logic_vector(7 downto 0);
	signal pc_addr_out: std_logic_vector(7 downto 0);
	
	component control_unit
		port(
			control_unit_in: in std_logic_vector(15 downto 0);
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


	component ROM is
		port(
			rom_in: in std_logic_vector(7 downto 0);
			rom_read: in std_logic;
			rom_out: out std_logic_vector(15 downto 0)
		);
	end component ROM;
	signal rom_read: std_logic;
	signal rom_out: std_logic_vector(15 downto 0);

	component RAM is
		port(
			ram_in: in std_logic_vector(3 downto 0);
			ram_address_in: in std_logic_vector(7 downto 0);
			ram_we: in std_logic;
			ram_read: in std_logic;
			ram_out: out std_logic_vector(3 downto 0)
		);
	end component RAM;
	signal ram_read: std_logic;
	signal ram_we: std_logic;
	signal ram_address_in: std_logic_vector(7 downto 0);
	signal ram_in: std_logic_vector(3 downto 0);
	signal ram_out: std_logic_vector(3 downto 0);

begin
	U_ALU : 
		ALU port map (
			alu_sel => alu_sel,
			alu_in_A => acc_out,
			alu_in_B => ir_out(7 downto 0),
			alu_out => acc_in
		);

	U_ACC : 
		Accumulateur port map(
			clk => clk,
			rstb => rstb,
			acc_ld => acc_ld,
			acc_in => acc_in,
			acc_out => acc_out
		);
	
	U_IR :
		IR port map(
			ir_in => rom_out,
			ir_out => ir_out,
			ir_ld => ir_ld,
			clk => clk,
			rstb => rstb
		);

	U_PC :
		PC port map (
			clk => clk,
			rstb => rstb,
			pc_ld => pc_ld,
			pc_inc => pc_inc,
			pc_addr_in => pc_addr_in,
			pc_addr_out => pc_addr_out
		);
		
	U_control_unit: 
		control_unit port map (
			control_unit_in => ir_out,
			ir_ld => ir_ld,
			clk => clk,
			rstb => rstb,
			pc_inc => pc_inc,
			pc_ld => pc_ld,
			acc_ld => acc_ld,
			alu_sel => alu_sel,
			ram_read => ram_read,
			rom_read => rom_read,
			ram_we => ram_we
		);
	U_RAM:
		RAM port map (
			ram_we => ram_we,
			ram_address_in => ram_address_in,
			ram_read => ram_read,
			ram_in => ram_in,
			ram_out => ram_out
		);
	U_ROM:
		ROM port map(
			rom_read => rom_read,
			rom_in => pc_addr_out,
			rom_out => rom_out
		);
	cpu_out <= acc_out;
end architecture structural;
