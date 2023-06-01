library DebugAbilities
    function GetAllAbilities takes unit u returns nothing
        local integer abilId
        local integer i = 0
        local string s = ""
        loop
            set abilId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(u, i))
            exitwhen abilId == 0
            set s = s + GetObjectName(abilId) + ", "
            
    
            set i = i + 1
        endloop

        call BJDebugMsg(s)
    endfunction
endlibrary
