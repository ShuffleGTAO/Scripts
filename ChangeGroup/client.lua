mojeW,mojeH = 640, 480
sW,sH = guiGetScreenSize()
w, h = (sW/mojeW), (sH/mojeH)

button = {}


local groups = {
{ "Policja", 10, 0, 0, 255, id, ilosc naboi },
{ "Gang", 5, 255, 255, 255, id, ilosc naboi },
{ "Administracja", 3, 255, 0, 0, id, ilosc naboi },
}

local skins = {}

local grupa = groups[1][1]
local max = groups[1][2]
local r,g,b = groups[1][3], groups[1][4], groups[1][5]
local id = groups[1][6]
local ilosc = groups[1][7]

for k,_ in ipairs ( groups ) do
	triggerServerEvent ( "C:Teams", localPlayer, groups[k][1], groups[k][3], groups[k][4], groups[k][5] )
end


for _,v in ipairs ( getValidPedModels () ) do
	table.insert ( skins, v )
end


--prev group
button[1] = guiCreateButton(280*w, 111*h, 84*w, 36*h, "Następna\ngrupa\nMax osób : "..max.."", false)

--next skin
button[2] = guiCreateButton(280*w, 254*h, 84*w, 36*h, "Następny skin", false)


for k,_ in ipairs ( button ) do
	guiSetVisible ( button[k], false )
end

count = 1
number = 1

addEventHandler ( "onClientGUIClick", root, function ()
	if source == button[1] then
		if count == #groups then
			count = 0
		end
		count = count + 1
		grupa = groups[count][1]
		max = groups[count][2]
		r,g,b = groups[count][3], groups[count][4], groups[count][5]
		local id = groups[count][6]
		local ilosc = groups[count][7]
		guiSetText ( button[1], "Następna\ngrupa\nMax osób : "..max.."" )
	elseif source == button[2] then
		if number == #skins then
			number = 0
		end
		number = number + 1
		skin1 = skins[number]
		setElementModel ( ped, skin1 )
	end
end)

local function drawDX ()
	dxDrawText(grupa, 183*w, 45*h, 459*w, 102*h, tocolor(0, 0, 0, 255), 1.20*w, "beckett", "center", "center", false, false, true, false, false)
	dxDrawText(grupa, 182*w, 44*h, 458*w, 101*h, tocolor(r, g, b, 255), 1.20*w, "beckett", "center", "center", false, false, true, false, false)
	dxDrawText("Wybierz grupę :", 284*w, 14*h, 358*w, 35*h, tocolor(0, 0, 0, 255), 1.00*w, "arial", "left", "top", false, false, true, false, false)
	dxDrawText("Wybierz grupę :", 283*w, 13*h, 357*w, 34*h, tocolor(255, 255, 255, 255), 1.00*w, "arial", "left", "top", false, false, true, false, false)
	dxDrawText("Wybierz skin :", 285*w, 207*h, 359*w, 228*h, tocolor(0, 0, 0, 255), 1.00*w, "arial", "left", "top", false, false, true, false, false)
	dxDrawText("Wybierz skin :", 284*w, 206*h, 358*w, 227*h, tocolor(255, 255, 255, 255), 1.00*w, "arial", "left", "top", false, false, true, false, false)
end


addEventHandler ( "onClientResourceStart", resourceRoot, function ()
	for k,_ in ipairs ( button ) do
		guiSetVisible ( button[k], true )
	end
	addEventHandler ( "onClientRender", root, drawDX )
	showCursor ( true )
	showChat ( false )
	showPlayerHudComponent ( "all", false )
	ped = createPed ( 0, -671.21924, 941.46307, 18.33343 )
	setCameraMatrix ( -669.47278, 944.90448, 18.81047, -670.21924, 941.46307, 18.33343 )
	bindKey ( "ENTER", "DOWN", acceptSett )
end)


function acceptSett ()
	if #getPlayersInTeam ( getTeamFromName ( grupa ) ) > max then
		showChat ( true )
		return outputChatBox ( "W tej grupie jest już maksymalna ilość osób!" ) end
	local skin = tonumber ( getElementModel ( ped ) )
	for k,_ in ipairs ( button ) do
		guiSetVisible ( button[k], false )
	end
	removeEventHandler ( "onClientRender", root, drawDX )
	showCursor ( false )
	showChat ( true )
	showPlayerHudComponent ( "all", true )
	setCameraTarget ( localPlayer, localPlayer )
	triggerServerEvent ( "C:ChangeSkin", localPlayer, skin, grupa, r, g, b, id, ilosc )
	unbindKey ( "ENTER", "DOWN", acceptSett )
end