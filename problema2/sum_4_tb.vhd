-- LIBRARY
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- ENTITY 
entity sum_4_tb is -- no inputs or outputs
end;

-- ARCHITECTURE
architecture testbench of sum_4_tb is
	component sum_4
		port (
			a, b: in STD_LOGIC_VECTOR(3 downto 0);
			cin: in STD_LOGIC;
			s: out STD_LOGIC_VECTOR(3 downto 0);
			cout: out STD_LOGIC
		);
	end component;
	
	-- signals for stimulus
	signal a_tb, b_tb: STD_LOGIC_VECTOR(3 downto 0);
	signal cin_tb: STD_LOGIC;
	signal s_tb: STD_LOGIC_VECTOR(3 downto 0);
	signal cout_tb: STD_LOGIC;

begin 
	-- instantiate the unit under test (UUT)
	UUT: sum_4 port map (
		a => a_tb,
		b => b_tb,
		cin => cin_tb,
		s => s_tb,
		cout => cout_tb
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
		b_tb <= "1100";
		cin_tb <= '0';
		wait for 10ns;
	
		wait;
	end process;
end;