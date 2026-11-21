library IEEE;

use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;





entity RAM is
	port(
		ram_in: in std_logic_vector(3 downto 0);
		ram_address_in: in std_logic_vector(7 downto 0);
		ram_we: in std_logic;
		ram_read: in std_logic;
		ram_out: out std_logic_vector(3 downto 0)
	);
end entity RAM;



architecture behv of RAM is

	type type_ram is array (0 to 255) of std_logic_vector(3 downto 0);
	signal RAM : type_ram := (
		0 => "0001",
		1 => "1000",
		others => (others => '0')
		
	);
begin
	p1:process(ram_read, ram_we, ram_address_in, ram_in)
		begin
			if ram_read = '1' then
				ram_out <= RAM(to_integer(unsigned(ram_address_in)));
			elsif ram_we = '1' then	
				RAM(to_integer(unsigned(ram_address_in))) <= ram_in;
			end if;
	end process p1;

end architecture behv;
