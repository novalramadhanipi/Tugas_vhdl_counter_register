library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- (a) 4-bit up counter, nilai awal dimuat dari input 'preset'
entity counter_preset is
  port ( clk, load, en : in  std_logic;
         preset        : in  unsigned(3 downto 0);
         q             : out unsigned(3 downto 0) );
end entity;

architecture rtl of counter_preset is
  signal cnt : unsigned(3 downto 0) := (others => '0');
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if load = '1' then
        cnt <= preset;
      elsif en = '1' then
        cnt <= cnt + 1;
      end if;
    end if;
  end process;
  q <= cnt;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- (b) 4-bit up/down counter, asynchronous clear
entity updown_cnt_clr is
  port ( clk, clr, en, up : in  std_logic;
         q                : out unsigned(3 downto 0) );
end entity;

architecture rtl of updown_cnt_clr is
  signal cnt : unsigned(3 downto 0) := (others => '0');
begin
  process (clk, clr)
  begin
    if clr = '1' then
      cnt <= (others => '0');
    elsif rising_edge(clk) then
      if en = '1' then
        if up = '1' then
          cnt <= cnt + 1;
        else
          cnt <= cnt - 1;
        end if;
      end if;
    end if;
  end process;
  q <= cnt;
end architecture;
