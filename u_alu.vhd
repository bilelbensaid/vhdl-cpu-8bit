library IEEE;

use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity ALU is
	port(
		alu_sel: in std_logic_vector(2 downto 0);
		alu_in_A: in std_logic_vector(7 downto 0);
		alu_in_B: in std_logic_vector(7 downto 0);
		alu_out: out std_logic_vector(7 downto 0)
	);
end entity ALU;


architecture behv of ALU is
begin
	p1:process(alu_sel, alu_in_A, alu_in_B)
		begin	
			case alu_sel is
				when "001" => 
					alu_out <= std_logic_vector(unsigned(alu_in_A) + unsigned(alu_in_B));
				when "010" =>
					alu_out <= std_logic_vector(unsigned(alu_in_A) - unsigned(alu_in_B));
				when "011" =>
					alu_out <= std_logic_vector(shift_left(unsigned(alu_in_A), to_integer(unsigned(alu_in_B))));
				when "100" =>
					alu_out <= std_logic_vector(shift_right(unsigned(alu_in_A), to_integer(unsigned(alu_in_B))));
				when others => 
					alu_out <= (others => '0');
			end case;
	end process p1;

end architecture behv;
