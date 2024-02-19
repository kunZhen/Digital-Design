-- LIBRARY
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- ENTITY
entity seven_segments is 
	port(
		a, b: in STD_LOGIC_VECTOR(3 downto 0);
		cin: in STD_LOGIC;
		s: buffer STD_LOGIC_VECTOR(3 downto 0);
		cout: buffer STD_LOGIC;
		hex_out: out STD_LOGIC_VECTOR(6 downto 0);
		hex_cout: out STD_LOGIC_VECTOR(6 downto 0)
		
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
	
	process(s, cout)
	begin
		if s = "0000" then
			hex_out <= "0000001"; -- 0
		elsif s = "0001" then
			hex_out <= "1001111"; -- 1
		elsif s = "0010" then
			hex_out <= "0010010"; -- 2
		elsif s = "0011" then
			hex_out <= "0000110"; -- 3
		elsif s = "0100" then
			hex_out <= "1001100"; -- 4
		elsif s = "0101" then
			hex_out <= "0100100"; -- 5
		elsif s = "0110" then
			hex_out <= "0100000"; -- 6
		elsif s = "0111" then
			hex_out <= "0001111"; -- 7
		elsif s = "1000" then
			hex_out <= "0000000"; -- 8
		elsif s = "1001" then
			hex_out <= "0000100"; -- 9
		elsif s = "1010" then
			hex_out <= "0001000"; -- A
		elsif s = "1011" then
			hex_out <= "1100000"; -- B
		elsif s = "1100" then
			hex_out <= "0110001"; -- C
		elsif s = "1101" then
			hex_out <= "1000010"; -- D
		elsif s = "1110" then
			hex_out <= "0110000"; -- E
		elsif s = "1111" then
			hex_out <= "0111000"; -- F
		else
			hex_out <= "1111111"; -- off
		end if;
			
		if cout = '0' then
			hex_cout <= "0000001"; -- 0
		else
			hex_cout <= "1001111"; -- 1
		end if;
	
	end process;
	
	
end;
