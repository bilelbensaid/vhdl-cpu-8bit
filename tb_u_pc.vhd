library IEEE;

use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity testbench is
end entity testbench;


architecture sim_behv of testbench is

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

	signal clk: std_logic := '0';
	signal rstb: std_logic := '1';
	signal pc_ld: std_logic;
	signal pc_inc: std_logic;
	signal pc_addr_in: std_logic_vector(7 downto 0);
	signal pc_addr_out: std_logic_vector(7 downto 0);

begin
	UUT : PC port map (
		clk => clk,
		rstb => rstb,
		pc_ld => pc_ld,
		pc_inc => pc_inc,
		pc_addr_in => pc_addr_in,
		pc_addr_out => pc_addr_out
	);
	clk <= not clk after 10 ns;

	stimuli:process
		begin
			wait for 5 ns;
			rstb <= '0';
			pc_ld <= '0';
			pc_addr_in <= (others => '0');
			pc_inc <= '1';
			wait for 200 ns;
			pc_addr_in <= std_logic_vector(to_unsigned(13, 8));
			pc_inc <= '0';
			pc_ld <= '1';
			wait;
			
	end process stimuli;
		

end architecture sim_behv;
