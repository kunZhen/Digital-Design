-- LIBRARY
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ENTITY
entity sum_4 is
	port (
		a, b: in STD_LOGIC_VECTOR(3 downto 0); -- inputs of 4 bits
		cin: in STD_LOGIC; -- input carry
		s: out STD_LOGIC_VECTOR(3 downto 0); -- sum
		cout: out STD_LOGIC -- out carry
	);
end;

-- ARCHITECTURE
architecture adder of sum_4 is 
	signal c: STD_LOGIC_VECTOR(3 downto 0); -- intermediate carry vector
	
	component sum_1
		port (
			a, b, cin: in STD_LOGIC;
			s, cout: out STD_LOGIC
		);
	end component;
	
begin
	-- instances of sum_1 for each bit
	sum_1_bit0: sum_1 port map (a(0), b(0), cin, s(0), c(0));
	sum_1_bit1: sum_1 port map (a(1), b(1), c(0), s(1), c(1));
	sum_1_bit2: sum_1 port map (a(2), b(2), c(1), s(2), c(2));
	sum_1_bit3: sum_1 port map (a(3), b(3), c(2), s(3), cout);
end;