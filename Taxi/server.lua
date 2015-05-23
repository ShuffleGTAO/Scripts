local allow_vehs={
	[420]=true,
}

local vehs={
	{-301.5546875, 1085.701171875, 19.7421875},
}

taxi={}

for k,v in ipairs(vehs)do
	taxi[k]=createVehicle(420,v[1],v[2],v[3])
	setElementData(taxi[k],"vehicle:taxi",true)
end

addEventHandler("onPlayerVehicleEnter",root,function(veh,seat)
	if seat==0 then
		if allow_vehs[getElementModel(veh)] then
			if getElementData(veh,"vehicle:taxi") then
				outputChatBox("*Zostałeś(aś) taksówkarzem. Dostaniesz informację o położeniu klienta po wezwaniu usługi.",source,255,255,255)
				setElementData(source,"player:taxi",true)
			end
		end
	end
	if allow_vehs[getElementModel(veh)] then
		if getElementData(veh,"vehicle:taxi") then
			setElementData(source,"taxi",false)
		end
	end
end)

addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if seat==0 then
		if allow_vehs[getElementModel(veh)] then
			if getElementData(veh,"vehicle:taxi") then
				respawnVehicle(veh)
				setElementData(source,"player:taxi",false)
			end
		end
	end
end)



addCommandHandler("taxi",function(plr)
	if getElementData(plr,"taxi") then
		return outputChatBox("*Zamówiłeś(aś) już usługę. Poczekaj cierpliwie na taksówkę",plr,255,255,0)
	end
	count={}
	for _,v in ipairs(getElementsByType("player"))do
		if getPedOccupiedVehicle(v) then
			if getElementData(getPedOccupiedVehicle(v),"vehicle:taxi") then
				if allow_vehs[getElementModel(getPedOccupiedVehicle(v))] then
					table.insert(count,v)
				end
			end
		end
	end
	if #count==0 then
		return outputChatBox("*Brak taksówkarzy na służbie.",plr,255,255,0)
	end
	local x,y,z=getElementPosition(plr)
	for _,v in ipairs(getElementsByType("player"))do
		if getPedOccupiedVehicle(v) then
			if getElementData(getPedOccupiedVehicle(v),"vehicle:taxi") then
				if allow_vehs[getElementModel(getPedOccupiedVehicle(v))] then
					outputChatBox("--NOWE ZLECENIE--",v,255,255,0)
					outputChatBox("*Gracz "..getPlayerName(plr).." zamówił(a) usługę taxi.",v,255,255,0)
					local miasto=getZoneName(x,y,z)
					local strefa=getZoneName(x,y,z,true)
					outputChatBox("*Położenie : "..miasto..", "..strefa,v,255,255,0)
				end
			end
		end
	end
	outputChatBox("*Zamówiłeś(aś) usługę taxi. Czekaj cierpliwie w tym miejscu, taksówkarz nie będzie cie szukał.",plr,255,255,0)
	setElementData(plr,"taxi",true)
end)


addCommandHandler("oplata",function(plr,cmd,gracz,ilosc)
	if getElementData(plr,"player:taxi") then
		local cel=getPlayerFromName(gracz)
		if cel then
			setElementData(cel,"TaxiInfo",{plr,ilosc})
			outputChatBox("*Gracz "..getPlayerName(plr).." podał(a) Ci kwitek do zapłaty "..ilosc.." $. Aby podpisać wpisz /akceptuj",cel,255,255,255)
			outputChatBox("*Podałeś(aś) kwitek klientowi do zapłaty.",plr,255,255,255)
		end
	end
end)

addCommandHandler("akceptuj",function(plr)
	if getElementData(plr,"TaxiInfo") then
		local taksowkarz,ilosc=unpack(getElementData(plr,"TaxiInfo"))
		local taksowkarz=getPlayerFromName(getPlayerName(taksowkarz))
		if not taksowkarz then
			return outputChatBox("*Taksówkarz nie jest już online",plr,255,255,255)
		end
		if tonumber(getPlayerMoney(plr))<tonumber(ilosc) then
			return outputChatBox("*Nie posiadasz pieniędzy aby podpisać kwitek z kwotą "..ilosc.." $",plr,255,255,255)
		end
		givePlayerMoney(taksowkarz,tonumber(ilosc))
		takePlayerMoney(plr,tonumber(ilosc))
		outputChatBox("*Podpisałeś kwitek. Zabrano Ci "..ilosc.." $",plr,255,255,255)
		outputChatBox("*Gracz "..getPlayerName(plr).." podpisał kwitek. Otrzymujesz "..ilosc.." $",taksowkarz,255,255,255)
	end
end)
