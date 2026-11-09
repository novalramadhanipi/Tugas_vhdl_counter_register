library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex5_tb is
end entity;

architecture sim of ex5_tb is
  constant T : time := 20 ns;
  signal clk    : std_logic := '0';
  signal clr    : std_logic := '1';
  signal load   : std_logic := '1';
  signal en     : std_logic := '0';
  signal up     : std_logic := '1';
  signal preset : unsigned(3 downto 0) := "1100";
  signal q_pre  : unsigned(3 downto 0);
  signal q_ud   : unsigned(3 downto 0);
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

  uut_a : entity work.counter_preset
    port map (clk => clk, load => load, en => en, preset => preset, q => q_pre);

  uut_b : entity work.updown_cnt_clr
    port map (clk => clk, clr => clr, en => en, up => up, q => q_ud);

  stim : process
  begin
    clr <= '1'; load <= '1'; en <= '0'; up <= '1'; preset <= "1100";
    wait for 12 ns;
    clr <= '0';
    wait for T;

    load <= '0'; en <= '1'; up <= '1';
    wait for 6 * T;                       

    up <= '0';
    wait for 8 * T;

    clr <= '1';
    wait for 3 ns;
    assert q_ud = 0 report "async clear gagal" severity error;
    clr <= '0';

    wait for 3 * T;
    done <= true;
    wait;
  end process;
end architecture;
