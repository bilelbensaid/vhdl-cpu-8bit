library IEEE;

use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PC is
	port(	
		clk: in std_logic;
		rstb: in std_logic;
		pc_ld: in std_logic;
		pc_inc: in std_logic;
		pc_addr_in: in std_logic_vector(7 downto 0);
		pc_addr_out: out std_logic_vector(7 downto 0)
	);
end entity PC;

architecture behv of PC is
	signal pc_addr_out_tmp: std_logic_vector(7 downto 0);
begin
	p1:process(clk, rstb)
		begin
			if rstb = '0' then
				pc_addr_out_tmp <= (others => '0');
			elsif rising_edge(clk) then
				 if pc_inc = '1' then
					pc_addr_out_tmp <= std_logic_vector(unsigned(pc_addr_out_tmp) + 1);
				 elsif pc_ld = '1' then
				        pc_addr_out_tmp <= pc_addr_in;
				 end if;
			end if;
		end process p1;
	pc_addr_out <= pc_addr_out_tmp;
end architecture behv;