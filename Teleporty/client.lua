
mojeW,mojeH = 640, 480
sW,sH = guiGetScreenSize()
w, h = (sW/mojeW), (sH/mojeH)


local r1,g1,b1=255,0,0
local r2,g2,b2=255,0,0
local r3,g3,b3=255,0,0
local r4,g4,b4=255,0,0

active={}
active.text=false


edit = {}
okno={}
    okno.glowne = guiCreateGridList(106*w, 147*h, 387*w, 222*h, false)
    guiSetAlpha(okno.glowne, 0.88)
    guiSetVisible(okno.glowne,false)

    edit.x = guiCreateEdit(51*w, 62*h, 78*w, 18*h, "X", false, okno.glowne)
    edit.y = guiCreateEdit(156*w, 62*h, 78*w, 18*h, "Y", false, okno.glowne)
    edit.z = guiCreateEdit(268*w, 62*h, 78*w, 18*h, "Z", false, okno.glowne)   
    button1 = guiCreateButton(27*w, 117*h, 92*w, 27*h, "", false, okno.glowne)
    button2 = guiCreateButton(146*w, 117*h, 92*w, 27*h, "", false, okno.glowne)
    button3 = guiCreateButton(258*w, 117*h, 92*w, 27*h, "", false, okno.glowne)
    button4 = guiCreateButton(142*w, 171*h, 92*w, 27*h, "", false, okno.glowne)   
    guiSetAlpha(button1,0)
    guiSetAlpha(button2,0)
    guiSetAlpha(button3,0)
    guiSetAlpha(button4,0)


addEventHandler("onClientRender",root,function()
    if active.text then
        dxDrawRectangle(75*w, 157*h, 450*w, 25*h, tocolor(255, 0, 0, 255), true)
        dxDrawText("Panel interakcji teleportami", 74*w, 157*h, 525*w, 182*h, tocolor(255, 255, 255, 255), 1.50*w, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawRectangle(135*w, 264*h, 93*w, 27*h, tocolor(r1,g1,b1, 255), true)
        dxDrawRectangle(250*w, 264*h, 93*w, 27*h, tocolor(r2,g2,b2, 255), true)
        dxDrawRectangle(366*w, 264*h, 93*w, 27*h, tocolor(r3,g3,b3, 255), true)
        dxDrawText("Ustaw TP", 134*w, 264*h, 228*w, 291*h, tocolor(255, 255, 255, 255), 1.00*w, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText("Pobierz aktualną\npozycję", 249*w, 264*h, 343*w, 291*h, tocolor(255,255,255, 255), 0.70*w, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText("Usuń TP", 365*w, 264*h, 459*w, 291*h, tocolor(255,255,255, 255), 1.00*w, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawRectangle(249*w, 319*h, 93*w, 27*h, tocolor(r4,g4,b4, 255), true)
        dxDrawText("Zamknij", 248*w, 319*h, 342*w, 346*h, tocolor(255,255,255, 255), 1.00*w, "default-bold", "center", "center", false, false, true, false, false)
    end
end)


addCommandHandler("tp",function()
    if not active.text then
        guiSetVisible(okno.glowne,true)
        active.text=true
        showCursor(true)
        guiSetText(edit.x,"X")
        guiSetText(edit.y,"Y")
        guiSetText(edit.z,"Z")
    end
end)

addEventHandler("onClientMouseEnter",root,function()
    if source==button1 then
        r1,g1,b1=0,255,0
    elseif source==button2 then
        r2,g2,b2=0,255,0
    elseif source==button3 then
        r3,g3,b3=0,255,0
    elseif source==button4 then
        r4,g4,b4=0,255,0
    end
end)

addEventHandler("onClientMouseLeave",root,function()
    if source==button1 then
        r1,g1,b1=255,0,0
    elseif source==button2 then
        r2,g2,b2=255,0,0
    elseif source==button3 then
        r3,g3,b3=255,0,0
    elseif source==button4 then
        r4,g4,b4=255,0,0
    end
end)


addEventHandler("onClientGUIClick",root,function()
    if source==button4 then
        guiSetVisible(okno.glowne,false)
        active.text=false
        showCursor(false)
    elseif source==button2 then
        local x,y,z=getElementPosition(localPlayer)
        guiSetText(edit.x,math.floor(x))
        guiSetText(edit.y,math.floor(y))
        guiSetText(edit.z,math.floor(z))
    elseif source==button3 then
        triggerServerEvent("TP:Usun",localPlayer)
    elseif source==button1 then
        local x,y,z=guiGetText(edit.x),guiGetText(edit.y),guiGetText(edit.z)
        triggerServerEvent("TP:Dodaj",localPlayer,x,y,z)
    end
end)