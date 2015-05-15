local db=dbConnect("sqlite","tp.db")
dbExec(db,"CREATE TABLE IF NOT EXISTS `TP` ( ID INTEGER, x INTEGER, y INTEGER, z INTEGER )")



addEvent("TP:Usun",true)
addEventHandler("TP:Usun",root,function()
	local q=dbQuery(db,"SELECT * FROM `TP` WHERE `ID`=?",1)
	local w=dbPoll(q,-1)
	dbFree(q)
	if #w==0 then
		return outputChatBox("*Brak zapisanych teleportacji.",source,255,255,255)
	end
	dbExec(db,"DELETE FROM `TP`")
	outputChatBox("*Teleport został usunięty.",source,255,255,255)
end)

addEvent("TP:Dodaj",true)
addEventHandler("TP:Dodaj",root,function(x,y,z)
	local q=dbQuery(db,"SELECT * FROM `TP` WHERE `ID`=?",1)
	local w=dbPoll(q,-1)
	dbFree(q)
	if #w>0 then
		return outputChatBox("*W bazie jest już zapisany teleport.",source,255,255,255)
	end
	dbExec(db,"INSERT INTO `TP` (ID,x,y,z) VALUES (?,?,?,?)",1,x,y,z)
	local miasto=getZoneName(x,y,z)
	local strefa=getZoneName(x,y,z,true)
	for _,v in ipairs(getElementsByType("player"))do
		outputChatBox("*Dodano teleport do miejsca : "..miasto..","..strefa..". Aby się przenieść wpisz /teleportuj",v,255,255,255)
	end
end)


addCommandHandler("teleportuj",function(plr)
	local q=dbQuery(db,"SELECT * FROM `TP` WHERE `ID`=?",1)
	local w=dbPoll(q,-1)
	dbFree(q)
	if #w==0 then
		return outputChatBox("*Brak ustawionych teleportacji.",plr,255,255,255)
	end
	setElementPosition(plr,w[1].x,w[1].y,w[1].z)
	outputChatBox("*Zostałeś(aś) przeniesiony do miejsca wyznaczonego przez admina.",plr,255,255,255)
end)