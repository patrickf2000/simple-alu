-- Take the 2's complement of a number
library ieee;
use ieee.std_logic_1164.all;

entity Negate is
    port (
        A : in std_logic_vector(7 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end Negate;

architecture behavior of Negate is
    -- The adder- we need this
    component adder
        port (
            vec1, vec2 : in std_logic_vector(7 downto 0);
            out_vec : out std_logic_vector(7 downto 0);
            co : out std_logic
        );
    end component;
    
    -- The NOT component
    component not8
        port (
            A : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The signals
    signal invert_path : std_logic_vector(7 downto 0);
    signal output_path : std_logic_vector(7 downto 0);
    constant one : std_logic_vector(7 downto 0) := "00000001";
begin
    not8_0 : not8 port map(A => A, F => invert_path);
    add : adder port map(vec1 => invert_path, vec2 => one, out_vec => output_path, co => open);
    F <= output_path;
end behavior;

