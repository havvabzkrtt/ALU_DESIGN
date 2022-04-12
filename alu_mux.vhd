library ieee;
use ieee.std_logic_1164.all;

entity alu_mux is 
port (
    a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21: in std_logic_vector(15 downto 0);
    sonuc : out std_logic_vector(15 downto 0);
    ss : in std_logic_vector(4 downto 0)
);
end alu_mux;

architecture calismasi of alu_mux is 
begin 
    with ss select
            sonuc <= a1 when "00000",
                   a2 when "00001", 
                    a3 when "00010",
                    a4 when "00011",
                    a5 when "00100",
                    a6 when "00101",
                    a7 when "00110",
                    a8 when "00111",
                    a9 when "01000",
                    a10 when "01001",
                    a11 when "01010",
                    a12 when "01011",
                    a13 when "01100",
                    a14 when "01101",
                    a15 when "01110",
                    a16 when "01111",
                    a17 when "10000",
                    a18 when "10001",
                    a19 when "10010",
                    a20 when "10011",
                    a21 when "10100",
                    "0000000000000000" when others;
end calismasi;