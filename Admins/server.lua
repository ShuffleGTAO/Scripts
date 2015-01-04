--Copyright by Shuffle--
--gtao.pl--
--OwnPlay RPG/RP--




addCommandHandler ( "admins", function ( plr, cmd )
	admini = {}
	support = {}
	super = {}
	for _,v in ipairs ( getElementsByType ( "player" ) ) do
		if isObjectInACLGroup ( "user."..getAccountName(getPlayerAccount(v)), aclGetGroup ( "Admin" ) ) then
			nick = "[#ffff00RCON#ffffff] "..getPlayerName ( v ).." ( "..getElementData ( v, "playerid" ).." )"
			table.insert ( admini, nick )
		end
	end
	outputChatBox ( "________", plr, 0, 255, 255, true )
	outputChatBox ( "RCON-i :", plr, 255, 255, 0 )
	--outputChatBox ( " ", plr, 255, 255, 0 )
	if #admini > 0 then
		c = table.concat ( admini, ", " )
		outputChatBox ( c, plr, 255, 255, 255, true )
	else
		outputChatBox ( "Brak administracji online", plr )
	end
		for _,v in ipairs ( getElementsByType ( "player" ) ) do
		if isObjectInACLGroup ( "user."..getAccountName(getPlayerAccount(v)), aclGetGroup ( "Support" ) ) then
			nick = "[#ff9900Support#ffffff] "..getPlayerName ( v ).." ( "..getElementData ( v, "playerid" ).." )"
			table.insert ( support, nick )
		end
	end
	outputChatBox ( "________", plr, 0, 255, 255, true )
	outputChatBox ( "#ff9900Support :", plr, 0, 255, 255, true )
	--outputChatBox ( " ", plr, 0, 255, 255, true )
	if #support > 0 then
		c = table.concat ( support, ", " )
		outputChatBox ( c, plr, 255, 255, 255, true )
	else
		outputChatBox ( "Brak support online", plr )
	end
			for _,v in ipairs ( getElementsByType ( "player" ) ) do
		if isObjectInACLGroup ( "user."..getAccountName(getPlayerAccount(v)), aclGetGroup ( "SSupport" ) ) then
			nick = "[#0EC711Super Support#ffffff] "..getPlayerName ( v ).." ( "..getElementData ( v, "playerid" ).." )"
			table.insert ( super, nick )
		end
	end
	outputChatBox ( "________", plr, 0, 255, 255, true )
	outputChatBox ( "#0EC711Super Support :", plr, 0, 255, 255, true )
	--outputChatBox ( " ", plr, 0, 255, 255, true )
	if #super > 0 then
		c = table.concat ( super, ", " )
		outputChatBox ( c, plr, 255, 255, 255, true )
	else
		outputChatBox ( "Brak Super Support online", plr )
	end
end)