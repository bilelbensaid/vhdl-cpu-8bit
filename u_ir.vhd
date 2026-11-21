library IEEE;
use IEEE.std_logic_1164.ALL;


-- Instruction register -- 
entity IR is
	port(
		ir_in: in std_logic_vector(15 downto 0);
		ir_ld: in std_logic; 
		ir_out: out std_logic_vector(15 downto 0);
		clk: in std_logic;
		rstb: in std_logic
	); 
end entity IR;


architecture behv of IR is
begin
	p1:process(clk, rstb)
		begin
			if rstb ='0' then
				ir_out <= (others => '0');
			elsif rising_edge(clk) then
				if ir_ld = '1' then
					ir_out <= ir_in;
				end if;
			end if;
		end process p1;
end architecture behv;
