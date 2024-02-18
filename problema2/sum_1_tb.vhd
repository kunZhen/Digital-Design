-- LIBRARY
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- ENTITY 
entity sum_1_tb is -- no inputs or outputs
end;

-- ARQUITECTURE
architecture testbench of sum_1_tb is
    signal a, b, cin, s, cout: STD_LOGIC;

    -- Component declaration for the unit under test (UUT)
    component sum_1
        port (
            a, b, cin: in STD_LOGIC;
            s, cout: out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the unit under test (UUT)
    UUT: sum_1 port map (
        a => a,
        b => b,
        cin => cin,
        s => s,
        cout => cout
    );

    -- Stimulus process
    stimulus: process
    begin
        -- Initialize inputs
        a <= '0';
        b <= '0';
        cin <= '0';

        -- Wait for a few clock cycles before changing inputs
        wait for 10 ns;

        -- Test case 1: a = 0, b = 0, cin = 0
        a <= '0';
        b <= '0';
        cin <= '0';
        wait for 10 ns;
        
        -- Test case 2: a = 1, b = 0, cin = 0
        a <= '1';
        b <= '0';
        cin <= '0';
        wait for 10 ns;
        
        -- Test case 3: a = 0, b = 1, cin = 0
        a <= '0';
        b <= '1';
        cin <= '0';
        wait for 10 ns;
        
        -- Test case 4: a = 1, b = 1, cin = 0
        a <= '1';
        b <= '1';
        cin <= '0';
        wait for 10 ns;

        -- Test case 5: a = 0, b = 0, cin = 1
        a <= '0';
        b <= '0';
        cin <= '1';
        wait for 10 ns;

        -- Test case 6: a = 1, b = 0, cin = 1
        a <= '1';
        b <= '0';
        cin <= '1';
        wait for 10 ns;

        -- Test case 7: a = 0, b = 1, cin = 1
        a <= '0';
        b <= '1';
        cin <= '1';
        wait for 10 ns;

        -- Test case 8: a = 1, b = 1, cin = 1
        a <= '1';
        b <= '1';
        cin <= '1';
        wait for 10 ns;

        -- End simulation
        wait;
    end process stimulus;

end architecture testbench;
