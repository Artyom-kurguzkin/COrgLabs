case Opcode is
    when "000" => -- A + B (Addition)
        resultWithCarry := unsigned ( '0' & InputA ) + unsigned ( InputB ) + unsigned ( CarryIn );
        Output          <= std_logic_vector ( resultWithCarry ( 3 downto 0 ) );
        CarryOut        <= resultWithCarry ( 4 );

    when "001" => -- A - B (Subtraction)
        resultWithCarry := unsigned ( '0' & InputA ) - unsigned ( InputB ) - unsigned ( CarryIn );
        Output          <= std_logic_vector ( resultWithCarry ( 3 downto 0 ) );
        CarryOut        <= resultWithCarry ( 4 );

    when "010" => -- A AND B
        Output <= InputA and InputB;

    when "011" => -- A OR B
        Output <= InputA or InputB;

    when "100" => -- A XOR B
        Output <= InputA xor InputB;

    when "101" => -- NOT A
        Output <= not InputA;

    when "110" => -- A LBS (Left Bit Shift)
        Output   <= InputA ( 2 downto 0 ) & '0';
        CarryOut <= InputA ( 3 );

    when "111" => -- A++ (Increment)
        resultWithCarry := unsigned ( '0' & InputA ) + 1;
        Output          <= std_logic_vector ( resultWithCarry ( 3 downto 0 ) );
        CarryOut        <= resultWithCarry ( 4 );

    when others =>
        Output <= ( others => '0' );
end case;