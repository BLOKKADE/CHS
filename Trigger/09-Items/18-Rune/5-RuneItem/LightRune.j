library LightRune requires RandomShit, UnitHelpers

    function CastLightRune takes nothing returns boolean
        if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) and IsUnitTarget(GetFilterUnit()) then
            call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", GetFilterUnit(), "origin"))  
            set udg_NextDamageAbilitySource = 'I0AW'
            call Damage.applyMagic(GLOB_RUNE_U, GetFilterUnit(), (0.03 * GLOB_RUNE_POWER) * BlzGetUnitMaxHP(GLOB_RUNE_U), false, DAMAGE_TYPE_MAGIC)
        endif
        return false
    endfunction

    function LightRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,GetUnitX(u),GetUnitY(u),300 + 100 * power,Condition(function CastLightRune) )

        set u = null
        return false
    endfunction
endlibrary