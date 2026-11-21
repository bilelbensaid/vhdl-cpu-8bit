library IEEE;


use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity testbench is
end entity testbench;




architecture sim_behv of testbench is	
	
	component ALU is
	port(
		alu_sel: in std_logic_vector(2 downto 0);
		alu_in_A: in std_logic_vector(3 downto 0);
		alu_in_B: in std_logic_vector(3 downto 0);
		alu_out: out std_logic_vector(3 downto 0)
	);
	end component ALU;

	signal alu_sel : std_logic_vector(2 downto 0);
	signal alu_in_A : std_logic_vector(3 downto 0);
	signal alu_in_B : std_logic_vector(3 downto 0);
	signal alu_out : std_logic_vector(3 downto 0);

begin
	UUT : ALU port map (
		alu_sel => alu_sel,
		alu_in_A => alu_in_A,
		alu_in_B => alu_in_B,
		alu_out => alu_out
		);
	stimuli:process
		begin
			alu_in_A <= std_logic_vector(to_unsigned(5, 4));
			alu_in_B <= std_logic_vector(to_unsigned(8, 4));
			alu_sel <= "001";
			wait for 10 ns;
			alu_in_A <= std_logic_vector(to_unsigned(8, 4));
			alu_in_B <= std_logic_vector(to_unsigned(5, 4));
			alu_sel <= "010";
			wait for 5 ns;
			alu_in_A <= std_logic_vector(to_unsigned(5, 4));
			alu_in_B <= std_logic_vector(to_unsigned(1, 4));
			alu_sel <= "011";
			wait;
	end process stimuli;


end architecture sim_behv;
