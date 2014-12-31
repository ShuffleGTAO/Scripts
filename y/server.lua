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
		c1,c2,c3,c4 = getVehicleColor ( pojazd )
		xmlSave = xmlLoadFile ( "zapis.xml" )
		child = xmlCreateChild ( xmlSave, "Pojazd" )
		xmlNodeSetAttribute ( child, "ID", id2 )
		xmlNodeSetAttribute ( child, "owner", owner )
		xmlNodeSetAttribute ( child, "name", name )
		xmlNodeSetAttribute ( child, "c1", c1 )
		xmlNodeSetAttribute ( child, "c2", c2 )
		xmlNodeSetAttribute ( child, "c3", c3 )
		xmlNodeSetAttribute ( child, "c4", c4 )
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



addCommandHandler ( "odkup", function ( plr, cmd, id3 )
	if id3 then
		pojazd_number = {}
		id3 = tonumber ( id3 )
		xmlUnload = xmlLoadFile ( "zapis.xml" )
		for _,v in ipairs ( xmlNodeGetChildren ( xmlUnload ) ) do
			if tonumber ( xmlNodeGetAttribute ( v, "ID" ) ) == id3 then
				name = xmlNodeGetAttribute ( v, "name" )
				table.insert ( pojazd_number, name )
				owner = xmlNodeGetAttribute ( v, "owner" )
				c1,c2,c3,c4 = xmlNodeGetAttribute ( v, "c1" ), xmlNodeGetAttribute ( v, "c2" ), xmlNodeGetAttribute ( v, "c3" ), xmlNodeGetAttribute ( v, "c4" )
				node = v
			end
		end
		if #pojazd_number == 0 then
			return outputChatBox ( "Nie znaleziono pojazdu w przechowywalni o ID "..id3..".", plr, 255, 255, 255 ) end
		auto = createVehicle ( getVehicleIDFromName ( name ), -276.4560546875, 1056.4609375, 19.589454650879 )
		setVehicleColor ( auto, c1,c2,c3,c4 )
		setElementData ( auto, "owner", owner )
		setElementData ( auto, "id", id3 )
		outputChatBox ( "Pojazd "..name.." ( ID "..id3.." ) został wyciągnięty z przechowywalni", plr, 255, 255, 255 )
		setElementData ( auto, "message", "Właściciel : "..owner.."" )
		xmlDestroyNode ( node )
		xmlSaveFile ( xmlUnload )
		xmlUnloadFile ( xmlUnload )
	end
end)