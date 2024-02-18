-- LIBRARY
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- ENTITY 
entity seven_segmets_tb is -- no inputs or outputs
end;

-- ARCHITECTURE
architecture testbench of seven_segmets_tb is
	component seven_segments 
		port(
		a, b: in STD_LOGIC_VECTOR(3 downto 0);
		cin: in STD_LOGIC;
		s: out STD_LOGIC_VECTOR(3 downto 0);
		cout: out STD_LOGIC;
		hex_out: out STD_LOGIC_VECTOR(6 downto 0)--;
		--hex_cout: out STD_LOGIC_VECTOR(6 downto 0)
	);
	end component;
	
	-- signals for stimulus
	signal a_tb, b_tb: STD_LOGIC_VECTOR(3 downto 0);
	signal cin_tb: STD_LOGIC;
	signal s_tb: STD_LOGIC_VECTOR(3 downto 0);
	signal cout_tb: STD_LOGIC;
	signal hex_out_tb: STD_LOGIC_VECTOR(6 downto 0);
	--signal hex_cout_tb: STD_LOGIC_VECTOR(6 downto 0);
	
	
begin

	-- instantiate the unit under test (UUT)
	UUT: seven_segments port map (
		a => a_tb,
		b => b_tb,
		cin => cin_tb,
		s => s_tb,
		cout => cout_tb,
		hex_out => hex_out_tb--,
		--hex_cout => hex_cout_tb
	);
	
	process begin
		-- test cases
		a_tb <= "0000";
		b_tb <= "0000";
		cin_tb <= '0';
		wait for 10ns;
		
		a_tb <= "0001";
		b_tb <= "0001";
		cin_tb <= '0';
		wait for 10ns;
		
		a_tb <= "0001";
		b_tb <= "0000";
		cin_tb <= '0';
		wait for 10ns;
		
		a_tb <= "1111";
		b_tb <= "1111";
		cin_tb <= '0';
		wait for 10ns;
	
		wait;
	end process;

end;