addCommandHandler ( "hol", function ( plr, cmd, id )
	if id then
		id = tonumber ( id )
		for _,v in ipairs ( getElementsByType ( "vehicle" ) ) do
			if getElementData ( v, "id" ) then
				if getElementData ( v, "id" ) == id then
					pojazd = v
				end
			end
		end
		id2 = getElementData ( pojazd, "id" ) or "Brak"
		owner = getElementData ( pojazd, "owner" ) or "Brak"
		name = getVehicleName ( pojazd )
		xmlSave = xmlLoadFile ( "zapis.xml" )
		child = xmlCreateChild ( xmlSave, "Pojazd" )
		xmlNodeSetAttribute ( child, "ID", id2 )
		xmlNodeSetAttribute ( child, "owner", owner )
		xmlNodeSetAttribute ( child, "name", name )
		destroyElement ( pojazd )
		outputChatBox ( "Pojazd "..name.." ( ID "..id2.." ) został odholowany do przechowalni!", plr, 255, 255, 255 )
		xmlSaveFile ( xmlSave )
		xmlUnloadFile ( xmlSave )
	end
end)


addCommandHandler ( "lista", function ( plr )
	poj = {}
	xmlLoad = xmlLoadFile ( "zapis.xml" )
	for _,v in ipairs ( xmlNodeGetChildren ( xmlLoad ) ) do
		if xmlNodeGetAttribute ( v, "owner" ) == getPlayerName ( plr ) then
			name = xmlNodeGetAttribute ( v, "name" )
			id = xmlNodeGetAttribute ( v, "ID" )
			i = ""..name.." ( ID "..id.." ) "
			table.insert ( poj, i )
		end
	end
	if #poj == 0 then
		outputChatBox ( "Nie posiadasz żadnego pojazdu w przechowywalni.", plr, 255, 255, 255 )
	elseif #poj > 0 then
		msg = table.concat ( poj, ", " )
		outputChatBox ( "Pojazdy :", plr, 255, 255, 255 )
		outputChatBox ( msg, plr, 255, 255, 255 )
	end
	xmlUnloadFile ( xmlLoad )
end)
