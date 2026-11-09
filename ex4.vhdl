library ieee;
use ieee.std_logic_1164.all;

-- (a) 8-bit shift-left SISO, rising edge, parallel load of initial content
entity shift_left_siso is
  port ( clk, rst, load, si : in  std_logic;
         d                  : in  std_logic_vector(7 downto 0);
         so                 : out std_logic );
end entity;

architecture rtl of shift_left_siso is
  signal r : std_logic_vector(7 downto 0) := (others => '0');
begin
  process (clk, rst)
  begin
    if rst = '1' then
      r <= (others => '0');
    elsif rising_edge(clk) then
      if load = '1' then
        r <= d;
      else
        r <= r(6 downto 0) & si;
      end if;
    end if;
  end process;
  so <= r(7);
end architecture;

library ieee;
use ieee.std_logic_1164.all;

-- (b) 8-bit register, shift left or right, serial in, parallel out
entity shift_lr_sipo is
  port ( clk, rst : in  std_logic;
         dir      : in  std_logic;
         si       : in  std_logic;
         q        : out std_logic_vector(7 downto 0) );
end entity;

architecture rtl of shift_lr_sipo is
  signal r : std_logic_vector(7 downto 0) := (others => '0');
begin
  process (clk, rst)
  begin
    if rst = '1' then
      r <= (others => '0');
    elsif rising_edge(clk) then
      if dir = '0' then
        r <= r(6 downto 0) & si;
      else
        r <= si & r(7 downto 1);
      end if;
    end if;
  end process;
  q <= r;
end architecture;
