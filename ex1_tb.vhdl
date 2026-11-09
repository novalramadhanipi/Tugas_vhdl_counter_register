library ieee;
use ieee.std_logic_1164.all;

entity ex1_tb is
end entity;

architecture sim of ex1_tb is
  constant T : time := 20 ns;
  signal clk   : std_logic := '0';
  signal clr   : std_logic := '1';
  signal set   : std_logic := '1';
  signal en    : std_logic := '0';
  signal d     : std_logic_vector(3 downto 0) := "0000";
  signal q_neg : std_logic_vector(3 downto 0);
  signal q_pos : std_logic_vector(3 downto 0);
  signal done  : boolean := false;
begin
  clk_gen : process
  begin
    while not done loop
      clk <= '0'; wait for T/2;
      clk <= '1'; wait for T/2;
    end loop;
    wait;
  end process;

  uut_a : entity work.reg_neg_clr
    port map (clk => clk, clr => clr, d => d, q => q_neg);

  uut_b : entity work.reg_pos_set_en
    port map (clk => clk, set => set, en => en, d => d, q => q_pos);

  stim : process
  begin
    clr <= '1'; set <= '1'; en <= '0'; d <= "0000";
    wait for 12 ns;

    clr <= '0'; set <= '0'; en <= '1'; d <= "1010";
    wait for T;                                  

    en <= '0'; d <= "0101";
    wait for T;                                  
    assert q_neg = "0101" report "q_neg salah (harus 0101)" severity error;
    assert q_pos = "1010" report "q_pos harus hold 1010"    severity error;

    en <= '1'; d <= "0011";
    wait for T;                                  
    assert q_neg = "0011" report "q_neg salah (harus 0011)" severity error;
    assert q_pos = "0011" report "q_pos salah (harus 0011)" severity error;

    clr <= '1';
    wait for 3 ns;
    assert q_neg = "0000" report "async clear gagal" severity error;
    clr <= '0';

    set <= '1';
    wait for 3 ns;
    assert q_pos = "1111" report "async set gagal" severity error;
    set <= '0';

    wait for 2 * T;
    done <= true;
    wait;
  end process;
end architecture;
