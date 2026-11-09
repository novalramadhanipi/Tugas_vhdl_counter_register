library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex2_tb is
end entity;

architecture sim of ex2_tb is
  constant T : time := 20 ns;
  signal clk    : std_logic := '0';
  signal rst    : std_logic := '1';
  signal sset   : std_logic := '1';
  signal q_down : unsigned(3 downto 0);
  signal q_sgn  : signed(3 downto 0);
  signal done   : boolean := false;
begin
  clk_gen : process
  begin
    while not done loop
      clk <= '0'; wait for T/2;
      clk <= '1'; wait for T/2;
    end loop;
    wait;
  end process;

  uut_a : entity work.down_cnt_sset
    port map (clk => clk, sset => sset, q => q_down);

  uut_b : entity work.up_cnt_signed
    port map (clk => clk, rst => rst, q => q_sgn);

  stim : process
  begin
    rst <= '1'; sset <= '1';
    wait for 12 ns;
    rst <= '0'; sset <= '0';

    wait for 20 * T;

    rst <= '1'; sset <= '1';
    wait for T;
    rst <= '0'; sset <= '0';

    wait for 5 * T;
    done <= true;
    wait;
  end process;
end architecture;
