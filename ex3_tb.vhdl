library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex3_tb is
end entity;

architecture sim of ex3_tb is
  constant T : time := 20 ns;
  signal clk  : std_logic := '0';
  signal clr  : std_logic := '1';
  signal b    : unsigned(3 downto 0) := to_unsigned(3, 4);
  signal a    : unsigned(3 downto 0);
  signal done : boolean := false;
begin
  clk_gen : process
  begin
    while not done loop
      clk <= '0'; wait for T/2;
      clk <= '1'; wait for T/2;
    end loop;
    wait;
  end process;

  uut : entity work.accumulator
    port map (clk => clk, clr => clr, b => b, a => a);

  stim : process
  begin
    clr <= '1'; b <= to_unsigned(3, 4);
    wait for 12 ns;
    clr <= '0';

    wait for 6 * T;
    assert a = 2 report "setelah 6 clock harus 2 (18 mod 16)" severity error;

    wait for 2 * T;
    assert a = 8 report "setelah 8 clock harus 8" severity error;

    clr <= '1';
    wait for 3 ns;
    assert a = 0 report "async clear gagal" severity error;
    clr <= '0';

    wait for 2 * T;
    done <= true;
    wait;
  end process;
end architecture;
