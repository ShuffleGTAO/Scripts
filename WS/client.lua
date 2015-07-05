b={}
b[1] = guiCreateButton(0.34, 0.72, 0.10, 0.09, "Następny skin", true)


b[2] = guiCreateButton(0.55, 0.72, 0.10, 0.09, "Akceptuj", true)


for k,_ in ipairs(b)do
	guiSetVisible(b[k],false)
end

ped={}

addEvent("onLogin",true)
addEventHandler("onLogin",root,function()
	if source==localPlayer then
		skins={}
		for k,_ in ipairs(b)do
			guiSetVisible(b[k],true)
		end
		showCursor(true)
		ped[source]=createPed(0,2510.98975, 2387.26147, 4.21094)
		for _,v in ipairs(getValidPedModels())do
			table.insert(skins,v)
		end
		setCameraMatrix(2511.10889, 2391.81299, 4.21094,2510.98145, 2388.65332, 4.21094)
		skin=0
	end
end)

addEventHandler("onClientGUIClick",root,function()
	if source==b[1] then
		if skin==#skins then
			skin=0
		end
		skin=skin+1
		setElementModel(ped[localPlayer],skins[skin])
		liczba=#skins-skin
	elseif source==b[2] then
		setElementModel(localPlayer,getElementModel(ped[localPlayer]))
		showCursor(false)
		fadeCamera(false,4)
		setTimer(setCameraTarget,4000,1,localPlayer)
		setTimer(fadeCamera,4000,1,true,4)
		for k,_ in ipairs(b)do
			guiSetVisible(b[k],false)
		end
		setTimer(destroyElement,4000,1,ped[localPlayer])
	end
end)