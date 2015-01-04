--Copyright by Shuffle--
--gtao.pl--
--OwnPlay RPG/RP--




function partNick ( plr, txt )
	osoby = {}
	gracz = txt and txt:gsub("#%x%x%x%x%x%x", ""):lower() or nil
	for _,v in ipairs ( getElementsByType ( "player" ) ) do
		gracz_ = getPlayerName(v):gsub("#%x%x%x%x%x%x", ""):lower()
		if gracz_:find(gracz, 1, true) then
			table.insert ( osoby, v )
			name = v
		end
	end
	if #osoby > 1 then
		return outputChatBox ( "Znaleziono więcej niż 1 gracza!", plr )
	end
	if #osoby == 0 then
		outputChatBox ( "Nie znaleziono żadnego gracza!", plr ) return false
	end
	return name
end