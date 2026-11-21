library IEEE;

use IEEE.std_logic_1164.ALL;


entity control_unit is
	port(
		control_unit_in: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		rstb: in std_logic;
		acc_ld: out std_logic;
		alu_sel: out std_logic_vector(2 downto 0);
		ram_we: out std_logic;
		ram_read: out std_logic;
		rom_read: out std_logic;
		ir_ld: out std_logic;
		pc_ld: out std_logic;
		pc_inc: out std_logic
	);
end entity control_unit;

architecture behv of control_unit is
	type defState is (FETCH, DECODE, EXECUTE);
	signal state, next_state : defState;

	
	constant ADD : std_logic_vector(7 downto 0) := "00000001";
	constant SUB : std_logic_vector(7 downto 0) := "00000010";
	constant LSL : std_logic_vector(7 downto 0) := "00000011";
	constant LSR : std_logic_vector(7 downto 0) := "00000100";
	signal instruction : std_logic_vector(7 downto 0);
begin
	Comb:process(state, instruction)
		begin	
			rom_read <= '0';	
			pc_inc <= '1';
			acc_ld <= '0';
			pc_ld <= '0';

			case instruction is
						when ADD =>
							alu_sel <= "001";
						when SUB =>
							alu_sel <= "010";
						when LSL =>
							alu_sel <= "011";
						when LSR =>
							alu_sel <= "100";
						when others =>
							alu_sel <= "000";
					end case;
			case state is
				when FETCH =>
					pc_inc <= '0';
					rom_read <= '1';
					ir_ld <= '1';
					next_state <= DECODE;
				when DECODE =>
					rom_read <= '0';
					ir_ld <= '0';
					next_state <= EXECUTE;
				when EXECUTE =>
					if instruction = "00000000" then acc_ld <= '0';
					else 
						acc_ld <= '1';
						
					end if;
					pc_inc <= '0';
					next_state <= FETCH;
			end case;
	end process Comb;

	instruction <= control_unit_in(15 downto 8);
	Seq:process(clk, rstb)
		begin
			if rstb = '0' then
				state <= FETCH;
			elsif rising_edge(clk) then
				state <= next_state;
			end if;
	end process Seq;


end architecture behv;
