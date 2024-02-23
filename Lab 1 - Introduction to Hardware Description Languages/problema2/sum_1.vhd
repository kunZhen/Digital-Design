-- LIBRARY
library IEEE; 
use IEEE.STD_LOGIC_1164.all;

-- ENTITY : declares module name and its inputs and outputs
entity sum_1 is
	port (a, b, cin: in STD_LOGIC;
			s, cout: out STD_LOGIC);
end;

-- ARCHITECTURE "synth" of "sum_1" : define what module does
architecture synth of sum_1 is 
	signal p, g: STD_LOGIC; -- p, g internal signals
	
begin
	p <= a xor b;
	g <= a and b;
	
	s <= p xor cin;
	cout <= g or (p and cin);
end;
	