library IEEE;


use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity testbench is
end entity testbench;



architecture sim_behv of testbench is
	component IR is
	port(
		ir_in: in std_logic_vector(7 downto 0);
		ir_ld: in std_logic; 
		ir_out: out std_logic_vector(3 downto 0);
		clk: in std_logic;
		rstb: in std_logic
	); 
	end component IR;


	signal ir_in : std_logic_vector(7 downto 0);
	signal ir_ld : std_logic;
	signal ir_out : std_logic_vector(3 downto 0);
	signal clk : std_logic := '0';
	signal rstb : std_logic := '1';
	
begin
	UUT : IR port map(
			ir_in => ir_in,
			ir_out => ir_out,
			ir_ld => ir_ld,
			clk => clk,
			rstb => rstb
		);
	clk <= not clk after 10 ns;
	stimuli:process
		begin
			wait for 5 ns;
			rstb <= '0';
			ir_in <= "00100100";
			ir_ld <= '1';
			wait;
		end process stimuli;



end architecture sim_behv;
