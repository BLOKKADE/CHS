library LightRune requires RandomShit

    function CastLightRune takes nothing returns boolean
        if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) and IsUnitTarget(GetFilterUnit()) then
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", GetFilterUnit(), "origin"))  
            call UnitDamageTarget(GLOB_RUNE_U, GetFilterUnit(), (0.02 * GLOB_RUNE_POWER) * BlzGetUnitMaxHP(GLOB_RUNE_U), false, false, ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
        endif
        return false
    endfunction

    function LightRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call GroupEnumUnitsInRange(GL_GR,GetUnitX(u),GetUnitY(u),300 + 100 * power,Condition(function CastLightRune) )

        set u = null
        return false
    endfunction
endlibrary