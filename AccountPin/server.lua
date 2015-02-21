local db = dbConnect ( "sqlite", "pins.db" )


addEventHandler ( "onPlayerLogin", root, function ( _, konto )
	dbExec ( db, "CREATE TABLE IF NOT EXISTS Pins ( login VARCHAR, pin INTEGER )" )
	local q = dbQuery ( db, "SELECT * FROM Pins WHERE login = ?", getAccountName ( konto ) )
	local w = dbPoll ( q, -1 )
	dbFree ( q )
	if #w == 0 then
		setElementData ( source, "txt", "Wpisz Swój nowy PIN :" ) 
	elseif #w > 0 then
		setElementData ( source, "txt", "Wpisz Swój aktualny PIN :" )
	end
	triggerClientEvent ( "P:Open", source )
end)
	
	
addEvent ( "P:Check", true )
addEventHandler ( "P:Check", root, function ( zaw )
	if getElementData ( source, "txt" ) == "Wpisz Swój nowy PIN :" then
		dbExec ( db, "INSERT INTO `Pins` ( login, pin ) VALUES ( ?,? )", getAccountName ( getPlayerAccount ( source ) ), zaw )
		outputChatBox ( "Twój nowy PIN do konta "..getAccountName ( getPlayerAccount ( source ) ).." to : "..zaw, source, 255, 255, 255 )
		triggerClientEvent ( "P:Close", source )
	elseif getElementData ( source, "txt" ) == "Wpisz Swój aktualny PIN :" then
		local x = dbQuery ( db, "SELECT * FROM `Pins` WHERE login = ?", getAccountName ( getPlayerAccount ( source ) ) )
		local wynik = dbPoll ( x, -1 )
		dbFree ( x )
		for _,v in ipairs ( wynik ) do
			if tonumber(v.pin) == tonumber(zaw) then
				triggerClientEvent ( "P:Close", source )
			else
				triggerClientEvent ( "P:Error", source, "PIN do konta "..v.login.." jest inny niż "..zaw, source, 255, 255, 255 )
			end
		end
	end
end)