library IEEE;

use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;



entity testbench is
end entity testbench;




architecture sim_behv of testbench is
	component Accumulateur is 
	port(
		clk: in std_logic;
		rstb: in std_logic;
		acc_ld: in std_logic;
		acc_in: in std_logic_vector(3 downto 0);
		acc_out: out std_logic_vector(3 downto 0)
	);
	end component Accumulateur;

	signal clk: std_logic := '0';
	signal rstb: std_logic := '1';
	signal acc_ld: std_logic;
	signal acc_in: std_logic_vector(3 downto 0);
	signal acc_out: std_logic_vector(3 downto 0);
begin
	UUT: Accumulateur port map(
		clk => clk,
		rstb => rstb,
		acc_ld => acc_ld,
		acc_in => acc_in,
		acc_out => acc_out
	);
	
	clk <= not clk after 10 ns;
	stimuli:process
		begin
		     wait for 10 ns;
		     rstb <= '0';
		     acc_ld <= '1';
		     acc_in <= std_logic_vector(to_unsigned(6, 4));
		     wait;
	end process stimuli;
end architecture sim_behv;
