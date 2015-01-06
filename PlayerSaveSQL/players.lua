local polaczenie = dbConnect ( "sqlite", "db.db" )

addCommandHandler ( "player", function ( plr )
	if polaczenie then
		konto = getPlayerAccount ( plr )
		dbExec ( polaczenie, "CREATE TABLE IF NOT EXISTS OP_Players ( login VARCHAR, skin INTEGER, portfel INTEGER, interior INTEGER, dimension INTEGER, punkty INTEGER, posx FLOAT, posy FLOAT, posz FLOAT )" )
		local zapytanie = dbQuery ( polaczenie, "SELECT login FROM OP_Players WHERE login = ?", getPlayerName ( plr ) )
		local wynik = dbPoll ( zapytanie, -1 )
		dbFree ( zapytanie )
		local x,y,z = getElementPosition ( plr )
		local punkty = getAccountData ( konto, "punkty" ) or 0
		if #wynik == 0 then
			dbQuery ( polaczenie, "INSERT INTO OP_Players ( login, skin, portfel, interior, dimension, punkty, posx, posy, posz ) VALUES ( ?,?,?,?,?,?,?,?,? )", getPlayerName ( plr ), getElementModel ( plr ), getPlayerMoney ( plr ), getElementInterior ( plr ), getElementDimension ( plr ), punkty, x, y, z )
		elseif #wynik == 1 then
			dbQuery ( polaczenie, "UPDATE OP_Players SET skin = '?', portfel = '?', interior = '?', dimension = '?', punkty = '?', posx = '?', posy = '?', posz = '?' WHERE login = ?", getElementModel ( plr ), getPlayerMoney ( plr ), getElementInterior ( plr ), getElementDimension ( plr ), punkty, x, y, z, getPlayerName ( plr ) )
		end
	end
end)

addCommandHandler ( "wczytaj", function ( plr )
	if polaczenie then
		local zapis = dbQuery ( polaczenie, "SELECT * FROM OP_Players WHERE login = ?", getPlayerName ( plr ) )
		local result = dbPoll ( zapis, -1 )
		dbFree ( zapis )
		if #result == 0 then
			outputChatBox ( "Twoje dane nie zostały wczytane ponieważ nie znajdują się w bazie danych. Po wyjściu z serwera zostaną one wgrane", plr, 255, 255, 255 )
		return end
		for _,v in ipairs ( result ) do
			setElementPosition ( plr, v.posx, v.posy, v.posz )
			setPlayerMoney ( plr, v.portfel )
			setElementInterior ( plr, v.interior )
			setElementDimension ( plr, v.dimension )
			setElementModel ( plr, v.skin )
			setAccountData ( getPlayerAccount ( plr ), "punkty", v.punkty )
		end
	end
end)