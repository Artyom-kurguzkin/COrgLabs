library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Required for arithmetic

entity ALUBitSlice is
    Port ( 
           opcode      : in  STD_LOGIC_VECTOR(2 downto 0); 
           A           : in  STD_LOGIC_VECTOR(3 downto 0);
           B           : in  STD_LOGIC_VECTOR(3 downto 0);
           Cin         : in  STD_LOGIC; -- carry in

           Output      : out STD_LOGIC_VECTOR(3 downto 0);
           Cout        : out STD_LOGIC; -- carry out
    );
end ALUBitSlice;

architecture Behavioral of ALUBitSlice is
begin
    process(opcode, A, B, Cin)
        variable res       : std_logic_vector(3 downto 0);
        variable c_out_var : std_logic_vector(3 downto 0);
    begin
        c_out_var := (others => '0');

        case opcode is
            when "000" => -- A + B (Addition)
                res := std_logic_vector( 
                    unsigned(A) + unsigned(B) + unsigned(Cin & "000")
                );
                -- Only the MSB carry-out is meaningful for 4-bit add
                c_out_var(3) := (
                    (unsigned(A) + unsigned(B) + unsigned(Cin & "000")) > 15
                ) ? '1' : '0';

            when "001" => -- A - B (Subtraction)
                res := std_logic_vector( 
                    unsigned(A) - unsigned(B) - unsigned(Cin & "000")
                );
                c_out_var(3) := (
                    (unsigned(A) - unsigned(B) - unsigned(Cin & "000")) < 0
                ) ? '1' : '0';

            when "010" => -- A AND B
                res := A and B;

            when "011" => -- A OR B
                res := A or B;

            when "100" => -- A XOR B
                res := A xor B;

            when "101" => -- NOT A
                res := not A;

            when "110" => -- A LBS (Left Bit Shift)
                res := A(2 downto 0) & '0';

            when "111" => -- A++ (Increment)
                res := std_logic_vector(unsigned(A) + 1);

            when others =>
                res := (others => '0');
        end case;

        Output   <= res;
        Cout     <= c_out_var(3);

    end process;
end Behavioral;