library IEEE;

use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity ROM is
	port(
		rom_in: in std_logic_vector(7 downto 0);
		rom_read: in std_logic;
		rom_out: out std_logic_vector(15 downto 0)
		
	);
end entity ROM;


architecture behv of ROM is
	type rom_type is array (0 to 255) of std_logic_vector(15 downto 0);
	    constant ROM : rom_type := (
			0 => "0000000000000000",
			1 => "0000000100001110",
			2 => "0000010000000001",
			3 => "0000001100000001",
			others => (others => '0')
		);
	begin
	   p1:process(rom_read, rom_in)
		begin
			if rom_read = '1' then
				rom_out <= ROM(to_integer(unsigned(rom_in)));
			else 
				
			end if;
	   end process p1;
end architecture behv;
