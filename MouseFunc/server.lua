
local function repairCar ( player, veh )
	fixVehicle ( veh )
	outputChatBox ( "Pojazd "..getVehicleName ( veh ).." został naprawiony.", player, 255, 255, 255 )
end

local function destroyCar ( player, veh )
	destroyElement ( veh )
	outputChatBox ( "Pojazd "..getVehicleName ( veh ).." został zniszczony.", player, 255, 255, 255 )
end


addEventHandler ( "onElementClicked", root, function ( button, state, player )
	if state == "down" then
		if getElementType ( source ) == "vehicle" then
			if button == "left" then
				repairCar ( player, source )
			elseif button == "right" then
				destroyCar ( player, source )
			end
		end
	end
end)

