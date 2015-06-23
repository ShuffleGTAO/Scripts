
addEventHandler("onPlayerLogin",root,function()
	setElementData(source,"CB",0)
	bindKey(source,"U","down","chatbox","CB")
end)


addCommandHandler("cb.kanal",function(plr,cmd,id)
	if id then
		if type(tonumber(id))=="number" then
			if tonumber(id)>0 then
				setElementData(plr,"CB",id)
				for _,v in ipairs(getElementsByType("player"))do
					if getElementData(plr,"CB")==id then
						outputChatBox("*Gracz "..getPlayerName(plr).." wszedł na #"..id.." kanał CB",v,255,255,255)
					end
				end
			end
		end
	end
end)


addCommandHandler("CB",function(plr,cmd,...)
	if ... then
		local msg=table.concat({...}," ")
		for _,v in ipairs(getElementsByType("player"))do
			if getElementData(v,"CB")==getElementData(plr,"CB") then
				outputChatBox("[CB : "..getElementData(plr,"CB").."] "..getPlayerName(plr).." > "..msg,v,255,255,255)
			end
		end
	end
end)

