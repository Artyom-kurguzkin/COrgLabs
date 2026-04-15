case opcode is
    when "000" => -- A + B (Addition)
        res := std_logic_vector( 
            unsigned ( A ) + unsigned ( B ) + unsigned ( Cin & "000" )
        );
        -- Only the MSB carry-out is meaningful for 4-bit add
        c_out_var ( 3 ) := (
            ( unsigned ( A ) + unsigned ( B ) + unsigned ( Cin & "000" ) ) > 15
        ) ? '1' : '0';

    when "001" => -- A - B (Subtraction)
        res := std_logic_vector( 
            unsigned ( A ) - unsigned ( B ) - unsigned ( Cin & "000" )
        );
        c_out_var ( 3 ) := (
            ( unsigned ( A ) - unsigned ( B ) - unsigned ( Cin & "000" ) ) < 0
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
        res := A ( 2 downto 0 ) & '0';

    when "111" => -- A++ (Increment)
        res := std_logic_vector ( unsigned ( A ) + 1 );

    when others =>
        res := ( others => '0' );
end case;