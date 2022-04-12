library ieee;
use ieee.std_logic_1164.all;
 
entity alu is 
port (
	dr: in std_logic_vector(15 downto 0);
	ac: in std_logic_vector(15 downto 0);
	input: in std_logic_vector(15 downto 0);
	cin: in std_logic;
	S : in std_logic_vector(4 downto 0);
	alu_cikis : out std_logic_vector(15 downto 0);
	eldee: out std_logic );
	
end alu;

architecture calismasi of alu is

-- ARA SİNYALLER
signal cin_sec : std_logic;
signal ac_sec, dr_sec : std_logic_vector(15 downto 0);
signal cin_ekle : std_logic_vector(14 downto 0);
signal toplam_sonuc, xor_sonuc, or_sonuc, and_sonuc, ror_ac, rol_ac, shr_ac, shl_ac:  std_logic_vector(15 downto 0);


-- Aritmetik İşlemler İçin Mux Component
component mux port(
	a: in std_logic_vector(15 downto 0);
	cikis: out std_logic;
	s: in std_logic_vector(4 downto 0)
	);
end component;

-- Alu Çıkışı İçin Mux Component
component alu_mux port(
	a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21: in std_logic_vector(15 downto 0);
    sonuc : out std_logic_vector(15 downto 0);
    ss : in std_logic_vector(4 downto 0)
	);
end component;

-- Full Adder Component 
component full_adder port(
	 A : in std_logic;
	 B : in std_logic;
	 Cin : in std_logic;
	 toplam : out std_logic;
	 elde : out std_logic);
end component;

begin 


-- ALU İŞLEMLERİ -- 

-- S: 00000 => ac + dr = ac + dr + 0 
-- S: 00001 => ac + dr + c = ac + dr + cin
-- S: 00010 => ac - dr = ac + not(dr) +1 
-- S: 00011 => ac + not(dr) = ac + not(dr) + 0
-- S: 00100 => dr = 0 + dr + 0
-- S: 00101 => ac + 1 = ac + 0 + 1
-- S: 00110 => ac = ac + 0 + 0
-- S: 00111 => input = input + 0 + 0
-- S: 01000 => dr + 1 = 0 + dr + 1
-- S: 01001 => dr - 1 = not(1) + dr + 1
-- S: 01010 => input + 1 = input + 0 + 1
-- S: 01011 => ac - 1 = ac + not(1) + 1
-- S: 01100 => ac xor dr
-- S: 01101 => ac or dr 
-- S: 01110 => ac and dr
-- S: 01111 => not dr
-- S: 10000 => not ac
-- S: 10001 => ac yi döngüsel sağa kaydırma
-- S: 10010 => ac yi döngüsel sola kaydırma
-- S: 10011 => ac yi sağa kaydırma
-- S: 10100 => ac yi sola kaydırma



-- ARİTMETİK İŞLEMLER İÇİN AC MUX LARI

muxAc1: mux port map(
	a(0) => ac(0),
	a(1) => ac(0),
	a(2) => ac(0),
	a(3) => ac(0),
	a(4) => '0',
	a(5) => ac(0),
	a(6) => ac(0),
	a(7) => input(0),
	a(8) => '0',
	a(9) => '0',
	a(10) => input(0),
	a(11) => ac(0),
	s => S,
	cikis => ac_sec(0)
);


muxAc2: mux port map(
	a(0) => ac(1),
	a(1) => ac(1),
	a(2) => ac(1),
	a(3) => ac(1),
	a(4) => '0',
	a(5) => ac(1),
	a(6) => ac(1),
	a(7) => input(1),
	a(8) => '0',
	a(9) => '0',
	a(10) => input(1),
	a(11) => ac(1),
	s => S,
	cikis => ac_sec(1)
);
muxAc3: mux port map(
	a(0) => ac(2),
	a(1) => ac(2),
	a(2) => ac(2),
	a(3) => ac(2),
	a(4) => '0',
	a(5) => ac(2),
	a(6) => ac(2),
	a(7) => input(2),
	a(8) => '0',
	a(9) => '0',
	a(10) => input(2),
	a(11) => ac(2),
	s => S,
	cikis => ac_sec(2)
);

muxAc4: mux port map(
	a(0) => ac(3),
	a(1) => ac(3),
	a(2) => ac(3),
	a(3) => ac(3),
	a(4) => '0',
	a(5) => ac(3),
	a(6) => ac(3),
	a(7) => input(3),
	a(8) => '0',
	a(9) => '0',
	a(10) => input(3),
	a(11) => ac(3),
	s => S,
	cikis => ac_sec(3)
);

muxAc5: mux port map(
	a(0) => ac(4),
	a(1) => ac(4),
	a(2) => ac(4),
	a(3) => ac(4),
	a(4) => '0',
	a(5) => ac(4),
	a(6) => ac(4),
	a(7) => input(4),
	a(8) => '0',
	a(9) => '0',
	a(10) => input(4),
	a(11) => ac(4),
	s => S,
	cikis => ac_sec(4)
);

muxAc6: mux port map(
	a(0) => ac(5),
	a(1) => ac(5),
	a(2) => ac(5),
	a(3) => ac(5),
	a(4) => '0',
	a(5) => ac(5),
	a(6) => ac(5),
	a(7) => input(5),
	a(8) => '0',
	a(9) => '0',
	a(10) => input(5),
	a(11) => ac(5),
	s => S,
	cikis => ac_sec(5)
);

muxAc7: mux port map(
	a(0) => ac(6),
	a(1) => ac(6),
	a(2) => ac(6),
	a(3) => ac(6),
	a(4) => '0',
	a(5) => ac(6),
	a(6) => ac(6),
	a(7) => input(6),
	a(8) => '0',
	a(9) => '0',
	a(10) => input(6),
	a(11) => ac(6),
	s => S,
	cikis => ac_sec(6)
);

muxAc8: mux port map(
    a(0) => ac(7),
    a(1) => ac(7),
    a(2) => ac(7),
    a(3) => ac(7),
    a(4) => '0',
    a(5) => ac(7),
    a(6) => ac(7),
    a(7) => input(7),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(7),
    a(11) => ac(7),
    s => S,
    cikis => ac_sec(7)
);


muxAc9: mux port map(
    a(0) => ac(8),
    a(1) => ac(8),
    a(2) => ac(8),
    a(3) => ac(8),
    a(4) => '0',
    a(5) => ac(8),
    a(6) => ac(8),
    a(7) => input(8),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(8),
    a(11) => ac(8),
    s => S,
    cikis => ac_sec(8)
);

muxAc10: mux port map(
    a(0) => ac(9),
    a(1) => ac(9),
    a(2) => ac(9),
    a(3) => ac(9),
    a(4) => '0',
    a(5) => ac(9),
    a(6) => ac(9),
    a(7) => input(9),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(9),
    a(11) => ac(9),
    s => S,
    cikis => ac_sec(9)
);

muxAc11: mux port map(
    a(0) => ac(10),
    a(1) => ac(10),
    a(2) => ac(10),
    a(3) => ac(10),
    a(4) => '0',
    a(5) => ac(10),
    a(6) => ac(10),
    a(7) => input(10),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(10),
    a(11) => ac(10),
    s => S,
    cikis => ac_sec(10)
);

muxAc12: mux port map(
    a(0) => ac(11),
    a(1) => ac(11),
    a(2) => ac(11),
    a(3) => ac(11),
    a(4) => '0',
    a(5) => ac(11),
    a(6) => ac(11),
    a(7) => input(11),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(11),
    a(11) => ac(11),
    s => S,
    cikis => ac_sec(11)
);

muxAc13: mux port map(
    a(0) => ac(12),
    a(1) => ac(12),
    a(2) => ac(12),
    a(3) => ac(12),
    a(4) => '0',
    a(5) => ac(12),
    a(6) => ac(12),
    a(7) => input(12),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(12),
    a(11) => ac(12),
    s => S,
    cikis => ac_sec(12)
);

muxAc14: mux port map(
    a(0) => ac(13),
    a(1) => ac(13),
    a(2) => ac(13),
    a(3) => ac(13),
    a(4) => '0',
    a(5) => ac(13),
    a(6) => ac(13),
    a(7) => input(13),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(13),
    a(11) => ac(13),
    s => S,
    cikis => ac_sec(13)
);

muxAc15: mux port map(
    a(0) => ac(14),
    a(1) => ac(14),
    a(2) => ac(14),
    a(3) => ac(14),
    a(4) => '0',
    a(5) => ac(14),
    a(6) => ac(14),
    a(7) => input(14),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(14),
    a(11) => ac(14),
    s => S,
    cikis => ac_sec(14)
);

muxAc16: mux port map(
    a(0) => ac(15),
    a(1) => ac(15),
    a(2) => ac(15),
    a(3) => ac(15),
    a(4) => '0',
    a(5) => ac(15),
    a(6) => ac(15),
    a(7) => input(15),
    a(8) => '0',
    a(9) => '0',
    a(10) => input(15),
    a(11) => ac(15),
    s => S,
    cikis => ac_sec(15)
);


-- ARİTMETİK İŞLEMLER İÇİN DR MUX LARI

muxDr1: mux port map(
	a(0)=> dr(0),
	a(1)=> dr(0),
	a(2)=> not(dr(0)),
	a(3)=> not(dr(0)),
	a(4)=> dr(0),
	a(5)=>'0',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> dr(0),
	a(9)=> dr(0),
	a(10)=>'0',
	a(11)=>'0',
	s => S,
	cikis => dr_sec(0)
);

muxDr2: mux port map(
	a(0)=> dr(1),
	a(1)=> dr(1),
	a(2)=> not(dr(1)),
	a(3)=> not(dr(1)),
	a(4)=> dr(1),
	a(5)=>'0',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> dr(1),
	a(9)=> dr(1),
	a(10)=>'0',
	a(11)=>'0',
	s => S,
	cikis => dr_sec(1)
);

muxDr3: mux port map(
	a(0)=> dr(2),
	a(1)=> dr(2),
	a(2)=> not(dr(2)),
	a(3)=> not(dr(2)),
	a(4)=> dr(2),
	a(5)=>'0',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> dr(2),
	a(9)=> dr(2),
	a(10)=>'0',
	a(11)=>'0',
	s => S,
	cikis => dr_sec(2)
);

muxDr4: mux port map(
	a(0)=> dr(3),
	a(1)=> dr(3),
	a(2)=> not(dr(3)),
	a(3)=> not(dr(3)),
	a(4)=> dr(3),
	a(5)=>'0',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> dr(3),
	a(9)=> dr(3),
	a(10)=>'0',
	a(11)=>'0',
	s => S,
	cikis => dr_sec(3)
);

muxDr5: mux port map(
	a(0)=> dr(4),
	a(1)=> dr(4),
	a(2)=> not(dr(4)),
	a(3)=> not(dr(4)),
	a(4)=> dr(4),
	a(5)=>'0',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> dr(4),
	a(9)=> dr(4),
	a(10)=>'0',
	a(11)=>'0',
	s => S,
	cikis => dr_sec(4)
);

muxDr6: mux port map(
	a(0)=> dr(5),
	a(1)=> dr(5),
	a(2)=> not(dr(5)),
	a(3)=> not(dr(5)),
	a(4)=> dr(5),
	a(5)=>'0',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> dr(5),
	a(9)=> dr(5),
	a(10)=>'0',
	a(11)=>'0',
	s => S,
	cikis => dr_sec(5)
);

muxDr7: mux port map(
	a(0)=> dr(6),
	a(1)=> dr(6),
	a(2)=> not(dr(6)),
	a(3)=> not(dr(6)),
	a(4)=> dr(6),
	a(5)=>'0',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> dr(6),
	a(9)=> dr(6),
	a(10)=>'0',
	a(11)=>'0',
	s => S,
	cikis => dr_sec(6)
);

muxDr8: mux port map(
	a(0)=> dr(7),
	a(1)=> dr(7),
	a(2)=> not(dr(7)),
	a(3)=> not(dr(7)),
	a(4)=> dr(7),
	a(5)=>'0',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> dr(7),
	a(9)=> dr(7),
	a(10)=>'0',
	a(11)=>'0',
	s => S,
	cikis => dr_sec(7)
);

muxDr9: mux port map(
    a(0)=> dr(8),
    a(1)=> dr(8),
    a(2)=> not(dr(8)),
    a(3)=> not(dr(8)),
    a(4)=> dr(8),
    a(5)=>'0',
    a(6)=>'0',
    a(7)=>'0',
    a(8)=> dr(8),
    a(9)=> dr(8),
    a(10)=>'0',
    a(11)=>'0',
    s => S,
    cikis => dr_sec(8)
);


muxDr10: mux port map(
    a(0)=> dr(9),
    a(1)=> dr(9),
    a(2)=> not(dr(9)),
    a(3)=> not(dr(9)),
    a(4)=> dr(9),
    a(5)=>'0',
    a(6)=>'0',
    a(7)=>'0',
    a(8)=> dr(9),
    a(9)=> dr(9),
    a(10)=>'0',
    a(11)=>'0',
    s => S,
    cikis => dr_sec(9)
);



muxDr11: mux port map(
    a(0)=> dr(10),
    a(1)=> dr(10),
    a(2)=> not(dr(10)),
    a(3)=> not(dr(10)),
    a(4)=> dr(10),
    a(5)=>'0',
    a(6)=>'0',
    a(7)=>'0',
    a(8)=> dr(10),
    a(9)=> dr(10),
    a(10)=>'0',
    a(11)=>'0',
    s => S,
    cikis => dr_sec(10)
);



muxDr12: mux port map(
    a(0)=> dr(11),
    a(1)=> dr(11),
    a(2)=> not(dr(11)),
    a(3)=> not(dr(11)),
    a(4)=> dr(11),
    a(5)=>'0',
    a(6)=>'0',
    a(7)=>'0',
    a(8)=> dr(11),
    a(9)=> dr(11),
    a(10)=>'0',
    a(11)=>'0',
    s => S,
    cikis => dr_sec(11)
);



muxDr13: mux port map(
    a(0)=> dr(12),
    a(1)=> dr(12),
    a(2)=> not(dr(12)),
    a(3)=> not(dr(12)),
    a(4)=> dr(12),
    a(5)=>'0',
    a(6)=>'0',
    a(7)=>'0',
    a(8)=> dr(12),
    a(9)=> dr(12),
    a(10)=>'0',
    a(11)=>'0',
    s => S,
    cikis => dr_sec(12)
);



muxDr14: mux port map(
    a(0)=> dr(13),
    a(1)=> dr(13),
    a(2)=> not(dr(13)),
    a(3)=> not(dr(13)),
    a(4)=> dr(13),
    a(5)=>'0',
    a(6)=>'0',
    a(7)=>'0',
    a(8)=> dr(13),
    a(9)=> dr(13),
    a(10)=>'0',
    a(11)=>'0',
    s => S,
    cikis => dr_sec(13)
);



muxDr15: mux port map(
    a(0)=> dr(14),
    a(1)=> dr(14),
    a(2)=> not(dr(14)),
    a(3)=> not(dr(14)),
    a(4)=> dr(14),
    a(5)=>'0',
    a(6)=>'0',
    a(7)=>'0',
    a(8)=> dr(14),
    a(9)=> dr(14),
    a(10)=>'0',
    a(11)=>'0',
    s => S,
    cikis => dr_sec(14)
);



muxDr16: mux port map(
    a(0)=> dr(15),
    a(1)=> dr(15),
    a(2)=> not(dr(15)),
    a(3)=> not(dr(15)),
    a(4)=> dr(15),
    a(5)=>'0',
    a(6)=>'0',
    a(7)=>'0',
    a(8)=> dr(15),
    a(9)=> dr(15),
    a(10)=>'0',
    a(11)=>'0',
    s => S,
    cikis => dr_sec(15)
);


-- ARİTMETİK İŞLEMLER İÇİN CİN MUX U 

muxCin: mux port map(
	a(0)=> '0',
	a(1)=> cin,
	a(2)=> '1',
	a(3)=> '0',
	a(4)=> '0',
	a(5)=>'1',
	a(6)=>'0',
	a(7)=>'0',
	a(8)=> '1',
	a(9)=> '1',
	a(10)=> '1',
	a(11)=> '1',
	s => S,
	cikis => cin_sec
);


-- ARİTMETİK İŞLEMLER İÇİN FULL ADDER MUX LARI

muxFullAdder1: full_adder port map(
	A => ac_sec(0),
	B => dr_sec(0),
	Cin => cin_sec,
	toplam => toplam_sonuc(0),
	elde => cin_ekle(0)
);

muxFullAdder2: full_adder port map(
	A => ac_sec(1),
	B => dr_sec(1),
	Cin => cin_ekle(0),
	toplam => toplam_sonuc(1),
	elde => cin_ekle(1)
);

muxFullAdder3: full_adder port map(
	A => ac_sec(2),
	B => dr_sec(2),
	Cin => cin_ekle(1),
	toplam => toplam_sonuc(2),
	elde => cin_ekle(2)
);

muxFullAdder4: full_adder port map(
	A => ac_sec(3),
	B => dr_sec(3),
	Cin => cin_ekle(2),
	toplam => toplam_sonuc(3),
	elde => cin_ekle(3)
);

muxFullAdder5: full_adder port map(
	A => ac_sec(4),
	B => dr_sec(4),
	Cin => cin_ekle(3),
	toplam => toplam_sonuc(4),
	elde => cin_ekle(4)
);

muxFullAdder6: full_adder port map(
	A => ac_sec(5),
	B => dr_sec(5),
	Cin => cin_ekle(4),
	toplam => toplam_sonuc(5),
	elde => cin_ekle(5)
);

muxFullAdder7: full_adder port map(
	A => ac_sec(6),
	B => dr_sec(6),
	Cin => cin_ekle(5),
	toplam => toplam_sonuc(6),
	elde => cin_ekle(6)
);
muxFullAdder8: full_adder port map(
	A => ac_sec(7),
	B => dr_sec(7),
	Cin => cin_ekle(6),
	toplam => toplam_sonuc(7),
	elde => cin_ekle(7)
);

muxFullAdder9: full_adder port map(
	A => ac_sec(8),
	B => dr_sec(8),
	Cin => cin_ekle(7),
	toplam => toplam_sonuc(8),
	elde => cin_ekle(8)
);

muxFullAdder10: full_adder port map(
	A => ac_sec(9),
	B => dr_sec(9),
	Cin => cin_ekle(8),
	toplam => toplam_sonuc(9),
	elde => cin_ekle(9)
);

muxFullAdder11: full_adder port map(
	A => ac_sec(10),
	B => dr_sec(10),
	Cin => cin_ekle(9),
	toplam => toplam_sonuc(10),
	elde => cin_ekle(10)
);

muxFullAdder12: full_adder port map(
	A => ac_sec(11),
	B => dr_sec(11),
	Cin => cin_ekle(10),
	toplam => toplam_sonuc(11),
	elde => cin_ekle(11)
);

muxFullAdder13: full_adder port map(
	A => ac_sec(12),
	B => dr_sec(12),
	Cin => cin_ekle(11),
	toplam => toplam_sonuc(12),
	elde => cin_ekle(12)
);

muxFullAdder14: full_adder port map(
	A => ac_sec(13),
	B => dr_sec(13),
	Cin => cin_ekle(12),
	toplam => toplam_sonuc(13),
	elde => cin_ekle(13)
);

muxFullAdder15: full_adder port map(
	A => ac_sec(14),
	B => dr_sec(14),
	Cin => cin_ekle(13),
	toplam => toplam_sonuc(14),
	elde => cin_ekle(14)
);

muxFullAdder16: full_adder port map(
	A => ac_sec(15),
	B => dr_sec(15),
	Cin => cin_ekle(14),
	toplam => toplam_sonuc(15),
	elde => eldee
);



-- LOJİK İŞLEMLER

	-- XOR , AND , OR İŞLEMLERİ
	xor_sonuc <= ac xor dr;
	or_sonuc <= ac or dr;
	and_sonuc <= ac and dr;

	
	-- DÖNGÜSEL SAĞA KAYDIRMA
	ror_ac(0) <= ac(1);
	ror_ac(1) <= ac(2);
	ror_ac(2) <= ac(3);
	ror_ac(3) <= ac(4);
	ror_ac(4) <= ac(5);
	ror_ac(5) <= ac(6);
	ror_ac(6) <= ac(7);
	ror_ac(7) <= ac(8);
	ror_ac(8) <= ac(9);
	ror_ac(9) <= ac(10);
	ror_ac(10) <= ac(11);
	ror_ac(11) <= ac(12);
	ror_ac(12) <= ac(13);
	ror_ac(13) <= ac(14);
	ror_ac(14) <= ac(15);
	ror_ac(15) <= ac(0);
	
	-- DÖNGÜSEL SOLA KAYDIRMA
	rol_ac(1) <= ac(0);
	rol_ac(2) <= ac(1);
	rol_ac(3) <= ac(2);
	rol_ac(4) <= ac(3);
	rol_ac(5) <= ac(4);
	rol_ac(6) <= ac(5);
	rol_ac(7) <= ac(6);
	rol_ac(8) <= ac(7);
	rol_ac(9) <= ac(8);
	rol_ac(10) <= ac(9);
	rol_ac(11) <= ac(10);
	rol_ac(12) <= ac(11);
	rol_ac(13) <= ac(12);
	rol_ac(14) <= ac(13);
	rol_ac(15) <= ac(14);
	rol_ac(0) <= ac(15);
	
	
	-- SAĞA KAYDIRMA
	shr_ac(0) <= ac(1);
	shr_ac(1) <= ac(2);
	shr_ac(2) <= ac(3);
	shr_ac(3) <= ac(4);
	shr_ac(4) <= ac(5);
	shr_ac(5) <= ac(6);
	shr_ac(6) <= ac(7);
	shr_ac(7) <= ac(8);
	shr_ac(8) <= ac(9);
	shr_ac(9) <= ac(10);
	shr_ac(10) <= ac(11);
	shr_ac(11) <= ac(12);
	shr_ac(12) <= ac(13);
	shr_ac(13) <= ac(14);
	shr_ac(14) <= ac(15);
	shr_ac(15) <= '0';
	
	-- SOLA KAYDIRMA
	shl_ac(0) <= '0';
	shl_ac(1) <= ac(0);
	shl_ac(2) <= ac(1);
	shl_ac(3) <= ac(2);
	shl_ac(4) <= ac(3);
	shl_ac(5) <= ac(4);
	shl_ac(6) <= ac(5);
	shl_ac(7) <= ac(6);
	shl_ac(8) <= ac(7);
	shl_ac(9) <= ac(8);
	shl_ac(10) <= ac(9);
	shl_ac(11) <= ac(10);
	shl_ac(12) <= ac(11);
	shl_ac(13) <= ac(12);
	shl_ac(14) <= ac(13);
	shl_ac(15) <= ac(14);
	
	
-- ALU ÇIKIŞ İÇİN MUX

muxAluCikis: alu_mux port map(
	a1 => toplam_sonuc,
	a2 => toplam_sonuc,
	a3 => toplam_sonuc,
	a4 => toplam_sonuc,
	a5 => toplam_sonuc,
	a6 => toplam_sonuc,
	a7 => toplam_sonuc,
	a8 => toplam_sonuc,
	a9 => toplam_sonuc,
	a10 => toplam_sonuc,
	a11 => toplam_sonuc,
	a12 => toplam_sonuc,
	
	a13 => xor_sonuc,
	a14 => or_sonuc,
	a15 => and_sonuc,
	a16 => not dr,
	a17 => not ac,
	a18 => ror_ac,
	a19 => rol_ac,
	a20 => shr_ac,
	a21 => shl_ac,
	ss => S,
	sonuc => alu_cikis
);

end calismasi;