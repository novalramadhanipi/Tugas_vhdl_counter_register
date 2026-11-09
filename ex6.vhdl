library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- (a) Gray counter dengan statement case
entity gray_case is
  port ( clk, rst : in  std_logic;
         q        : out std_logic_vector(2 downto 0) );
end entity;

architecture rtl of gray_case is
  signal g : std_logic_vector(2 downto 0) := "000";
begin
  process (clk, rst)
  begin
    if rst = '1' then
      g <= "000";
    elsif rising_edge(clk) then
      case g is
        when "000"  => g <= "001";        
        when "001"  => g <= "011";        
        when "011"  => g <= "010";        
        when "010"  => g <= "110";        
        when "110"  => g <= "111";        
        when "111"  => g <= "101";        
        when "101"  => g <= "100";        
        when others => g <= "000";        
      end case;
    end if;
  end process;
  q <= g;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- (b) Binary counter + konversi g = b xor (b srl 1)
entity gray_bin is
  port ( clk, rst : in  std_logic;
         q        : out std_logic_vector(2 downto 0) );
end entity;

architecture rtl of gray_bin is
  signal bin : unsigned(2 downto 0) := (others => '0');
begin
  process (clk, rst)
  begin
    if rst = '1' then
      bin <= (others => '0');
    elsif rising_edge(clk) then
      bin <= bin + 1;                     
    end if;
  end process;

  q <= std_logic_vector(bin xor (bin srl 1));
end architecture;
