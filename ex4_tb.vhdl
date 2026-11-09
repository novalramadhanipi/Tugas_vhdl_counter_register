library ieee;
use ieee.std_logic_1164.all;

entity ex4_tb is
end entity;

architecture sim of ex4_tb is
  constant T : time := 20 ns;
  signal clk  : std_logic := '0';
  signal rst  : std_logic := '1';
  signal load : std_logic := '0';
  signal d    : std_logic_vector(7 downto 0) := (others => '0');
  signal si_a : std_logic := '0';
  signal so_a : std_logic;
  signal dir  : std_logic := '0';
  signal si_b : std_logic := '0';
  signal q_b  : std_logic_vector(7 downto 0);
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

  uut_a : entity work.shift_left_siso
    port map (clk => clk, rst => rst, load => load, si => si_a,
              d => d, so => so_a);

  uut_b : entity work.shift_lr_sipo
    port map (clk => clk, rst => rst, dir => dir, si => si_b, q => q_b);

  stim : process
  begin
    rst <= '1';
    wait for 12 ns;
    rst <= '0';

    -- a: load 10110001, lalu geser kiri 
    load <= '1'; d <= "10110001";
    wait for T;
    load <= '0'; si_a <= '1';   
    wait for 4 * T;
    si_a <= '0';                
    wait for 6 * T;

    -- b: shift kiri lalu kanan 
    dir <= '0'; si_b <= '1';
    wait for 4 * T;
    dir <= '1'; si_b <= '0';
    wait for 2 * T;
    si_b <= '1'; 
    wait for 2 * T;
    assert q_b = "11000000" report "q_b seharusnya 11000000" severity error;

    wait for T;
    done <= true;
    wait;
  end process;
end architecture;
