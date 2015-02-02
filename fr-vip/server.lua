local dbname = "x"
local host = "x"
local username = "x"
local pass = "x"



local db = dbConnect("mysql", "dbname="..dbname..";host="..host.."", ""..username.."",""..pass.."","share=1")



local function checkVips ()
	local q = dbQuery ( db, "SELECT * FROM FR_Vipy" )
	local w = dbPoll ( q, -1 )
	dbFree ( q )
	local time = getRealTime ()
	month = time.month + 1
	year = time.year + 1900
	if time.hour < 10 then
		time.hour = "0"..time.hour
	end
	if time.minute < 10 then
		time.minute = "0"..time.minute
	end
	if time.second < 10 then
		time.second = "0"..time.second
	end
	if month < 10 then
		month = "0"..month
	end
	if time.monthday < 10 then
		time.monthday = "0"..time.monthday
	end
	local czas = ""..year.."-"..month.."-"..time.monthday.." "..time.hour..":"..time.minute..":"..time.second..""
	for _,v in ipairs ( w ) do
		if v.Termin == czas then
			gracz = getPlayerFromName ( v.Login )
			dbExec ( db, "DELETE FROM FR_Vipy WHERE Login = ?", v.Login )
		end
	end
	if gracz then
		outputChatBox ( "Twój termin ważności dla konta "..getPlayerName ( gracz ).." VIP minął!", gracz, 255, 255, 255 )
		gracz = false or nil
	end
end
setTimer ( checkVips, 1000, 0 )


local function isVip ( login )
	local query = dbQuery ( db, "SELECT * FROM FR_Vipy" )
	local wynik = dbPoll ( query, -1 )
	dbFree ( query )
	tablica = {}
	for _,v in ipairs ( wynik ) do
		table.insert ( tablica, v )
	end
	if #tablica == 0 then
		return false
	elseif #tablica > 0 or #tablica < 0 then
		return true
	end
	return false
end


addCommandHandler ( "daj.vip", function ( plr, cmd, gracz, rok, miesiac, dzien, godzina, minuta, sekunda )
	if rok and miesiac and dzien and godzina and minuta and sekunda then
		if isVip ( gracz ) then
			return outputChatBox ( "Gracz "..gracz.." posiada już rangę VIP", plr, 255, 255, 255 )
		end
		local time = getRealTime()
		local y = time.year + 1900
		if tonumber(rok) < tonumber(y) then
			return outputChatBox ( "Rok nie może być mniejszy niż "..y, plr, 255, 255, 255 )
		end
		if tonumber(miesiac) > tonumber(12) or tonumber(miesiac) < tonumber(1) then
			return outputChatBox ( "Zakres miesiąca to 1-12", plr, 255, 255, 255 )
		end
		if tonumber ( dzien ) > tonumber ( 31 ) or tonumber( dzien ) < tonumber ( 1 ) then
			return outputChatBox ( "Zakres dnia miesiąca to 1-31", plr, 255, 255, 255 )
		end
		if tonumber ( godzina ) == 24 then
			return outputChatBox ( "Zakres godzin to 0-23", plr, 255, 255, 255 )
		end
		if tonumber ( minuta ) == 60 then
			return outputChatBox ( "Zakres minut to 0-59", plr, 255, 255, 255 )
		end
		if tonumber ( sekunda ) == 60 then
			return outputChatBox ( "Zakres sekund to 0-59", plr, 255, 255, 255 )
		end
		if tonumber(miesiac) < 10 then
			miesiac = "0"..tonumber(miesiac)
		end
		if tonumber( dzien ) < 10 then
			dzien = "0"..tonumber( dzien )
		end
		if tonumber ( sekunda ) < 10 then
			sekunda = "0"..tonumber ( sekunda )
		end
		if tonumber ( minuta ) < 10 then
			minuta = "0"..tonumber ( minuta )
		end
		local data = ""..rok.."-"..miesiac.."-"..dzien.." "..godzina..":"..minuta..":"..sekunda..""
		x = dbExec ( db, "INSERT INTO FR_Vipy ( Login, Termin ) VALUES ( ?,? )", gracz, data )
		if x then
			outputChatBox ( "Nadano rangę VIP dla gracza "..gracz.." do dnia "..data, plr, 0, 255, 0 )
		end
	end
end)