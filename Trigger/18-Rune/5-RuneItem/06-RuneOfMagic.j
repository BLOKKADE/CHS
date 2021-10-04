library MagicRune requires RandomShit
    globals
        constant real RuneOfMagic_base = 10
    endglobals


    function RuneOfMagic takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        local integer i1 = 0
        local integer SpellId = 0
        
        loop
            exitwhen i1 > 10
            set SpellId = GetInfoHeroSpell(u ,i1)
            if BlzGetUnitAbilityCooldownRemaining(u,SpellId) < RuneOfMagic_base * power then
                call BlzEndUnitAbilityCooldown(u,SpellId)
            elseif BlzGetUnitAbilityCooldownRemaining(u,SpellId)> 0 then
                call BlzStartUnitAbilityCooldown(u,SpellId,BlzGetUnitAbilityCooldownRemaining(u,SpellId)- RuneOfMagic_base * power )
            endif
            set i1 = i1 + 1
        endloop
    
        set u = null
        return false
    endfunction
endlibrary