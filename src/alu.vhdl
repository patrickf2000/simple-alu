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
    
    -- The subtractor
    component subtractor
        port (
            A, B : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The left-shifter
    component lshift
        port (
            A, B : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The right-shifter
    component rshift
        port (
            A, B : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The 8-bit AND
    component and8
        port (
            A, B : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The 8-bit OR
    component or8
        port (
            A, B : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The 8-bit XOR
    component xor8
        port (
            A, B : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The 8-bit NOT
    component not8
        port (
            A : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The negate (2's complement) unit
    component negate
        port (
            A : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The signals
    signal add_out : std_logic_vector(7 downto 0);
    signal subtract_out : std_logic_vector(7 downto 0);
    signal lshift_out : std_logic_vector(7 downto 0);
    signal rshift_out : std_logic_vector(7 downto 0);
    signal and_out : std_logic_vector(7 downto 0);
    signal or_out : std_logic_vector(7 downto 0);
    signal xor_out : std_logic_vector(7 downto 0);
    signal not_out : std_logic_vector(7 downto 0);
    signal negate_out : std_logic_vector(7 downto 0);
    signal inc_out : std_logic_vector(7 downto 0);
    signal dec_out : std_logic_vector(7 downto 0);
    
    -- Constants
    constant one : std_logic_vector(7 downto 0) := "00000001";
begin
    add : adder port map(vec1 => A, vec2 => B, out_vec => add_out, co => open);
    sub : subtractor port map(A => A, B => B, F => subtract_out);
    lsh : lshift port map(A => A, B => B, F => lshift_out);
    rsh : rshift port map(A => A, B => B, F => rshift_out);
    and8_0 : and8 port map(A => A, B => B, F => and_out);
    or8_0 : or8 port map(A => A, B => B, F => or_out);
    xor8_0 : xor8 port map(A => A, B => B, F => xor_out);
    not8_0 : not8 port map(A => A, F => not_out);
    neg : negate port map(A => A, F => negate_out);
    inc : adder port map(vec1 => A, vec2 => one, out_vec => inc_out, co => open);
    dec : subtractor port map(A => A, B => one, F => dec_out);
    
    process (add_out, subtract_out,
        lshift_out, rshift_out,
        and_out, or_out, xor_out, not_out, 
        negate_out,
        inc_out, dec_out,
        OP) is
    begin
        case OP is
            when "0000" => F <= add_out;        -- Add
            when "0001" => F <= subtract_out;   -- Subtract
            when "0010" => F <= rshift_out;     -- Right-shift
            when "0011" => F <= lshift_out;     -- Left-shift
            when "0100" => F <= and_out;        -- And
            when "0101" => F <= or_out;         -- Or
            when "0110" => F <= xor_out;        -- Xor
            when "0111" => F <= not_out;        -- Not
            when "1000" => F <= negate_out;     -- 2's complement
            when "1001" => F <= inc_out;        -- Increment
            when "1010" => F <= dec_out;        -- Decrement
            when others => F <= (others => 'X');
        end case;
    end process;
end behavioral;

