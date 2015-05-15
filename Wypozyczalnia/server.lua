bike={}



local bikes={
	--x,y,z,rotx,roty,rotz
	{-302.9248046875, 1082.025390625, 19.7421875,0,0,0},
	{-299.955078125, 1081.7333984375, 19.7421875,0,0,0},
	{-294.62109375, 1081.708984375, 19.734390258789,0,0,0},
	{-297.23828125, 1086.8984375, 19.734390258789,0,0,0}
}


addEventHandler("onResourceStart",resourceRoot,function()
	for count,v in ipairs(bikes)do
		id=count
		bike[id]=createVehicle(481,v[1],v[2],v[3],v[4],v[5],v[6])
		setElementData(bike[id],"WypozyczalniaOpis","Wypożyczalnia rowerów\nRower ID : "..id)
	end
end)

timer={}


addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if seat==0 then
		timer[veh]={}
		for i=1,#bikes do
			if veh==bike[i] then
				outputChatBox("*Wyszedłeś(aś) z roweru należącego do wypożyczalni. Masz 5 sekund żeby na niego wrócić inaczej zostanie zrespiony na miejsce zaparkowania i zostanie pobrana opłata w wysokości 5 $",source,255,255,255)
				timer[veh][1],timer[veh][2]=setTimer(respawnVehicle,5000,1,veh)
				timer[veh][2]=setTimer(takePlayerMoney,5000,1,source,5)
			end
		end
	end
end)


addEventHandler("onPlayerVehicleEnter",root,function(veh,seat)
	if seat==0 then
		for i=1,#bikes do
			if veh==bike[i] then
				for k=1,2 do
					if timer[veh] then
						if isTimer(timer[veh][k]) then
							killTimer(timer[veh][k])
						end
					end
				end
			end
		end
	end
end)
