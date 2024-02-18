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
		hex_out: out STD_LOGIC_VECTOR(6 downto 0)--;
		--hex_cout: out STD_LOGIC_VECTOR(6 downto 0)
		
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
	
	process(s)
	begin 
		case s is
            when "0000" =>
                hex_out <= "0000001"; -- 0
            when "0001" =>
                hex_out <= "1001111"; -- 1
            when "0010" =>
                hex_out <= "0010010"; -- 2
            when "0011" =>
                hex_out <= "0000110"; -- 3
            when "0100" =>
                hex_out <= "1001100"; -- 4
            when "0101" =>
                hex_out <= "0100100"; -- 5
            when "0110" =>
                hex_out <= "0100000"; -- 6
            when "0111" =>
                hex_out <= "0001111"; -- 7
            when "1000" =>
                hex_out <= "0000000"; -- 8
            when "1001" =>
                hex_out <= "0000100"; -- 9
            when "1010" =>
                hex_out <= "0001000"; -- A
            when "1011" =>
                hex_out <= "1100000"; -- B
            when "1100" =>
                hex_out <= "0110001"; -- C
            when "1101" =>
                hex_out <= "1000010"; -- D
            when "1110" =>
                hex_out <= "0110000"; -- E
            when "1111" =>
                hex_out <= "0111000"; -- F
            when others =>
                hex_out <= "1111111"; -- Off
        end case;
	
	end process;

	
end;
