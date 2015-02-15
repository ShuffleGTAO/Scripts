addEvent ( "ChangeSkin", true )
addEventHandler ( "ChangeSkin", root, function ( skin )
	setElementModel ( source, tonumber ( skin ) )
end)