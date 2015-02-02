local dbname = "dbname"
local host = "host"
local username = "username"
local pass = "pass"

liczba = 0

local db = dbConnect("mysql", "dbname="..dbname..";host="..host.."", ""..username.."",""..pass.."","share=1")

addEventHandler ( "onResourceStart", resourceRoot, function ()
	local q = dbQuery ( db, "SELECT * FROM FR_Radary" )
	local w = dbPoll ( q, -1 )
	dbFree ( q )
	for k,v in ipairs ( w ) do
		marker = createMarker ( v.x, v.y, v.z-1, "cylinder", 6, 255, 255, 255, 0 )
		setElementData ( marker, "predkosc", v.predkosc )
		liczba = k
	end
	outputDebugString ( "[Radary] Utworzono "..liczba.." radarów" )
end)

local function getVehicleSpeed ( element )
	speedx, speedy, speedz = getElementVelocity ( element )
	actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
	kmh = actualspeed * 180
	return kmh
end

addEventHandler ( "onMarkerHit", root, function ( element )
	if getElementData ( source, "predkosc" ) then
		speed = tonumber ( getElementData ( source, "predkosc" ) )
		if getElementType ( element ) == "player" then
			veh = getPedOccupiedVehicle ( element )
			if veh then
				if getVehicleSpeed ( veh ) > speed then
					local przekroczono = math.floor ( getVehicleSpeed ( veh ) - speed )
					local kara = string.format ( "%3.0f", przekroczono /3 )
					for i = 1, 10 do
						outputChatBox ( " ", element )
					end
					outputChatBox ( "Przekroczyłeś prędkość o "..przekroczono.." km/h! Dopuszczalna prędkość : "..speed.." km/h", element, 255, 255, 255 )
					outputChatBox ( "Zapłaciłeś : "..kara.." $ kary.", element, 255, 255, 255 )
				end
			end
		end
	end
end)



addCommandHandler ( "dodaj.radar", function ( plr, cmd, predkosc )
	if isObjectInACLGroup ( "user."..getAccountName ( getPlayerAccount ( plr ) ), aclGetGroup ( "Admin" ) ) then
		if type(tonumber(predkosc)) ~= "number" then
			if not predkosc or predkosc == nil or predkosc < 0 then
				return outputChatBox ( "[Użycie] /dodaj.radar <prędkość>", plr, 255, 255, 255 )
			end
		end
		local x,y,z = getElementPosition ( plr )
		dbExec ( db, "INSERT INTO FR_Radary ( x, y, z, predkosc ) VALUES ( ?,?,?,? )", x, y, z, tonumber(predkosc) )
		outputChatBox ( "Dodano w tym miejscu radar z ograniczoną prędkością do "..predkosc.." km/h", plr, 255, 255, 255 )
		restartResource ( getResourceFromName ( "fr-radary" ) )
	end
end)