library ieee;
use ieee.std_logic_1164.all;

entity ex6_tb is
end entity;

architecture sim of ex6_tb is
  constant T : time := 20 ns;
  signal clk    : std_logic := '0';
  signal rst    : std_logic := '1';
  signal q_case : std_logic_vector(2 downto 0);
  signal q_bin  : std_logic_vector(2 downto 0);
  signal done   : boolean := false;

  type gray_arr is array (0 to 7) of std_logic_vector(2 downto 0);
  constant SEQ : gray_arr := ("000", "001", "011", "010", "110", "111", "101", "100");
begin
  clk_gen : process
  begin
    while not done loop
      clk <= '0'; wait for T/2;
      clk <= '1'; wait for T/2;
    end loop;
    wait;
  end process;

  uut_a : entity work.gray_case
    port map (clk => clk, rst => rst, q => q_case);

  uut_b : entity work.gray_bin
    port map (clk => clk, rst => rst, q => q_bin);

  stim : process
  begin
    rst <= '1';
    wait for 12 ns;
    rst <= '0';
    
    for i in 1 to 16 loop
      wait until rising_edge(clk);
      wait for 1 ns;
      assert q_case = SEQ(i mod 8)
        report "gray_case salah pada clock ke-" & integer'image(i)
        severity error;
      assert q_bin = SEQ(i mod 8)
        report "gray_bin salah pada clock ke-" & integer'image(i)
        severity error;
      assert q_case = q_bin
        report "kedua versi berbeda pada clock ke-" & integer'image(i)
        severity error;
    end loop;

    report "Tes Gray counter selesai" severity note;
    done <= true;
    wait;
  end process;
end architecture;
