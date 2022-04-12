library ieee;
use ieee.std_logic_1164.all;

entity mux is port(
a: in std_logic_vector(15 downto 0);
cikis: out std_logic;
s: in std_logic_vector(4 downto 0)
);
end mux;

architecture calismasi of mux is
begin 
with s select

         cikis <= a(0) when "00000",
                     a(1) when "00001",
                     a(2) when "00010",
                     a(3) when "00011",
                     a(4) when "00100",
                     a(5) when "00101",
                     a(6) when "00110",
                     a(7) when "00111",
                     a(8) when "01000",
                     a(9) when "01001",
                     a(10) when "01010",
                     a(11) when "01011",
                     a(12) when "01100",
                     a(13) when "01101",
                     a(14) when "01110",
                     a(15) when "01111",
                     '0' when others;
end calismasi;