library Sorcerer initializer init requires RandomShit, AbilityData, CastSpellOnTarget
    globals
        Table SorcererAmount
    endglobals

    function StableActiveCheck takes unit u returns boolean
        local integer i = 0
        local integer abilId = 0
        local integer count = 0
        loop
            set abilId = GetInfoHeroSpell(u, i)
            if abilId != 0 and IsAbilityCasteable(abilId, true) and IsSpellResettable(abilId) then
                set count = count + 1
            endif
            set i = i + 1
            exitwhen i > 10
        endloop

        if count >= 1 then
            return true
        else 
            return false
        endif
    endfunction

    
    function SorcererPassive takes unit caster, integer hid returns nothing
        local integer i = 0
        local integer i2 = 0
        local integer abilId
        local unit target
        local integer orderType = 0
        local real range = 0
        
        if StableActiveCheck(caster) then
            loop
                set i = GetRandomInt(1,10)
                set abilId = GetInfoHeroSpell(caster, i)
                if IsAbilityCasteable(abilId,false) and IsSpellResettable(abilId) then
                    call CastSpellAuto(caster, null, abilId, GetUnitAbilityLevel(caster, abilId), 0, 0, 600)
                    set i2 = i2 + 1
                    //call BJDebugMsg("casted " + GetObjectName(abilId) + " " + I2S(i2))
                endif
                exitwhen i2 == 1 + SorcererAmount[hid]
            endloop
        endif
        
        set target = null
    endfunction

    private function init takes nothing returns nothing
        set SorcererAmount = Table.create()
    endfunction

endlibrary