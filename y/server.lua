local function searchVehFromID ( id )
	for _,v in ipairs ( getElementsByType ( "vehicle" ) ) do
		if getElementData ( v, "id" ) == tonumber ( id ) then
			return v
		end
	end
	return false
end

local function isOwner ( auto, plr )
	if getElementData ( auto, "owner" ) == getPlayerName ( plr ) then
		return true
	end
	return false
end


local function sendOffer ( gracz, pojazd, plr )
	name = getVehicleName ( pojazd )
	id = getElementData ( pojazd, "id" ) or "Brak"
	setElementData ( gracz, "Oferta", true )
	setElementData ( gracz, "Pojazd", name )
	setElementData ( gracz, "ID", id )
	setElementData ( gracz, "Oferujacy", getPlayerName ( plr ) )
	outputChatBox ( "Gracz "..getElementData ( gracz, "Oferujacy" ).." wyslał Ci ofertę sprzedaży pojazdu "..name.." ( ID "..id.." )", gracz, 255, 255, 255 )
	outputChatBox ( "Wpisz /przyjmij, aby kupić. Masz 15 sek na reakcję.", gracz, 255, 255, 255 )
	setTimer ( setElementData, 15000, 1, gracz, "Oferta", false )
	setTimer ( setElementData, 15000, 1, gracz, "Pojazd", false )
	setTimer ( setElementData, 15000, 1, gracz, "ID", false )
	setTimer ( setElementData, 15000, 1, gracz, "Oferujacy", false )
	setTimer ( outputChatBox, 15000, 1, "Oferta wygasła.", gracz, 255, 255, 255 )
	setTimer ( outputChatBox, 15000, 1, "Oferta wygasła.", plr, 255, 255, 255 )
end
	
	
addCommandHandler ( "przyjmij", function ( plr, cmd )
	if not getElementData ( plr, "Oferta" ) then 
		return outputChatBox ( "Nie dostałeś oferty kupna pojazdu bądź oferta wygasłą", plr, 255, 255, 255 ) end
	id = tonumber ( getElementData ( plr, "ID" ) )
	name = getElementData ( plr, "Pojazd" )
	oferujacy = getElementData ( plr, "Oferujacy" )
	pojazd = searchVehFromID ( id )
	if not pojazd then 
		return outputChatBox ( "Nie znaleziono pojazdu o ID "..id.."", plr, 255, 255, 255 ) end
	setElementData ( pojazd, "owner", getPlayerName ( plr ) )
	outputChatBox ( "Kupiłeś pojazd "..name.." ( ID "..id.." ) od gracza "..oferujacy.."", plr, 0, 255, 0 )
	outputChatBox ( "Gracz "..getPlayerName ( plr ).." przyjął ofertę kupna pojazdu!", getPlayerFromName ( oferujacy ), 0, 255, 0 )
	setElementData ( plr, "Oferta", false )
	setElementData ( plr, "Pojazd", false )
	setElementData ( plr, "ID", false )
	setElementData ( plr, "Oferujacy", false )
end)
	
	

addCommandHandler ( "v.sprzedaj", function ( plr, cmd, id, gracz )
	if id and gracz then
		id = tonumber ( id )
		auto = searchVehFromID ( id )
		if not auto then
			return outputChatBox ( "Nie znaleziono pojazdu o ID "..id.."", plr ) end
		if not isOwner ( auto, plr ) then
			return outputChatBox ( "Pojazd "..getVehicleName ( auto ).." nie jest Twój", plr ) end
		kupujacy = getPlayerFromName ( gracz )
		if not kupujacy then
			return outputChatBox ( "Gracz "..gracz.." nie jest online!", plr ) end
		sendOffer ( kupujacy, auto, plr )
	end
end)
			