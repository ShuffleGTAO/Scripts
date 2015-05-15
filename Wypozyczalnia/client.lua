mojeW,mojeH = 640, 480
sW,sH = guiGetScreenSize()
width, height = (sW/mojeW), (sH/mojeH)

addEventHandler("onClientRender",root,function()
	local x, y, z = getCameraMatrix( )
	local dimension = getElementDimension( localPlayer )
	for key, vehicle in ipairs ( getElementsByType( "vehicle" ) ) do
		if getElementDimension( vehicle ) == dimension then
			local px, py, pz = getElementPosition( vehicle )
			local distance = getDistanceBetweenPoints3D( px, py, pz, x, y, z )
			if distance <= 20 then
				local text = getElementData( vehicle, "WypozyczalniaOpis" )
				if text and ( distance < 2 or isLineOfSightClear( x, y, z, px, py, pz + 1.1, true, false, false, true, false, true, true ) ) then
					local sx, sy = getScreenFromWorldPosition( px, py, pz+0.2 )
					if sx and sy then
						local w = dxGetTextWidth( tostring( text ) )
						local h = ( text and 2 or 1 ) * dxGetFontHeight( )
						local sin=math.sin(getTickCount()/400)*70
						local cos=math.sin(getTickCount()/400)*0.1
						dxDrawText( tostring( text ), sx+3, sy+30+3, sx, sy, tocolor( 0, 0, 0, 70+sin ), (1.3*width/2.5)+cos, "default", "center", "center" )
						dxDrawText( tostring( text ), sx, sy+30, sx, sy, tocolor( 255, 255, 255, 70+sin ), (1.3*width/2.5)+cos, "default", "center", "center",_,_,_,true )
					end
				end
			end
		end
	end	
end)






