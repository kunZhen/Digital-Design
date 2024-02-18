-- LIBRARY
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- ENTITY
entity seven_segments is 
	port(
		a, b: in STD_LOGIC_VECTOR(3 downto 0);
		cin: in STD_LOGIC;
		s: out STD_LOGIC_VECTOR(3 downto 0);
		cout: out STD_LOGIC--;
		--hex_out: out STD_LOGIC_VECTOR(6 downto 0)
	);
end;

-- ARCHITECTURE
architecture seven_segments_display of seven_segments is
	component sum_4 
		port (
			a, b: in STD_LOGIC_VECTOR(3 downto 0); -- inputs of 4 bits
			cin: in STD_LOGIC; -- input carry
			s: out STD_LOGIC_VECTOR(3 downto 0); -- sum
			cout: out STD_LOGIC -- out carry
		);
	end component;

begin
	sum_4_bits: sum_4 port map (a, b, cin, s, cout);
end;
