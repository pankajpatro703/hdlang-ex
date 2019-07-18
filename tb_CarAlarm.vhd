LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_CarAlarm_vhd IS
END tb_CarAlarm_vhd;

ARCHITECTURE behavior OF tb_CarAlarm_vhd IS 

	COMPONENT CarAlarm
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		remote : IN std_logic;
		sensor : IN std_logic;          
		alarm : OUT std_logic
		);
	END COMPONENT;

	SIGNAL clk :  std_logic := '0';
	SIGNAL rst :  std_logic := '0';
	SIGNAL remote :  std_logic := '0';
	SIGNAL sensor :  std_logic := '0';
	SIGNAL alarm :  std_logic;

BEGIN
 
	uut: CarAlarm PORT MAP(
		clk => clk,
		rst => rst,
		remote => remote,
		sensor => sensor,
		alarm => alarm
	);

	tb1 : PROCESS
	BEGIN
		wait for 20 ns;
		clk<=not clk;
	END PROCESS;
	
	tb2 : PROCESS
	BEGIN
		wait for 250 ns;
		rst<='1';
		wait for 30 ns;
		rst<='0';
		wait;
	END PROCESS;

	tb3 : PROCESS
	BEGIN
		wait for 30 ns;
		remote<='1';
		wait for 30 ns;
		remote<='0';
		wait for 300 ns;
		remote<='1';
		wait for 30 ns;
		remote<='0';
		wait for 150 ns;
		remote<='1';
		wait for 30 ns;
		remote<='0';
		wait for 30 ns;
		remote<='1';
		wait for 30 ns;
		remote<='0';
		wait;
	END PROCESS;
	
	tb4 : PROCESS
	BEGIN
		wait for 100 ns;
		sensor<='1';
		wait for 40 ns;
		sensor<='0';
		wait for 300 ns;
		sensor<='1';
		wait for 250 ns;
		sensor<='0';
		wait for 100 ns;
		sensor<='1';
		wait for 40 ns;
		sensor<='0';
		wait;
	END PROCESS;	
	
END;
