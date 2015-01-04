--Copyright by Shuffle--
--gtao.pl--
--OwnPlay RPG/RP--




function naliczCzas ()
	for _,v in ipairs ( getElementsByType ( "player" ) ) do
		konto = getPlayerAccount ( v )
		h = getAccountData ( konto, "h" ) 
		m = getAccountData ( konto, "m" )
		s = getAccountData ( konto, "s" )
		s = s +1
		setAccountData ( konto, "s", s )
		if s > 59 then
			setAccountData ( konto, "s", 0 )
			setAccountData ( konto, "m", m + 1 )
		end
		if m > 59 then
			setAccountData ( konto, "m", 0 )
			setAccountData ( konto, "h", h + 1 )
		end
	end
end

setTimer ( naliczCzas, 1000, 0 )