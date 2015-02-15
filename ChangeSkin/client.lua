arrow = {}
valid = {}




--USTAWIENIA

CHAT = true
HUD = false
MOUSE = true

--USTAWIENIA

mojeW,mojeH = 640, 480
sW,sH = guiGetScreenSize()
w, h = (sW/mojeW), (sH/mojeH)

arrow[1] = guiCreateStaticImage(233*w, 307*h, 57*w, 43*h, "left_off.png", false)


arrow[2] = guiCreateStaticImage(346*w, 307*h, 57*w, 43*h, "right_off.png", false)

addEventHandler ( "onClientResourceStart", resourceRoot, function ()
	for k,_ in ipairs ( arrow ) do
		guiSetVisible ( arrow[k], true )
	end
	if MOUSE == true then
		showCursor ( true )
	end
	if HUD == false then
		showPlayerHudComponent ( "all", false )
	else
		showPlayerHudComponent ( "all", true )
	end
	if CHAT == true then
		showChat ( true )
	else
		showChat ( false )
	end
	for _,v in ipairs ( getValidPedModels() ) do
		table.insert ( valid, v )
	end
	setElementData ( arrow[1], "right", true )
	setElementData ( arrow[1], "left", true )
	ped = createPed ( 0, -693.64014, 919.16327, 12.26443, 90 )
	setCameraMatrix ( -695.71442, 916.42206, 12.28372, -693.64014, 919.16327, 12.26443 )
	bindKey ( "ENTER", "DOWN", acceptSkin )
end)


addEventHandler ( "onClientMouseEnter", root, function ()
	if getElementData ( source, "left" ) then
		guiSetVisible ( arrow[1], false )
		arrow[1] = guiCreateStaticImage(233*w, 307*h, 57*w, 43*h, "left_on.png", false)
		setElementData ( arrow[1], "left", true )
	end
	if getElementData ( source, "right" ) then
		guiSetVisible ( arrow[2], false )
		arrow[2] = guiCreateStaticImage(346*w, 307*h, 57*w, 43*h, "right_on.png", false)
		setElementData ( arrow[2], "right", true )
	end
end)

addEventHandler ( "onClientMouseLeave", root, function ()
	if getElementData ( source, "left" ) then
		guiSetVisible ( arrow[1], false )
		arrow[1] = guiCreateStaticImage(233*w, 307*h, 57*w, 43*h, "left_off.png", false)
		setElementData ( arrow[1], "left", true )
	end
	if getElementData ( source, "right" ) then
		guiSetVisible ( arrow[2], false )
		arrow[2] = guiCreateStaticImage(346*w, 307*h, 57*w, 43*h, "right_off.png", false)
		setElementData ( arrow[2], "right", true )
	end
end)

count = 0


addEventHandler ( "onClientGUIClick", root, function ()
	if getElementData ( source, "right" ) then
		if count == #valid then
			return
		end
		count = count + 1
		local skin = tonumber ( valid[count] )
		setElementModel ( ped, skin )
	end
	if getElementData ( source, "left" ) then
		if count == 0 then
			return
		end
		count = count - 1
		local skin = tonumber ( valid[count] )
		setElementModel ( ped, skin )
	end
end)


function acceptSkin ()
	setElementModel ( localPlayer, getElementModel ( ped ) )
	destroyElement ( ped )
	fadeCamera ( false )
	setTimer ( fadeCamera, 2000, 1, true )
	showCursor ( false )
	showChat ( true )
	showPlayerHudComponent ( "all", true )
	setCameraTarget ( localPlayer )
	for k,_ in ipairs ( arrow ) do
		guiSetVisible ( arrow[k], false )
	end
	outputChatBox ( "Shuffle życzy miłej gry!", 255, 255, 255 )
end
	
