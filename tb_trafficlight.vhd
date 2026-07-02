library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_light_tb is
end traffic_light_tb;

architecture sim of traffic_light_tb is
    signal clk, reset, emergency : STD_LOGIC := '0';
    signal NS_light, EW_light : STD_LOGIC_VECTOR(2 downto 0);
begin
    -- Instantiate Unit Under Test (UUT)
    uut: entity work.traffic_light
        port map(clk => clk, reset => reset, emergency => emergency,
                 NS_light => NS_light, EW_light => EW_light);

    -- Clock process (20 ns period)
    clk_process: process
    begin
        while true loop
            clk <= '0'; wait for 10 ns;
            clk <= '1'; wait for 10 ns;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset system
        reset <= '1'; wait for 20 ns;
        reset <= '0'; wait for 200 ns;

        -- Trigger emergency
        emergency <= '1'; wait for 40 ns;
        emergency <= '0'; wait for 200 ns;

        -- Continue normal cycle
        wait;
    end process;
end sim;


