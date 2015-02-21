mojeW,mojeH = 640, 480
sW,sH = guiGetScreenSize()
w, h = (sW/mojeW), (sH/mojeH)




ok = guiCreateButton(256*w, 284*h, 116*w, 28*h, "Akceptuj", false)
guiSetVisible ( ok, false )


edit_pin = guiCreateEdit(243*w, 212*h, 139*w, 25*h, "", false)
guiSetVisible ( edit_pin, false )

info = guiCreateLabel(138*w, 51*h, 382*w, 36*h, "", false)
guiLabelSetColor(info, 183, 0, 0)
guiLabelSetHorizontalAlign(info, "center", false)
guiLabelSetVerticalAlign(info, "center")

guiSetVisible ( info, false )




addEvent ( "P:Open", true )
addEventHandler ( "P:Open", root, function ( type )
	if source ~= localPlayer then return end
	guiSetVisible ( ok, true )
	guiSetVisible ( edit_pin, true )
	guiSetVisible ( info, true )
	addEventHandler ( "onClientRender", root, drawDX )
	showCursor ( true )
	showChat ( false )
	fadeCamera ( false )
end)

function drawDX ()
	text = getElementData ( localPlayer, "txt" )
	dxDrawText(text, 257*w, 134*h, 373*w, 184*h, tocolor(0, 0, 0, 255), 1.00*w, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText(text, 257*w, 132*h, 373*w, 182*h, tocolor(0, 0, 0, 255), 1.00*w, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText(text, 255*w, 134*h, 371*w, 184*h, tocolor(0, 0, 0, 255), 1.00*w, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText(text, 255*w, 132*h, 371*w, 182*h, tocolor(0, 0, 0, 255), 1.00*w, "pricedown", "center", "center", false, false, true, false, false)
	dxDrawText(text, 256*w, 133*h, 372*w, 183*h, tocolor(255, 255, 255, 255), 1.00*w, "pricedown", "center", "center", false, false, true, false, false)
end

local function error ( txt )
	guiSetText ( info, txt )
end

addEventHandler ( "onClientGUIClick", root, function ()
	if source == ok then
		local zaw = guiGetText ( edit_pin )
		if zaw == "" then return error ( "PIN musi zawierać 4 znaki!" ) end
		if string.len ( zaw ) < 4 then return error ( "PIN musi zawierać 4 znaki!" ) end
		if type(tonumber(zaw)) ~= "number" then return error ( "PIN musi składać się z liczb!" ) end
		triggerServerEvent ( "P:Check", localPlayer, zaw )
	end
end)

addEvent ( "P:Close", true )
addEventHandler ( "P:Close", root, function ()
	if source == localPlayer then 
		guiSetVisible ( ok, false )
		guiSetVisible ( edit_pin, false )
		removeEventHandler ( "onClientRender", root, drawDX )
		fadeCamera ( true )
		showCursor ( false )
		guiSetVisible ( info, false )
		showChat ( true )
	end
end)


addEvent ( "P:Error", true )
addEventHandler ( "P:Error", root, function ( tekst )
	guiSetText ( info, tekst )
end)
	