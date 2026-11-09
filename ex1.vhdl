library ieee;
use ieee.std_logic_1164.all;

-- (a) 4-bit register, falling-edge clock, asynchronous clear
entity reg_neg_clr is
  port ( clk, clr : in  std_logic;
         d        : in  std_logic_vector(3 downto 0);
         q        : out std_logic_vector(3 downto 0) );
end entity;

architecture rtl of reg_neg_clr is
begin
  process (clk, clr)
  begin
    if clr = '1' then
      q <= (others => '0');
    elsif falling_edge(clk) then
      q <= d;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

-- (b) 4-bit register, rising-edge clock, asynchronous set, clock enable
entity reg_pos_set_en is
  port ( clk, set, en : in  std_logic;
         d            : in  std_logic_vector(3 downto 0);
         q            : out std_logic_vector(3 downto 0) );
end entity;

architecture rtl of reg_pos_set_en is
begin
  process (clk, set)
  begin
    if set = '1' then
      q <= (others => '1');
    elsif rising_edge(clk) then
      if en = '1' then
        q <= d;
      end if;                
    end if;
  end process;
end architecture;
