library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity traffic_light is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        emergency : in  STD_LOGIC;
        NS_light  : out STD_LOGIC_VECTOR(2 downto 0); -- R,Y,G
        EW_light  : out STD_LOGIC_VECTOR(2 downto 0)  -- R,Y,G
    );
end traffic_light;

architecture Behavioral of traffic_light is
    type state_type is (NS_GREEN, NS_YELLOW, EW_GREEN, EW_YELLOW, ALL_RED);
    signal state, next_state : state_type := NS_GREEN;
    signal timer : integer := 0;
begin
    -- State register
    process(clk, reset)
    begin
        if reset = '1' then
            state <= NS_GREEN;
            timer <= 0;
        elsif rising_edge(clk) then
            state <= next_state;
            if timer = 9 then
                timer <= 0;
            else
                timer <= timer + 1;
            end if;
        end if;
    end process;

    -- Next state logic
    process(state, emergency, timer)
    begin
        if emergency = '1' then
            next_state <= ALL_RED;
        else
            case state is
                when NS_GREEN  => if timer = 5 then next_state <= NS_YELLOW; else next_state <= NS_GREEN; end if;
                when NS_YELLOW => if timer = 2 then next_state <= EW_GREEN;  else next_state <= NS_YELLOW; end if;
                when EW_GREEN  => if timer = 5 then next_state <= EW_YELLOW; else next_state <= EW_GREEN; end if;
                when EW_YELLOW => if timer = 2 then next_state <= NS_GREEN;  else next_state <= EW_YELLOW; end if;
                when ALL_RED   => next_state <= NS_GREEN;
            end case;
        end if;
    end process;

    -- Output logic
    process(state)
    begin
        case state is
            when NS_GREEN  => NS_light <= "001"; EW_light <= "100"; -- NS=Green, EW=Red
            when NS_YELLOW => NS_light <= "010"; EW_light <= "100"; -- NS=Yellow, EW=Red
            when EW_GREEN  => NS_light <= "100"; EW_light <= "001"; -- NS=Red, EW=Green
            when EW_YELLOW => NS_light <= "100"; EW_light <= "010"; -- NS=Red, EW=Yellow
            when ALL_RED   => NS_light <= "100"; EW_light <= "100"; -- Both Red
        end case;
    end process;
end Behavioral;
