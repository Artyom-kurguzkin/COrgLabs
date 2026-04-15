library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FourBitALU_tb is
end entity;

architecture test of FourBitALU_tb is
    signal a, b      : std_logic_vector(3 downto 0);
    signal result    : std_logic_vector(3 downto 0);
    signal c_out     : std_logic;
    signal c0, c1, c2, c3, c4 : std_logic;
    signal opcode    : std_logic_vector(2 downto 0);

    -- Component declaration for the ALU bit slice
    component ALUBitSlice
        port (
            opcode   : in  std_logic_vector(2 downto 0);
            A        : in  std_logic;
            B        : in  std_logic;
            Cin      : in  std_logic;
            A_prev   : in  std_logic;
            Output   : out std_logic;
            Cout     : out std_logic;
            Overflow : out std_logic;
            Zero     : out std_logic
        );
    end component;

begin
    -- Chain the ALU bit slices
    c0 <= '0';
    alu0: ALUBitSlice port map(opcode, a(0), b(0), c0, '0', result(0), c1, open, open);
    alu1: ALUBitSlice port map(opcode, a(1), b(1), c1, a(0), result(1), c2, open, open);
    alu2: ALUBitSlice port map(opcode, a(2), b(2), c2, a(1), result(2), c3, open, open);
    alu3: ALUBitSlice port map(opcode, a(3), b(3), c3, a(2), result(3), c4, open, open);
    c_out <= c4;

    -- Test process
    stim_proc: process
    begin
        -- Test Addition: 3 + 5 = 8
        opcode <= "000"; -- ADD
        a <= "0011"; -- 3
        b <= "0101"; -- 5
        wait for 10 ns;
        assert result = "1000" report "Test failed: 3 + 5 (ADD)" severity error;

        -- Test Subtraction: 7 - 2 = 5
        opcode <= "001"; -- SUB
        a <= "0111"; -- 7
        b <= "0010"; -- 2
        wait for 10 ns;
        assert result = "0101" report "Test failed: 7 - 2 (SUB)" severity error;

        -- Test AND: 6 AND 10 = 2
        opcode <= "010"; -- AND
        a <= "0110"; -- 6
        b <= "1010"; -- 10
        wait for 10 ns;
        assert result = "0010" report "Test failed: 6 AND 10" severity error;

        -- Test OR: 6 OR 10 = 14
        opcode <= "011"; -- OR
        a <= "0110"; -- 6
        b <= "1010"; -- 10
        wait for 10 ns;
        assert result = "1110" report "Test failed: 6 OR 10" severity error;

        -- Test XOR: 9 XOR 5 = 12
        opcode <= "100"; -- XOR
        a <= "1001"; -- 9
        b <= "0101"; -- 5
        wait for 10 ns;
        assert result = "1100" report "Test failed: 9 XOR 5" severity error;

        -- Test NOT: NOT 6 = 9 (only A is used)
        opcode <= "101"; -- NOT
        a <= "0110"; -- 6
        b <= "0000"; -- ignored
        wait for 10 ns;
        assert result = "1001" report "Test failed: NOT 6" severity error;

        wait;
    end process;
end architecture;