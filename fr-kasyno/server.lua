local maszyna = createObject ( 2640, -2363.9599609375, 2411.015625, 7.0023946762085 )
setElementData ( maszyna, "message", "Maszyna hazardowa" )
local marker = createMarker ( -2363.9599609375, 2411.015625, 6.0023946762085, "cylinder", 3, 255, 0, 0, 0 )


local active = false
local cash = 0


addEventHandler ( "onMarkerHit", marker, function ( element )
	outputChatBox ( "Działanie : ", element, 255, 255, 255 )
	outputChatBox ( "Przegrana : Kwota postawiona zostaje w maszynie.", element, 255, 255, 255 )
	outputChatBox ( "Wygrana : Dostajesz zwrot zastawionej kwoty + 50% tej kwoty.", element, 255, 255, 255 )
	outputChatBox ( "Wpisz /postaw <kwota>", element, 255, 255, 255 )
end)

local function result ( plr, type )
	if type == true then
		wynik = cash + (cash/2)
		outputChatBox ( "Brawo! Maszyna wylosowała Twoje liczby - zgarniasz "..string.format ( "EUR %0.2f", wynik ).."", plr, 255, 255, 255 )
		givePlayerMoney ( plr, wynik )
		active = false
	elseif type == false then
		outputChatBox ( "Niestety, masz dzisiaj pecha. Maszyna wylosowała inne liczby.", plr, 255, 255, 255 )
		active = false
	end
end

addCommandHandler ( "postaw", function ( plr, cmd, kwota )
	if kwota then
	if active == true then
		return outputChatBox ( "Wyliczanie jeszcze trwa", plr, 255, 255, 255 )
	end
		kwota = tonumber ( kwota )
		cash = 0
		rnd = nil
		if type ( kwota ) == "number" then
			if isElementWithinMarker ( plr, marker ) then
				if kwota >= 0 then
					if kwota > getPlayerMoney ( plr ) then
						local price = string.format ( "EUR %0.2f", kwota )
						return outputChatBox ( "Nie posiadasz "..price, plr, 255, 255, 255 )
					end
					rnd = math.random ( 1, 8 )
					outputChatBox ( "Losowanie wystartowało.", plr, 255, 255, 255 )
					active = true
					takePlayerMoney ( plr, kwota )
					cash = kwota
					if rnd == 1 or rnd == 3 or rnd == 4 or rnd == 5 or rnd == 6 or rnd == 7 or rnd == 8 then
						setTimer ( result, 4000, 1, plr, true )
					elseif rnd == 2 then
						setTimer ( result, 4000, 1, plr, false )
					end
				end
			end
		end
	end
end)