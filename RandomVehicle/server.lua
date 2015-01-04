--Copyright by Shuffle--
--gtao.pl--
--OwnPlay RPG/RP--




function getRandomVehicle ()
    los = {}
        for k,v in ipairs ( getElementsByType ( vehicle ) ) do
            table.insert ( los, v )
        end
        rnd = math.random ( #los )
        return los[rnd]
end