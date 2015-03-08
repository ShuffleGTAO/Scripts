local keys = {
{ "q" },
{ "w" },
{ "e" },
{ "r" },
{ "a" },
{ "p" },
{ "u" },
{ "i" },
{ "o" },
{ "s" },
{ "d" },
{ "f" },
{ "g" },
{ "h" },
{ "j" },
{ "k" },
{ "l" },
{ "z" },
{ "x" },
{ "c" },
{ "v" },
{ "b" },
{ "n" },
{ "m" },
}

rnd={}

string_id = "id"

function randomPlate (veh,type)
	if not veh then return outputDebugString("Brak uwzględnionego pojazdu.",2) end
	if not type then return outputDebugString("Brak uwzględnionego typu(1:Losowe znaki ; 2:ID pojazdu)",2) end
	if type==1 then
		rnd[1]=math.random(1,#keys)
		rnd[2]=math.random(1,#keys)
		rnd[3]=math.random(1,#keys)
		rnd[4]=math.random(1,#keys)
		rnd[5]=math.random(1,#keys)
		local txt=keys[rnd[1]][1]..""..keys[rnd[2]][1]..""..keys[rnd[3]][1]..""..keys[rnd[4]][1]..""..keys[rnd[5]][1]
		setVehiclePlateText (veh," "..txt)
		outputDebugString ("Pojazdowi "..getVehicleName(veh).." nadano rejestrację : "..string.upper(txt))
	elseif type==2 then
		local id=tonumber(getElementData(veh,string_id))
		if not id then outputDebugString("Pojazd "..getVehicleName(veh).." nie posiada nadanego ID pod wartością : `"..string_id.."` Ustawiono mu standardowe ID : 0",2)
		setElementData(veh,string_id,0)
		return setVehiclePlateText ( veh,"ID : 0") end
		setVehiclePlateText ( veh,"ID : "..id)
	end
end

			