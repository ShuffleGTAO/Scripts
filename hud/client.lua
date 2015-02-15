local screenWidth, screenHeight = guiGetScreenSize()
local w = screenWidth/640
local y = screenHeight/480

local opened = {}

opened.stat = false


addEventHandler ( "onClientRender", root, function ()
	if opened.stat == true then
		local time = getRealTime ()
		if time.hour < 10 then
			time.hour = "0"..time.hour
		end
		if time.minute < 10 then
			time.minute = "0"..time.minute
		end
		local czas = ""..time.hour.." : "..time.minute..""
		local playerHealth = math.floor( getElementHealth( localPlayer ))
		local playerArmor = math.floor( getPedArmor( localPlayer ))
		local playerCash = string.format ( "$ %08.0f", getPlayerMoney ( localPlayer ))
		dxDrawText(czas, 481*w, 24*y, 609*w, 57*y, tocolor(0, 0, 0, 255), 1.00*w, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText(czas, 480*w, 23*y, 608*w, 56*y, tocolor(255, 255, 255, 255), 1.00*w, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawRectangle(468*w, 72*y, 151*w, 10*y, tocolor(0, 0, 0, 255), true)
		dxDrawRectangle(474*w, 72*y, 140*w/100*playerHealth, 10*y, tocolor(163, 0, 0, 255), true)
		--dxDrawText("HEALTH : "..playerHealth.." %", 516*w, 73*y, 572*w, 84*y, tocolor(0, 0, 0, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		--dxDrawText("HEALTH : "..playerHealth.." %", 516*w, 71*y, 572*w, 82*y, tocolor(0, 0, 0, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		--dxDrawText("HEALTH : "..playerHealth.." %", 514*w, 73*y, 570*w, 84*y, tocolor(0, 0, 0, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		--dxDrawText("HEALTH : "..playerHealth.." %", 514*w, 71*y, 570*w, 82*y, tocolor(0, 0, 0, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("HEALTH : "..playerHealth.." %", 515*w, 72*y, 571*w, 83*y, tocolor(255, 255, 255, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawRectangle(468*w, 98*y, 151*w, 10*y, tocolor(0, 0, 0, 255), true)
		dxDrawRectangle(474*w, 98*y, 140*w/100*playerArmor, 10*y, tocolor(85, 85, 85, 255), true)
		--dxDrawText("ARMOR : "..playerArmor.." %", 516*w, 99*y, 572*w, 110*y, tocolor(0, 0, 0, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		--dxDrawText("ARMOR : "..playerArmor.." %", 516*w, 97*y, 572*w, 108*y, tocolor(0, 0, 0, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		--dxDrawText("ARMOR : "..playerArmor.." %", 514*w, 99*y, 570*w, 110*y, tocolor(0, 0, 0, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		--dxDrawText("ARMOR : "..playerArmor.." %", 514*w, 97*y, 570*w, 108*y, tocolor(0, 0, 0, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText("ARMOR : "..playerArmor.." %", 515*w, 98*y, 571*w, 109*y, tocolor(255, 255, 255, 255), 0.60*w, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText(playerCash, 469*w, 133*y, 615*w, 155*y, tocolor(0, 0, 0, 255), 1.00*w, "sans", "center", "center", false, false, true, false, false)
		dxDrawText(playerCash, 468*w, 132*y, 614*w, 154*y, tocolor(7, 67, 4, 255), 1.00*w, "sans", "center", "center", false, false, true, false, false)
	end
end)

addEventHandler ( "onClientResourceStart", resourceRoot, function ()
	showPlayerHudComponent ( "clock", false )
	showPlayerHudComponent ( "armour", false )
	showPlayerHudComponent ( "health", false )
	showPlayerHudComponent ( "weapon", false )
	showPlayerHudComponent ( "money", false )
	opened.stat = true
end)