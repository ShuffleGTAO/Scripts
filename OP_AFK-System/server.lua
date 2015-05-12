afk_marker={}

addCommandHandler("afk",function(plr)
	if not getElementData(plr,"P:AFK") then
		afk_marker[plr]={}
		for i=1,#afk_marker[plr] do
			if isElement(afk_marker[plr][i]) then
				destroyElement(afk_marker[plr][i])
			end
		end
		local x,y,z=getElementPosition(plr)
		afk_marker[plr][1]=createMarker(x,y,z,"checkpoint",3,255,0,0,100)
		setElementFrozen(plr,true)
		setElementData(plr,"P:AFK",true)
		for _,v in ipairs(getElementsByType("player"))do
			outputChatBox("#ffffffGracz#ff0000 "..getPlayerName(plr).." #ffffffprzeszedł na tryb AFK",v,255,0,0,true)
		end
	else
		for i=1,#afk_marker[plr] do
			if isElement(afk_marker[plr][i]) then
				destroyElement(afk_marker[plr][i])
			end
		end
		setElementFrozen(plr,false)
		setElementData(plr,"P:AFK",false)
		for _,v in ipairs(getElementsByType("player"))do
			outputChatBox("#ffffffGracz#ff0000 "..getPlayerName(plr).." #ffffffzszedł z trybu AFK",v,255,0,0,true)
		end
	end
end)