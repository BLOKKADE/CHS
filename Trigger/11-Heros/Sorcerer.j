library Sorcerer initializer init requires RandomShit, AbilityData, CastSpellOnTarget
    globals
        Table SorcererAmount
    endglobals
    
    function SorcererPassive takes unit caster, integer hid returns nothing
        local integer i = 0
        local integer i2 = 0
        local integer abilId
        local unit target
        local integer orderType = 0
        local real range = 0

        loop
            set i = GetRandomInt(0,10)
            set abilId = GetInfoHeroSpell(caster, i)
            if IsAbilityCasteable(abilId,false) and IsSpellResettable(abilId) then
                call CastSpellAuto(caster, null, abilId, GetUnitAbilityLevel(caster, abilId), 0, 0, -1)
                set i2 = i2 + 1
                //call BJDebugMsg("casted " + GetObjectName(abilId) + " " + I2S(i2))
            endif
            exitwhen i2 == 1 + SorcererAmount[hid]
        endloop
        
        set target = null
    endfunction

    private function init takes nothing returns nothing
        set SorcererAmount = Table.create()
    endfunction

endlibrary