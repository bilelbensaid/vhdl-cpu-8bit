library IEEE;

use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity Accumulateur is
	port(
		clk: in std_logic;
		rstb: in std_logic;
		acc_ld: in std_logic;
		acc_in: in std_logic_vector(7 downto 0);
		acc_out: out std_logic_vector(7 downto 0)
	);
end entity Accumulateur;


architecture behv of Accumulateur is
begin
	p1:process(clk, rstb)
		begin
			if rstb = '0' then
				acc_out <= (others => '0');
			elsif rising_edge(clk) then 
				if acc_ld = '1' then
					acc_out <= acc_in;
				end if;
			end if;
	end process p1;

end architecture behv;
