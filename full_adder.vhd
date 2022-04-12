library ieee;
use ieee.std_logic_1164.all;
 
entity full_adder is
 Port (
     A : in std_logic;
     B : in std_logic;
     Cin : in std_logic;
     toplam : out std_logic;
     elde : out std_logic);
     end full_adder;
architecture calismasi of full_adder is
 
begin
 
     toplam <= A xor B xor Cin ;
     elde <= (A and B) or (Cin and A) or (Cin and B) ;
 
end calismasi;