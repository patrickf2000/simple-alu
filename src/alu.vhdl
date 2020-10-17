-- How this works:
-- The process is used whenever a particular signal changes.
--
-- A signal could change when a new result is computed, and/or the ALU
-- opcode changes.
--
-- The circuit basically works with all the inputs connected to each math unit
-- When the multiplexer matches an opcode, that channel is opened, and the result
-- from whatever math unit is moved into the output line.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity al_unit is
    port (
        A, B : in std_logic_vector(7 downto 0);
        OP : in std_logic_vector(2 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end al_unit;

architecture behavioral of al_unit is
    component adder
    port (
        vec1, vec2 : in std_logic_vector(7 downto 0);
        out_vec : out std_logic_vector(7 downto 0);
        co : out std_logic
    );
    end component;
    
    signal add_out : std_logic_vector(7 downto 0);
begin
    add : adder port map(vec1 => A, vec2 => B, out_vec => add_out, co => open);
    
    process (add_out, OP) is
    begin
        case OP is
            when "000" => F <= add_out;
            when "001" => F <= A - B;
            when others => F <= (others => 'X');
        end case;
    end process;
end behavioral;
