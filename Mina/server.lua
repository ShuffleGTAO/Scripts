
mina={}



addCommandHandler("mina",function(plr)
	local x,y,z=getElementPosition(plr)
	setPedAnimation (plr,"BOMBER","BOM_Plant")
	setTimer (setPedAnimation,1500,1,plr,false )
	local x,y,z = getElementPosition(plr)
	setTimer(function()
		ob=createObject(1953,x,y,z-1)
		mina[plr]=createMarker(x,y,z-1,"cylinder",2,255,255,255,0)
		setElementData(mina[plr],"mina",getPlayerName(plr))
		attachElements(ob,mina[plr])
	end,1500,1)
	outputChatBox("*Rozstawiłeś(aś) minę, uważaj na nią!",plr,255,255,255)
end)


addEventHandler("onMarkerHit",root,function(e)
	if getElementData(source,"mina") then
		if getElementType(e)=="player" then
			if getElementData(source,"mina")==getPlayerName(e) then return end
			local x,y,z=getElementPosition(e)
			createExplosion(x,y,z,3)
			if getPlayerFromName(getElementData(source,"mina")) then
				outputChatBox("*Gracz "..getPlayerName(e).." wszedł na Twoją minę!",getPlayerFromName(getElementData(source,"mina")),255,255,255)
			end
			for _,v in ipairs(getAttachedElements(source))do
				destroyElement(v)
			end
			destroyElement(source)
		end
	end
end)