library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sum_4_tb is
end sum_4_tb;

architecture testbench of sum_4_tb is
    signal a, b: std_logic_vector(3 downto 0);
    signal cin: std_logic;
    signal s: std_logic_vector(3 downto 0);
    signal cout: std_logic;

    -- Component declaration for el sumador de 1 bit (sum_1)
    component sum_1
        port (
            a, b, cin: in std_logic;
            s, cout: out std_logic
        );
    end component;

begin
    -- Instantiate the sumador de 1 bit (sum_1) cuatro veces
    sumador_0: sum_1 port map (
        a => a(0),
        b => b(0),
        cin => cin,
        s => s(0),
        cout => cout
    );

    sumador_1: sum_1 port map (
        a => a(1),
        b => b(1),
        cin => cout,
        s => s(1),
        cout => cout
    );

    sumador_2: sum_1 port map (
        a => a(2),
        b => b(2),
        cin => cout,
        s => s(2),
        cout => cout
    );

    sumador_3: sum_1 port map (
        a => a(3),
        b => b(3),
        cin => cout,
        s => s(3),
        cout => cout
    );

    -- Stimulus process
    stimulus: process
    begin
        -- Initialize inputs
        a <= (others => '0');
        b <= (others => '0');
        cin <= '0';

        -- Wait for a few clock cycles before changing inputs
        wait for 10 ns;

        -- Test all combinations of inputs
        for i in 0 to 15 loop
            a <= std_logic_vector(to_unsigned(i, 4));
            for j in 0 to 15 loop
                b <= std_logic_vector(to_unsigned(j, 4));
                for k in 0 to 1 loop
                    cin <= std_logic(k);
                    wait for 10 ns;
                end loop;
            end loop;
        end loop;

        -- End simulation
        wait;
    end process stimulus;

end architecture testbench;
