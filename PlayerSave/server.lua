Player = {}

addEventHandler ( "onPlayerQuit", root, function ()
	PlayerSaved = source
	found = {}
	Player.Skin = getElementModel ( PlayerSaved )
	Player.Cash = getPlayerMoney ( PlayerSaved )
	Player.Interior = getElementInterior ( PlayerSaved )
	Player.Dimension = getElementDimension ( PlayerSaved )
	Player.x, Player.y, Player.z = getElementPosition ( PlayerSaved )
	xmlZapis = xmlLoadFile ( "zapis.xml" )
	for _,v in ipairs ( xmlNodeGetChildren ( xmlZapis ) ) do
		if xmlNodeGetAttribute ( v, "Nick" ) == getPlayerName ( PlayerSaved ) then
			table.insert ( found, v )
		end
	end
	if #found == 0 then
		child = xmlCreateChild ( xmlZapis, "Player" )
		xmlNodeSetAttribute ( child, "Nick", getPlayerName ( PlayerSaved ) )
		xmlNodeSetAttribute ( child, "Skin", tonumber ( Player.Skin ) )
		xmlNodeSetAttribute ( child, "Cash", tonumber ( Player.Cash ) )
		xmlNodeSetAttribute ( child, "Interior", tonumber ( Player.Interior ) )
		xmlNodeSetAttribute ( child, "Dimension", tonumber ( Player.Skin ) )
		xmlNodeSetAttribute ( child, "x", tonumber ( Player.x ) )
		xmlNodeSetAttribute ( child, "y", tonumber ( Player.y ) )
		xmlNodeSetAttribute ( child, "z", tonumber ( Player.z ) )
	elseif #found > 1 or #found == 1 then
		for _,v in ipairs ( xmlNodeGetChildren ( xmlZapis ) ) do
			if xmlNodeGetAttribute ( v, "Nick" ) == getPlayerName ( PlayerSaved ) then
				xmlDestroyNode ( v )
			end
		end
		child = xmlCreateChild ( xmlZapis, "Player" )
		xmlNodeSetAttribute ( child, "Nick", getPlayerName ( PlayerSaved ) )
		xmlNodeSetAttribute ( child, "Skin", tonumber ( Player.Skin ) )
		xmlNodeSetAttribute ( child, "Cash", tonumber ( Player.Cash ) )
		xmlNodeSetAttribute ( child, "Interior", tonumber ( Player.Interior ) )
		xmlNodeSetAttribute ( child, "Dimension", tonumber ( Player.Skin ) )
		xmlNodeSetAttribute ( child, "x", tonumber ( Player.x ) )
		xmlNodeSetAttribute ( child, "y", tonumber ( Player.y ) )
		xmlNodeSetAttribute ( child, "z", tonumber ( Player.z ) )
	end
	found = {}
	xmlSaveFile ( xmlZapis )
	xmlUnloadFile ( xmlZapis )
end)


addEventHandler ( "onPlayerLogin", root, function ()
	PlayerLoaded = source
	xmlLoad = xmlLoadFile ( "zapis.xml" )
	founded = {}
	for _,v in ipairs ( xmlNodeGetChildren ( xmlLoad ) ) do
		if xmlNodeGetAttribute ( v, "Nick" ) == getPlayerName ( PlayerLoaded ) then
			Player.Skin = xmlNodeGetAttribute ( v, "Skin" )
			Player.Money = xmlNodeGetAttribute ( v, "Cash" )
			Player.Interior = xmlNodeGetAttribute ( v, "Interior" )
			Player.Dimension = xmlNodeGetAttribute ( v, "Dimension" )
			Player.x = xmlNodeGetAttribute ( v, "x" )
			Player.y = xmlNodeGetAttribute ( v, "y" )
			Player.z = xmlNodeGetAttribute ( v, "z" )
			setElementModel ( PlayerLoaded, tonumber ( Player.Skin ) )
			setPlayerMoney ( PlayerLoaded, tonumber ( Player.Money ) )
			setElementInterior ( PlayerLoaded, tonumber ( Player.Interior ) )
			setElementDimension ( PlayerLoaded, tonumber ( Player.Dimension ) )
			setElementPosition ( PlayerLoaded, tonumber ( Player.x ), tonumber ( Player.y ), tonumber ( Player.z ) )
			table.insert ( founded, v )
		end
	end
	if #founded == 0 then
		outputChatBox ( "[ #00FF00INFO#ffffff ] Twój zapis konta nie jest w bazie, po następnym zalogowaniu będzie on aktywny", PlayerLoader, 255, 255, 255, true )
	end
	founded = {}
end)