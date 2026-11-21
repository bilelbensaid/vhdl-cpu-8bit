library IEEE;
use IEEE.std_logic_1164.ALL;



entity testbench is
end entity testbench;



architecture sim_behv of testbench is
	component CPU is
	port(
		clk: in std_logic;
		rstb: in std_logic;
		cpu_out: out std_logic_vector(7 downto 0)
	);
	end component CPU;
	
	signal clk: std_logic := '0';
	signal rstb: std_logic := '0';
	signal cpu_out: std_logic_vector(7 downto 0);
begin

	U_CPU : 
	CPU port map (
    		clk     => clk,
    		rstb    => rstb,
    		cpu_out => cpu_out
	);
	clk <= not clk after 10 ns;
	stimuli:process
		begin
			wait for 20 ns;
			rstb <= '1';
			wait;
			
	end process stimuli;



end architecture sim_behv;
