--Copyright by Shuffle--
--gtao.pl--
--OwnPlay RPG/RP--




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

timer = {}

local function sendOffer ( gracz, pojazd, plr, cena )
	name = getVehicleName ( pojazd )
	id = getElementData ( pojazd, "id" ) or "Brak"
	setElementData ( gracz, "Oferta", true )
	setElementData ( gracz, "Pojazd", name )
	setElementData ( gracz, "ID", id )
	setElementData ( gracz, "Oferujacy", getPlayerName ( plr ) )
	setElementData ( gracz, "Cena", cena )
	outputChatBox ( "Gracz "..getElementData ( gracz, "Oferujacy" ).." wyslał Ci ofertę sprzedaży pojazdu "..name.." ( ID "..id.." ) w cenie "..string.format ( "%0.2f", cena ).." zł", gracz, 255, 255, 255 )
	outputChatBox ( "Wpisz /przyjmij, aby kupić. Masz 15 sek na reakcję.", gracz, 255, 255, 255 )
	timer[1] = setTimer ( setElementData, 15000, 1, gracz, "Oferta", false )
	timer[2] = setTimer ( setElementData, 15000, 1, gracz, "Pojazd", false )
	timer[3] = setTimer ( setElementData, 15000, 1, gracz, "ID", false )
	timer[4] = setTimer ( setElementData, 15000, 1, gracz, "Oferujacy", false )
	timer[5] = setTimer ( setElementData, 15000, 1, gracz, "Cena", false )
	timer[6] = setTimer ( outputChatBox, 15000, 1, "Oferta wygasła.", gracz, 255, 255, 255 )
	timer[7] = setTimer ( outputChatBox, 15000, 1, "Oferta wygasła.", plr, 255, 255, 255 )
end
	
	
addCommandHandler ( "przyjmij", function ( plr, cmd )
	if not getElementData ( plr, "Oferta" ) then 
		return outputChatBox ( "Nie dostałeś oferty kupna pojazdu bądź oferta wygasła", plr, 255, 255, 255 ) end
	id = tonumber ( getElementData ( plr, "ID" ) )
	name = getElementData ( plr, "Pojazd" )
	oferujacy = getElementData ( plr, "Oferujacy" )
	cena = tonumber ( getElementData ( plr, "Cena" ) )
	pojazd = searchVehFromID ( id )
	if not pojazd then 
		return outputChatBox ( "Nie znaleziono pojazdu o ID "..id.."", plr, 255, 255, 255 ) end
	if tonumber ( getPlayerMoney ( plr ) ) < cena *100 then
		return outputChatBox ( "Nie posiadasz "..string.format ( "%0.2f", cena ).." zł na zakup tego pojazdu", plr, 255, 255, 255 ) end
	setElementData ( pojazd, "owner", getPlayerName ( plr ) )
	outputChatBox ( "Kupiłeś pojazd "..name.." ( ID "..id.." ) od gracza "..oferujacy.."", plr, 0, 255, 0 )
	outputChatBox ( "Gracz "..getPlayerName ( plr ).." przyjął ofertę kupna pojazdu!", getPlayerFromName ( oferujacy ), 0, 255, 0 )
	setElementData ( plr, "Oferta", false )
	setElementData ( plr, "Pojazd", false )
	setElementData ( plr, "ID", false )
	setElementData ( plr, "Oferujacy", false )
	setElementData ( plr, "Cena", false )
	takePlayerMoney ( plr, cena*100 )
	for k,_ in ipairs ( timer ) do
		if isTimer ( timer[k] ) then
			killTimer ( timer[k] )
		end
	end
end)
	
	

addCommandHandler ( "auto.sprzedaj", function ( plr, cmd, id, gracz, cena )
	if not id or not gracz or not cena or id == nil or gracz == nil or cena == nil then
		return outputChatBox ( "[Użycie] /auto.sprzedaj  [ID_Pojazdu] [Część_Nicku_Gracza] [Cena]", plr, 255, 255, 255 ) end
	id = tonumber ( id )
	auto = searchVehFromID ( id )
	if not auto then
		return outputChatBox ( "Nie znaleziono pojazdu o ID "..id.."", plr ) end
	if not isOwner ( auto, plr ) then
		return outputChatBox ( "Pojazd "..getVehicleName ( auto ).." nie jest Twój", plr ) end
	kupujacy = exports["GTAO_Gamemode"]:partNick ( plr, gracz )
	if not kupujacy then return end
	sendOffer ( kupujacy, auto, plr, cena )
	outputChatBox ( "Wysłano ofertę sprzedaży pojazdy do gracza "..getPlayerName ( kupujacy ).."!", plr, 255, 255, 255 )
end)
			