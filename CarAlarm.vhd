library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarAlarm is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           remote : in  STD_LOGIC;
           sensor : in  STD_LOGIC;
           alarm : out  STD_LOGIC);
end CarAlarm;

architecture FSM of CarAlarm is
type state is (disabled,w1,enabled,w2,intrusion,w3);
attribute enum_encoding: string;
attribute enum_encoding of state: type is "sequential";
signal prState,nxState:state;
begin
	process(clk,rst)
	begin
		if(rst='1') then
			prState<=disabled;
		elsif(clk'event and clk='1') then
			prState<=nxState;
		end if;
	end process;

	process(prState,remote,sensor)
	begin
		case prState is
			when disabled=>
				alarm<='0';
				if(remote='1') then
					nxState<=w1;
				else
					nxState<=disabled;
				end if;
			when w1=>
				alarm<='0';
				if(remote='0') then
					nxState<=enabled;
				else
					nxState<=w1;
				end if;
			when enabled=>
				alarm<='0';
				if(sensor='1') then
					nxState<=intrusion;
				elsif(remote='1') then
					nxState<=w2;
				else
					nxState<=enabled;
				end if;
			when w2=>
				alarm<='0';
				if(remote='0') then
					nxState<=disabled;
				else
					nxState<=w2;
				end if;
			when intrusion=>
				alarm<='1';
				if(remote='1') then
					nxState<=w3;
				else
					nxState<=intrusion;
				end if;
			when w3=>
				alarm<='0';
				if(remote='0') then
					nxState<=disabled;
				else
					nxState<=w3;
				end if;
		end case;
	end process;
end FSM;
