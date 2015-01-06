

local conn = dbConnect ( "sqlite", "db.db" )

addEventHandler ( "onResourceStart", resourceRoot, function ()
	if conn then
		dbExec ( conn, "CREATE TABLE IF NOT EXISTS OP_Vehicles(model INTEGER, posx FLOAT, posy FLOAT, posz FLOAT, rotx FLOAT, roty FLOAT, rotz FLOAT, color1 INTEGER, color2 INTEGER, color3 INTEGER, color4 INTEGER)" )
		local q = dbQuery ( conn, "SELECT * FROM OP_Vehicles" )
		local result = dbPoll ( q, -1 )
		if result then
			for _,v in pairs ( result ) do
				local auto = createVehicle ( v["model"], v["posx"], v["posy"], v["posz"], v["rotx"], v["roty"], v["rotz"] )
				setVehicleColor ( auto, v["color1"], v["color2"], v["color3"], v["color4"] )
			end
		end
	end
end)


addCommandHandler ( "zapisz", function ( plr )
	dbQuery ( conn, "DELETE FROM OP_Vehicles" )
	for _,v in ipairs ( getElementsByType ( "vehicle" ) ) do
		local pojazdID = getElementModel ( v )
		local c1,c2,c3,c4 = getVehicleColor ( v )
		local x,y,z = getElementPosition ( v )
		local rotx, roty, rotz = getElementRotation ( v )
		dbQuery ( conn, "INSERT INTO OP_Vehicles (model, posx, posy, posz, rotx, roty, rotz, color1, color2 ,color3, color4 ) VALUES ( ?,?,?,?,?,?,?,?,?,?,? )", pojazdID, x, y, z, rotx, roty, rotz, c1, c2, c3, c4 )
	end
end)
