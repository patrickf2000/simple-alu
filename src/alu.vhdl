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
        OP : in std_logic_vector(3 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end al_unit;

architecture behavioral of al_unit is
    -- The adder
    component adder
        port (
            vec1, vec2 : in std_logic_vector(7 downto 0);
            out_vec : out std_logic_vector(7 downto 0);
            co : out std_logic
        );
    end component;
    
    -- The 8-bit AND
    component and8
        port (
            A, B : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The signals
    signal add_out : std_logic_vector(7 downto 0);
    signal and_out : std_logic_vector(7 downto 0);
begin
    add : adder port map(vec1 => A, vec2 => B, out_vec => add_out, co => open);
    and8_0 : and8 port map(A => A, B => B, F => and_out);
    
    process (add_out, and_out, OP) is
    begin
        case OP is
            when "0000" => F <= add_out;        -- Add
            when "0001" => F <= A - B;          -- Subtract
            when "0010" => F <= A - B;          -- Left-shift
            when "0011" => F <= A - B;          -- Right-shift
            when "0100" => F <= and_out;        -- And
            when "0101" => F <= A - B;          -- Or
            when "0110" => F <= A - B;          -- Xor
            when "0111" => F <= A - B;          -- Not
            when "1000" => F <= A - B;          -- 2's complement
            when "1001" => F <= A - B;          -- Increment
            when "1010" => F <= A - B;          -- Decrement
            when others => F <= (others => 'X');
        end case;
    end process;
end behavioral;
