library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- (a) 4-bit unsigned down counter, synchronous set to 1111
entity down_cnt_sset is
  port ( clk, sset : in  std_logic;
         q         : out unsigned(3 downto 0) );
end entity;

architecture rtl of down_cnt_sset is
  signal cnt : unsigned(3 downto 0) := (others => '0');
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if sset = '1' then
        cnt <= (others => '1');       
      else
        cnt <= cnt - 1;               
      end if;
    end if;
  end process;
  q <= cnt;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- (b) 4-bit signed up counter, asynchronous reset
entity up_cnt_signed is
  port ( clk, rst : in  std_logic;
         q        : out signed(3 downto 0) );
end entity;

architecture rtl of up_cnt_signed is
  signal cnt : signed(3 downto 0) := (others => '0');
begin
  process (clk, rst)
  begin
    if rst = '1' then
      cnt <= (others => '0');
    elsif rising_edge(clk) then
      cnt <= cnt + 1;                 
    end if;
  end process;
  q <= cnt;
end architecture;
