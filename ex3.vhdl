library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accumulator is
  port ( clk, clr : in  std_logic;
         b        : in  unsigned(3 downto 0);
         a        : out unsigned(3 downto 0) );
end entity;

architecture rtl of accumulator is
  signal acc : unsigned(3 downto 0) := (others => '0');
begin
  process (clk, clr)
  begin
    if clr = '1' then
      acc <= (others => '0');
    elsif rising_edge(clk) then
      acc <= acc + b;
    end if;
  end process;
  a <= acc;
end architecture;
