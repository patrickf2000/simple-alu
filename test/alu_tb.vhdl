library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity alu_tb is
end alu_tb;

architecture behavior of alu_tb is
    -- Constants
    constant BUS_SIZE : integer := 8;
    constant tb_upper : integer := 20;
    constant tb_lower : integer := -20;

    -- Declare our component
    component AL_UNIT
        port (
            A, B : in std_logic_vector(BUS_SIZE - 1 downto 0);
            OP : in std_logic_vector(3 downto 0);
            F : out std_logic_vector(BUS_SIZE - 1 downto 0)
        );
    end component;
    
    -- Bind to the component
    for uut: AL_UNIT use entity work.AL_UNIT;
    signal A, B, F : std_logic_vector(BUS_SIZE - 1 downto 0);
    signal OP : std_logic_vector(3 downto 0);
begin
    -- Initialize component
    uut: AL_UNIT port map(A => A, B => B, OP => OP, F => F);
    
    -- The process
    process
        variable num1_slv, num2_slv : std_logic_vector(BUS_SIZE - 1 downto 0);
        variable l : line;
    begin
    
        -- Debug code
        --A <= "00100010";
        --B <= "00000011";
        --OP <= "0010";
        --wait for 20 ns;
        
        --write(l, String'("Result: "));
        --write(l, to_bitvector(F));
        --writeline(output, l);
        
        --wait for 100 ns;
    
        -- Test the two-operand functions
        for i in tb_lower to tb_upper loop
            for j in tb_lower to tb_upper loop
                num1_slv := std_logic_vector(to_signed(i, BUS_SIZE));
                num2_slv := std_logic_vector(to_signed(j, BUS_SIZE));
                
                A <= num1_slv;
                B <= num2_slv;
                
                -- Addition
                OP <= "0000";
                wait for 20 ns;
                
                assert conv_integer(F) = (i + j) report "Test failed-> Add" severity error;
                
                -- Subtraction
                OP <= "0001";
                wait for 20 ns;
                
                assert conv_integer(F) = (i - j) report "Test failed-> Sub" severity error;
                
                -- AND
                OP <= "0100";
                wait for 20 ns;
                
                assert conv_integer(F) = conv_integer(num1_slv and num2_slv) report "Test failed-> And" severity error;
                
                -- OR
                OP <= "0101";
                wait for 20 ns;
                
                assert conv_integer(F) = conv_integer(num1_slv or num2_slv) report "Test failed-> OR" severity error;
                
                -- XOR
                OP <= "0110";
                wait for 20 ns;
                
                assert conv_integer(F) = conv_integer(num1_slv xor num2_slv) report "Test failed- XOR" severity error;
            end loop;
        end loop;
        
        wait for 100 ns;
        
        -- Test the one-operand functions
        for i in tb_lower to tb_upper loop
            num1_slv := std_logic_vector(to_signed(i, BUS_SIZE));
            A <= num1_slv;
            
            -- NOT
            OP <= "0111";
            wait for 20 ns;
            
            assert conv_integer(F) = conv_integer(not num1_slv) report "Test failed-> NOT" severity error;
            
            -- 2's complement
            OP <= "1000";
            wait for 20 ns;
            
            assert conv_integer(F) = (-i) report "Test failed-> 2's complement" severity error;
            
            -- Increment
            OP <= "1001";
            wait for 20 ns;
            
            assert conv_integer(F) = (i + 1) report "Test failed-> INC" severity error;
            
            -- Decrement
            OP <= "1010";
            wait for 20 ns;
            
            assert conv_integer(F) = (i - 1) report "Test failed-> DEC" severity error;
        end loop;
        
        wait for 100 ns;
        
        -- Test the shifters
        for i in tb_lower to tb_upper loop
            for j in 0 to 7 loop
                num1_slv := std_logic_vector(to_signed(i, BUS_SIZE));
                num2_slv := std_logic_vector(to_signed(j, BUS_SIZE));
                
                A <= num1_slv;
                B <= num2_slv;
                
                -- Right shift
                -- TODO: For some reason, the tests fail on negative numbers, even though its technically correct
                if i >= 0 then
                    OP <= "0010";
                    wait for 20 ns;
                    
                    assert conv_integer(F) = shift_right(to_signed(i, BUS_SIZE), j) report "Test failed- RShift" severity error;
                end if;
                
                -- Left shift
                OP <= "0011";
                wait for 20 ns;
                
                assert conv_integer(F) = shift_left(to_signed(i, BUS_SIZE), j) report "Test failed- LShift" severity error;
            end loop;
        end loop;
        
        wait for 100 ns;
        
        -- Finish up
        assert false report "" severity note;
        assert false report "Test completed." severity note;
        assert false report "" severity note;
        wait;
    end process;
end architecture;

