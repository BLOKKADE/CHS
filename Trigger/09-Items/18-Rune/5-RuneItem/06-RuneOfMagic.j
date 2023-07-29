library MagicRune requires RandomShit
    globals
        constant real RuneOfMagic_base = 5
    endglobals

    function RuneOfMagic takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        local integer i1 = 0
        local integer SpellId = 0
        local integer dummyspell = 0
        
        loop
            exitwhen i1 > 10
            set SpellId = GetHeroSpellAtPosition(u ,i1)
            set dummyspell = GetDummySpellId(SpellId)
            if IsSpellResettable(SpellId) then
                if BlzGetUnitAbilityCooldownRemaining(u,SpellId) < RuneOfMagic_base * power then
                    call BlzEndUnitAbilityCooldown(u,SpellId)
                    call BlzEndUnitAbilityCooldown(u,GetDummySpellId(u, SpellId))
                elseif BlzGetUnitAbilityCooldownRemaining(u,SpellId) > 0 then
                    call BlzStartUnitAbilityCooldown(u,SpellId,BlzGetUnitAbilityCooldownRemaining(u,SpellId)- RuneOfMagic_base * power )
                    call BlzStartUnitAbilityCooldown(u,GetDummySpellId(u, SpellId),BlzGetUnitAbilityCooldownRemaining(u,GetDummySpellId(u, SpellId))- RuneOfMagic_base * power )
                endif
            endif
            set i1 = i1 + 1
        endloop
    
        set u = null
        return false
    endfunction
endlibrary